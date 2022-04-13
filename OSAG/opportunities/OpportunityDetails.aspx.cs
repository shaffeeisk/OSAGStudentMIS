/* code behind for opportunity details*/
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

namespace OSAG.opportunities
{
    public partial class OpportunityDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                    ViewState["PreviousPage"] = Request.UrlReferrer;

                // Query to populate page with data
                String sqlQuery = "SELECT  OpportunityName, OpportunityDescription, EventDate, ApplicationDeadline, OpportunityLink, " +
                    "IsScholarship, OpportunityAward FROM Opportunity WHERE Opportunity.OpportunityID = '" + Session["View"].ToString() + "'";
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);

                // Execute the Query and display results
                sqlConnection.Open();
                SqlDataReader queryResults = sqlCommand.ExecuteReader();
                queryResults.Read();
                lblDetails1.Text = "Opportunity Name: " + queryResults["OpportunityName"].ToString();
                lblDetails2.Text = "Description: " + queryResults["OpportunityDescription"].ToString();
                lblDetails3.Text = "Event Date: " + queryResults["EventDate"].ToString();
                lblDetails4.Text = "Application Deadline: " + queryResults["ApplicationDeadline"].ToString();
                lblDetails5.Text = "Scholarship? " + queryResults["IsScholarship"].ToString();
                lblDetails6.Text = "Scholarship Award: " + queryResults["OpportunityAward"].ToString();
                // give the linkbutton the stored URL
                if (queryResults["OpportunityLink"] != DBNull.Value)
                {
                    lnkbtnApply.Visible = true;
                    lnkbtnApply.OnClientClick = "Navigate('" + queryResults["OpportunityLink"].ToString() + "')";
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
                sqlQuery = "UPDATE OpportunityMatch SET AppStatus = 'Applied', ApplicationDate = @ApplicationDate " +
                    "WHERE StudentID = @StudentID AND OpportunityID = @OpportunityID;";
            }
            else
            {
                sqlQuery = "INSERT INTO OpportunityMatch (AppStatus, ApplicationDate, StudentID, OpportunityID) " +
                    "VALUES ('Applied', @ApplicationDate, @StudentID, @OpportunityID)";
            }
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlCommand.Parameters.AddWithValue("@ApplicationDate", DateTime.Now.ToString("yyyy-MM-dd"));
            sqlCommand.Parameters.AddWithValue("@StudentID", StudentID);
            sqlCommand.Parameters.AddWithValue("@OpportunityID", Session["View"].ToString());
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
            String sqlQuery = "SELECT COUNT(*) FROM OpportunityMatch WHERE StudentID = '" + stuID + "' AND OpportunityID = '" + itemID + "';";
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