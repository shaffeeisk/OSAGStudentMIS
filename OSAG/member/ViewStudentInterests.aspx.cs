/*code behind for view student interests*/
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.member
{
    public partial class ViewStudentInterests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
                return;
            else if (Session["MemberType"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }
            else if (Session["MemberType"].ToString() == "4")
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }

            if (Session["MemberType"].ToString() == "1")
                sqlsrcListStu.SelectCommand = "SELECT FirstName + ' ' + LastName AS Name, StudentID FROM Student;";
            else
            {
                sqlsrcListStu.SelectCommand = "SELECT FirstName + ' ' + LastName AS Name, s.StudentID " +
                "FROM Student s JOIN Mentorship ms ON s.StudentID = ms.StudentID " +
                "WHERE ms.MemberID = '" + UsernameToID(Session["Username"].ToString()) + "' AND EndDate IS NULL AND IsRequest IS NULL;";
            }

            switch (ddlSelectTable.SelectedValue)
            {
                case "Internship":
                    sqlsrcViewInterests.SelectCommand = "SELECT i.InternshipID, InternshipName AS 'Name', ApplicationDeadline AS 'Deadline', IsInterest " +
                        "FROM Internship i JOIN InternshipMatch im ON i.InternshipID = im.InternshipID " +
                        "WHERE i.InternshipID IN (SELECT InternshipID FROM InternshipMatch " +
                        "WHERE StudentID = '" + ddlSelectStudent.SelectedValue + "' AND IsInterest IS NOT NULL);";
                    break;
                case "Opportunity":
                    sqlsrcViewInterests.SelectCommand = "SELECT o.OpportunityID, OpportunityName AS 'Name', EventDate AS 'Deadline', IsInterest " +
                        "FROM Opportunity o JOIN OpportunityMatch om ON o.OpportunityID = om.OpportunityID " +
                        "WHERE o.OpportunityID IN (SELECT OpportunityID FROM OpportunityMatch " +
                        "WHERE StudentID = '" + ddlSelectStudent.SelectedValue + "' AND IsInterest IS NOT NULL);";
                    break;
                case "Job":
                    sqlsrcViewInterests.SelectCommand = "SELECT j.JobID, JobName AS 'Name', ApplicationDeadline AS 'Deadline', IsInterest " +
                        "FROM Job j JOIN JobMatch jm ON j.JobID = jm.JobID " +
                        "WHERE j.JobID IN (SELECT JobID FROM JobMatch " +
                        "WHERE StudentID = '" + ddlSelectStudent.SelectedValue + "' AND IsInterest IS NOT NULL);";
                    break;
                default:
                    sqlsrcViewInterests.SelectCommand = "";
                    return;
            }
        }

        protected void grdvwData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach (TableCell c in e.Row.Cells)
            {
                if (DateTime.TryParse(c.Text, out DateTime dt)) // format date
                    c.Text = dt.ToString("M/d/yyyy");
                else
                {
                    switch (c.Text) // change text of row
                    {
                        case "0":
                            c.Text = "LOW";
                            break;
                        case "1":
                            c.Text = "MEDIUM";
                            break;
                        case "2":
                            c.Text = "HIGH";
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        protected void ddlSelectTable_SelectedIndexChanged(object sender, EventArgs e)
        {
            grdvwData.DataBind();
        }

        protected void ddlSelectStudent_SelectedIndexChanged(object sender, EventArgs e)
        {
            grdvwData.DataBind();
        }

        protected int UsernameToID(string username)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("dbo.OSAG_UsernameToID", sqlConnect);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@Username", username);
            sqlConnect.Open();
            return (int)sqlCommand.ExecuteScalar();
        }
    }
}
