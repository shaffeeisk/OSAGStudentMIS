using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// sql imports
using System.Data;
using System.Data.SqlClient;
// web.config imports
using System.Web.Configuration;
// colored response import
using System.Drawing;

namespace OSAG.admin
{
    public partial class AssignMentor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // make it seem like the page generates itself once a student is selected
            if (IsPostBack && lstStudents.SelectedIndex != -1)
            {
                lblMember.Visible = true;
                ddlMember.Visible = true;
                btnUpdate.Visible = true;
            }
            else // first page load only nothing shows up
            {
                lblMember.Visible = false;
                ddlMember.Visible = false;
                btnUpdate.Visible = false;
            }
        }

        // updates DB with mentorship
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            String sqlQuery = "INSERT INTO Mentorship (StudentID, MemberID) VALUES (@StudentID, @MemberID);";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            if (Int32.TryParse(ddlMember.SelectedValue, out int mID)) // button clicked with existing mentor
                sqlCommand.Parameters.AddWithValue("@MemberID", mID); // default of DDL is empty string
            else // escape, do not let query execute
                return;
            sqlCommand.Parameters.AddWithValue("@StudentID", lstStudents.SelectedValue.ToString());
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblUpdateStatus.Text = "Member assignment successful.";
            // refreshes gridview & DDL since DataBind() makes it disappear
            lstStudents_SelectedIndexChanged(sender, e);
        }

        // change member & mentorship lists to reflect selected student
        protected void lstStudents_SelectedIndexChanged(object sender, EventArgs e)
        {
            sqlsrcMentorships.SelectCommand =
                "SELECT FirstName + ' ' + LastName AS FullName, EndDate, x.MemberID " +
                "FROM Member x JOIN Mentorship y ON x.MemberID = y.MemberID " +
                "WHERE StudentID = '" + lstStudents.SelectedValue + "' " +
                "AND (IsRequest != 1 OR IsRequest IS NULL);";
            sqlsrcMemberList.SelectCommand =
                "WITH listMentors AS (" +
                "(SELECT MemberID, FirstName AS MemberName FROM Member WHERE LastName IS NULL) " +
                "UNION (SELECT MemberID, LastName AS MemberName FROM Member WHERE FirstName IS NULL) " +
                "UNION (SELECT MemberID, FirstName + ' ' + LastName AS MemberName FROM Member WHERE FirstName + LastName IS NOT NULL)) " +
                "SELECT * FROM listMentors WHERE MemberID NOT IN " +
                "(SELECT MemberID FROM Mentorship WHERE StudentID = '" + lstStudents.SelectedValue + "');";
        }

        // processes EndDate into mentorship status (active/inactive)
        protected void grdvwMentorships_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (gvr.RowType == DataControlRowType.DataRow)
            {
                Button btn = (Button)gvr.Cells[2].FindControl("btnEndMentorship");
                if (DateTime.TryParse(gvr.Cells[1].Text, out DateTime dt)) // try parsing
                {
                    gvr.Cells[1].Text = "Inactive since " + dt.ToString("MMMM dd, yyyy"); // write if successful
                    btn.Text = "Set Active";
                }
                else
                {
                    gvr.Cells[1].Text = "Active"; // otherwise mentorship is active
                    btn.Text = "Set Inactive";
                    btn.CssClass = "btn-secondary";
                }
            }
        }

        protected void btnEndMentorship_Click(object sender, EventArgs e)
        {
            // write the query
            Button btn = (Button)sender;
            string sqlQuery = "UPDATE Mentorship SET EndDate = @EndDate WHERE StudentID = @StudentID AND MemberID = @MemberID;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@StudentID", lstStudents.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@MemberID", grdvwMentorships.DataKeys[((GridViewRow)btn.NamingContainer).RowIndex].Value);
            // add params dependent on button text and execute query
            if (btn.Text == "Set Inactive")
                sqlCommand.Parameters.AddWithValue("@EndDate", DateTime.Now.ToString("yyyy-MM-dd"));
            else // text is "Set Active"
                sqlCommand.Parameters.AddWithValue("@EndDate", DBNull.Value);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            // refreshes gridview & DDL since DataBind() makes it disappear (note: btn text is assigned on gridview creation)
            lstStudents_SelectedIndexChanged(btn, e);
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            // approve mentorship
            Button btn = (Button)sender;
            string sqlQuery = "UPDATE Mentorship SET IsApproved = NULL, EndDate = NULL WHERE StudentID = @StudentID AND MemberID = @MemberID;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@StudentID", grdvMentorshipRequests.DataKeys[((GridViewRow)btn.NamingContainer).RowIndex]["StudentID"]);
            sqlCommand.Parameters.AddWithValue("@MemberID", grdvMentorshipRequests.DataKeys[((GridViewRow)btn.NamingContainer).RowIndex]["MemberID"]);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            grdvMentorshipRequests.DataBind();
        }

        protected void btnDeny_Click(object sender, EventArgs e)
        {
            // deny mentorship
            Button btn = (Button)sender;
            string sqlQuery = "UPDATE Mentorship SET IsRequest = 0 WHERE StudentID = @StudentID AND MemberID = @MemberID;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@StudentID", grdvMentorshipRequests.DataKeys[((GridViewRow)btn.NamingContainer).RowIndex]["StudentID"]);
            sqlCommand.Parameters.AddWithValue("@MemberID", grdvMentorshipRequests.DataKeys[((GridViewRow)btn.NamingContainer).RowIndex]["MemberID"]);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            grdvMentorshipRequests.DataBind();
        }

        protected void btnToggleRequests_Click(object sender, EventArgs e)
        {
            lblMentorshipRequests.Visible = !lblMentorshipRequests.Visible;
            grdvMentorshipRequests.Visible = !grdvMentorshipRequests.Visible;
            if (btnToggleRequests.Text == "VIEW REQUESTS")
            {
                btnToggleRequests.Text = "HIDE REQUESTS";
                btnToggleRequests.CssClass = "btn btn-secondary";
            }
            else
            {
                btnToggleRequests.Text = "VIEW REQUESTS";
                btnToggleRequests.CssClass = "btn btn-primary";
            }
        }
    }
}