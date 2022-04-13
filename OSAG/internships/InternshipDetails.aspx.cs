/*Code behind for internship details page */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Drawing;

namespace OSAG.internships
{
    public partial class InternshipDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack) // check if the webpage is loaded for the first time.
                {
                    ViewState["PreviousPage"] =
                Request.UrlReferrer;// Saves the Previous page url in ViewState
                }
                // Query to populate page with data
                String sqlQuery = "Select 'Internship Name: ' + InternshipName as Name, 'Company Name: ' + CompanyName as Company, 'Internship Description: ' +  InternshipDescription as Description, 'Application Deadline: ' + CAST(ApplicationDeadline AS varchar) as Deadline" +
                    ", 'Start Date: ' + CAST(StartDate as varchar) as Start, 'Weekly Hours: ' + CAST(WeeklyHours AS varchar) as Hours, 'Payment: ' + FORMAT(Payment,'C') as Payment, InternshipLink" +
                    " from Internship LEFT JOIN Company ON Company.CompanyID = Internship.CompanyID where InternshipID = '" + Session["View"].ToString() + "'";
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
                sqlConnection.Open();
                SqlDataReader queryResults = sqlCommand.ExecuteReader();
                // read onto page
                while (queryResults.Read())
                {
                    lblDetails.Text = queryResults["Name"].ToString();
                    lblDetails1.Text = queryResults["Company"].ToString();
                    lblDetails2.Text = queryResults["Description"].ToString();
                    lblDetails3.Text = queryResults["Deadline"].ToString();
                    lblDetails4.Text = queryResults["Start"].ToString();
                    lblDetails5.Text = queryResults["Hours"].ToString();
                    lblDetails6.Text = queryResults["Payment"].ToString();
                    // give the linkbutton the stored URL
                    if (queryResults["InternshipLink"] != DBNull.Value)
                    {
                        lnkbtnApply.Visible = true;
                        lnkbtnApply.OnClientClick = "Navigate('" + queryResults["InternshipLink"].ToString() + "')";
                    }
                }
            }
            catch (NullReferenceException)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
                throw;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            if (ViewState["PreviousPage"] != null)
            {
                Response.Redirect(ViewState["PreviousPage"].ToString());
            }
        }

        protected void lnkbtnApply_Click(object sender, EventArgs e)
        {
            lblStatus.Visible = true;
            if (lnkbtnApply.OnClientClick != null)
            {
                lnkbtnApply.Visible = false;
                btnApplied.Visible = true;
                btnDidNotApply.Visible = true;
            }
            else
            {
                lblStatus.Text = "The link to this form is unavailable. Please contact your administrator for further details.";
                lblStatus.ForeColor = Color.Red;
                lblStatus.Font.Bold = true;
            }
        }

        protected void btnApplied_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            int StudentID = UsernameToID(Session["Username"].ToString());
            string sqlQuery;

            // query based on whether a match exists
            if (MatchExists(StudentID, (int)Session["View"]))
            {
                sqlQuery = "UPDATE InternshipMatch SET AppStatus = 'Applied', ApplicationDate = @ApplicationDate " +
                    "WHERE StudentID = @StudentID AND InternshipID = @InternshipID;";
            }
            else
            {
                sqlQuery = "INSERT INTO InternshipMatch (AppStatus, ApplicationDate, StudentID, InternshipID) " +
                    "VALUES ('Applied', @ApplicationDate, @StudentID, @InternshipID)";
            }
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlCommand.Parameters.AddWithValue("@ApplicationDate", DateTime.Now.ToString("yyyy-MM-dd"));
            sqlCommand.Parameters.AddWithValue("@StudentID", StudentID);
            sqlCommand.Parameters.AddWithValue("@InternshipID", Session["View"].ToString());
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
        }

        protected void btnDidNotApply_Click(object sender, EventArgs e)
        {
            lblStatus.Text = "Your response has been recorded.";
            lnkbtnApply.Visible = true;
            btnApplied.Visible = false;
            btnDidNotApply.Visible = false;
        }

        // helper method to get matchID and bookmark status
        public bool MatchExists(int stuID, int itemID)
        {
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            String sqlQuery = "SELECT COUNT(*) FROM InternshipMatch WHERE StudentID = '" + stuID + "' AND InternshipID = '" + itemID + "';";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            if ((int)sqlCommand.ExecuteScalar() < 1)
                return false;
            return true;
        }

        // helper method to execute stored procedure (username [GUID within program] -> StudentID/MemberID)
        protected int UsernameToID(string username)
        {
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("dbo.OSAG_UsernameToID", sqlConnection);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@Username", username);
            sqlConnection.Open();
            return (int)sqlCommand.ExecuteScalar();
        }
    }
}