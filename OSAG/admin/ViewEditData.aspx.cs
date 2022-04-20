using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                        "M_State AS 'State', MemberType AS 'AccessLevel', IsApproved FROM Member";
                    sqlsrcData.UpdateCommand = "UPDATE Member SET FirstName = @FirstName," +
                        "LastName = @LastName, City = @City, M_State = @State, " +
                        "MemberType = @AccessLevel, IsApproved = @IsApproved " +
                        "WHERE MemberID = @ID";
                    MemberTypeKey.Visible = true;
                    break;
                case "Company":
                    sqlsrcData.SelectCommand = "SELECT CompanyID AS 'ID', CompanyName AS 'Company', WebsiteURL, City FROM Company";
                    sqlsrcData.UpdateCommand = "UPDATE Company SET CompanyName = @Company, WebsiteURL = @WebsiteURL, City = @City WHERE CompanyID = @ID";
                    break;
                case "Contact":
                    sqlsrcData.SelectCommand = "SELECT * FROM Contact";
                    sqlsrcData.UpdateCommand = "UPDATE table SET col = @col WHERE id = @id";
                    break;
                case "Student":
                    sqlsrcData.SelectCommand = "SELECT * FROM Student";
                    sqlsrcData.UpdateCommand = "UPDATE table SET col = @col WHERE id = @id";
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
        }

        protected void grdvwData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
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
    }
}