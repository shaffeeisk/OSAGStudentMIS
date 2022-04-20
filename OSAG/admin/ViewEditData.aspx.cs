using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace OSAG.admin
{
    public partial class ViewEditData : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Username"] = "admin";
            Session["UserType"] = "member";
            Session["MemberType"] = 1;

            switch (ddlSelectTable.SelectedValue)
            {
                case "Member":
                    sqlsrcData.SelectCommand = "SELECT MemberID AS 'ID', Username, FirstName, LastName, City, " +
                        "M_State AS 'State', MemberType AS 'AccessLevel', IsApproved AS 'Approved' FROM Member";
                    sqlsrcData.UpdateCommand = "UPDATE Member SET Username = @Username, FirstName = @FirstName," +
                        "LastName = @LastName, City = @City, M_State = @State, " +
                        "MemberType = @AccessLevel, IsApproved = @Approved " +
                        "WHERE MemberID = @ID";
                    MemberTypeKey.Visible = true;
                    DivViewProfile.Visible = true;
                    break;
                case "Student":
                    sqlsrcData.SelectCommand = "SELECT StudentID AS 'ID', Username, FirstName, LastName, IsApproved AS 'Approved' FROM Student";
                    sqlsrcData.UpdateCommand = "UPDATE Student SET Username=@Username, FirstName  = @FirstName," +
                        "LastName = @LastName, IsApproved = @Approved WHERE StudentID = @ID";
                    DivDownloadButtons.Visible = true;
                    DivViewProfile.Visible = true;
                    break;
                case "Company":
                    sqlsrcData.SelectCommand = "SELECT CompanyID AS 'ID', CompanyName AS 'Company', WebsiteURL, City FROM Company";
                    sqlsrcData.UpdateCommand = "UPDATE Company SET CompanyName = @Company, WebsiteURL = @WebsiteURL, City = @City WHERE CompanyID = @ID";
                    break;
                case "Contact":
                    sqlsrcData.SelectCommand = "SELECT ContactID AS 'ID', FirstName, LastName, Email, CompanyName " +
                        "FROM Contact con JOIN Company com ON con.CompanyID = com.CompanyID";
                    sqlsrcData.UpdateCommand = "UPDATE Contact SET FirstName = @FirstName, LastName = @LastName, " +
                        "Email = @Email WHERE ContactID = @ID";
                    break;
                case "Major":
                    sqlsrcData.SelectCommand = "SELECT * FROM Major";
                    sqlsrcData.UpdateCommand = "UPDATE table SET col = @col WHERE id = @id";
                    break;
                case "Announcement":
                    sqlsrcData.SelectCommand = "SELECT * FROM Announcement";
                    sqlsrcData.UpdateCommand = "UPDATE table SET col = @col WHERE id = @id";
                    break;
                case "Scholarship":
                    sqlsrcData.SelectCommand = "SELECT * FROM Scholarship";
                    sqlsrcData.UpdateCommand = "UPDATE table SET col = @col WHERE id = @id";
                    break;
                default:
                    break;
            }
        }

        protected void ddlSelectTable_SelectedIndexChanged(object sender, EventArgs e)
        {
            grdvwData.DataBind();

            if (ddlSelectTable.SelectedValue != "Member")
                MemberTypeKey.Visible = false;
            if (ddlSelectTable.SelectedValue != "Student")
                DivDownloadButtons.Visible = false;
            if (ddlSelectTable.SelectedValue != "Member" && ddlSelectTable.SelectedValue != "Student")
                DivViewProfile.Visible = false;
        }

        protected void grdvwData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            grdvwData.SelectedIndex = -1;
            foreach (TableCell c in e.Row.Cells)
            {
                if (DateTime.TryParse(c.Text, out DateTime dt)) // when in view mode
                    c.Text = dt.ToString("M/d/yyyy");
                else if (c.HasControls())
                {
                    if (c.Controls[0] is TextBox) // when in edit mode
                    {
                        TextBox txt = c.Controls[0] as TextBox;
                        if (DateTime.TryParse(txt.Text, out DateTime dt2))
                            txt.Text = dt2.ToString("M/d/yyyy");
                    }
                }
            }
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            string dbFile = ((Button)sender).Text.ToLower();
            dbFile = char.ToUpper(dbFile[0]) + dbFile.Substring(1);

            if(grdvwData.SelectedIndex == -1)
            {
                lblError.Text = "No student selected";
                return;
            }

            byte[] DownloadFile = getDBFileBytes(grdvwData.SelectedRow.Cells[2].Text, dbFile);
            if (DownloadFile == null)
            {
                lblError.Text = dbFile + " has not uploaded by selected student.";
                return;
            }

            // can change file download name, simply change content of filename= below
            // cannot use original file name unless it is stored when uploading.
            Response.AddHeader("content-disposition", "attachment;filename=" + dbFile + "_" + grdvwData.SelectedRow.Cells[2].Text + "_saved.pdf");
            Response.ContentType = "application/octectstream";
            Response.BinaryWrite(DownloadFile);
            Response.End();
        }

        protected void btnViewProfile_Click(object sender, EventArgs e)
        {
            if (grdvwData.SelectedIndex == -1)
                return;
            Session["ViewProfileUsername"] = grdvwData.SelectedRow.Cells[2].Text;
            Session["ViewProfileUserType"] = ddlSelectTable.SelectedValue.ToLower();
            Session["AdminRedirect"] = "not null";
            Response.Write("<script>window.open('/profiles/ViewProfile.aspx')</script>");
        }

        // helper method that queries for resume file and returns byte array
        protected byte[] getDBFileBytes(string username, string dbFile)
        {
            byte[] fileBytes;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("SELECT " + dbFile + "File FROM Student WHERE Username = @Username;", sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", username);
            sqlConnect.Open();
            SqlDataReader reader = sqlCommand.ExecuteReader();
            reader.Read();
            if (reader[dbFile + "File"] == DBNull.Value)
                return null;
            fileBytes = new byte[(reader.GetBytes(0, 0, null, 0, int.MaxValue))];
            reader.GetBytes(0, 0, fileBytes, 0, fileBytes.Length);
            sqlConnect.Close();
            return fileBytes;
        }
    }
}