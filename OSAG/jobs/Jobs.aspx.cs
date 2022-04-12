/* Code behind for job page*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//Sql Imports
using System.Data;
using System.Data.SqlClient;
//Connection Strings in web.config
using System.Web.Configuration;
namespace OSAG.jobs
{
    public partial class Jobs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }

            // check each bookmark button and change text based on whether a bookmark exists
            if (!IsPostBack && Session["UserType"].ToString() == "student") // only when first loading page
            {
                // Retrieve StudentID of user
                int StudentID = UsernameToID(Session["Username"].ToString());

                // instantiate objects for queries
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                string sqlQuery = "";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);

                // for each grid row
                for (int i = 0; i < grdvwJobs.Rows.Count; i++)
                {
                    // define button to be changed and gridview row being used
                    Button btn = (Button)grdvwJobs.Rows[i].FindControl("btnBookmark");
                    GridViewRow gvr = (GridViewRow)btn.NamingContainer;

                    // Retrieve JobID from row
                    int ItemID = (int)grdvwJobs.DataKeys[gvr.RowIndex]["JobID"];

                    // check bookmark and interest status. get match record (if any)
                    int[] match = getMatch(StudentID, ItemID);
                    // go to next row if no record exists
                    if (match == null)
                        continue;
                    // if bookmarked, change button text
                    if (match[1] == 1)
                        btn.Text = "Remove Bookmark";
                    // switch statement for IsInterest record
                    switch (match[2])
                    {
                        case -1:    // NULL
                            break;
                        case 0:     // Low
                            ((RadioButton)grdvwJobs.Rows[i].FindControl("rdoLow")).Checked = true;
                            break;
                        case 1:     // Medium
                            ((RadioButton)grdvwJobs.Rows[i].FindControl("rdoMed")).Checked = true;
                            break;
                        case 2:     // High
                            ((RadioButton)grdvwJobs.Rows[i].FindControl("rdoHi")).Checked = true;
                            break;
                    }
                }
            }
        }

        protected void btnBookmark_Click(object sender, EventArgs e)
        {
            // Define btn and retrieve JobID from gridview
            Button btn = (Button)sender;
            int JobID = (int)grdvwJobs.DataKeys[((GridViewRow)btn.NamingContainer).RowIndex].Value;

            // define database connection & retrieve StudentID of user
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            int StudentID = UsernameToID(Session["Username"].ToString());
            string sqlQuery = "";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);

            // Insert/Remove bookmark
            int[] matchRecord = getMatch(StudentID, JobID);
            if (matchRecord == null)        // add match record for bookmark
            {
                sqlQuery = "INSERT INTO JobMatch (IsBookmark, StudentID, JobID) VALUES (1, " + StudentID + ", " + JobID + ")";
                btn.Text = "Remove Bookmark";
            }
            else if (matchRecord[1] == 0)   // set bookmarked in existing match record to true
            {
                sqlQuery = "UPDATE JobMatch SET IsBookmark = 1 WHERE JobMatchID = " + matchRecord[0] + ";";
                btn.Text = "Remove Bookmark";
            }
            else                            // set bookmarked in existing match record to false
            {
                sqlQuery = "UPDATE JobMatch SET IsBookmark = 0 WHERE JobMatchID = " + matchRecord[0] + ";";
                btn.Text = "Bookmark";
            }
            sqlCommand.CommandText = sqlQuery;
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
            sqlConnection.Close();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Session["View"] = grdvwJobs.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex].Value;
            Response.Redirect("JobDetails.aspx");
        }

        // event handler for low selection
        protected void rdoLow_CheckedChanged(object sender, EventArgs e)
        {
            // Retrieve JobID from gridview
            int JobID = (int)grdvwJobs.DataKeys[((GridViewRow)((RadioButton)sender).NamingContainer).RowIndex].Value;

            // Retrieve StudentID of user
            int StudentID = UsernameToID(Session["Username"].ToString());

            // Insert/Update interestlevel
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            string sqlQuery;
            int[] matchRecord = getMatch(StudentID, JobID);
            if (matchRecord == null)    // student has not yet interacted with listing
                sqlQuery = "INSERT INTO JobMatch (IsInterest, StudentID, JobID) VALUES (0, " + StudentID + ", " + JobID + ")";
            else  // record of interaction exists
                sqlQuery = "UPDATE JobMatch SET IsInterest = 0 WHERE JobMatchID = " + matchRecord[0] + ";";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
        }

        // event handler for medium selection
        protected void rdoMed_CheckedChanged(object sender, EventArgs e)
        {
            // Retrieve JobID from gridview
            int JobID = (int)grdvwJobs.DataKeys[((GridViewRow)((RadioButton)sender).NamingContainer).RowIndex].Value;

            // Retrieve StudentID of user
            int StudentID = UsernameToID(Session["Username"].ToString());

            // Insert/Update interestlevel
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            string sqlQuery;
            int[] matchRecord = getMatch(StudentID, JobID);
            if (matchRecord == null)    // student has not yet interacted with listing
                sqlQuery = "INSERT INTO JobMatch (IsInterest, StudentID, JobID) VALUES (1, " + StudentID + ", " + JobID + ")";
            else  // record of interaction exists
                sqlQuery = "UPDATE JobMatch SET IsInterest = 1 WHERE JobMatchID = " + matchRecord[0] + ";";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
        }

        // event handler for high selection
        protected void rdoHi_CheckedChanged(object sender, EventArgs e)
        {
            // Retrieve JobID from gridview
            int JobID = (int)grdvwJobs.DataKeys[((GridViewRow)((RadioButton)sender).NamingContainer).RowIndex].Value;

            // Retrieve StudentID of user
            int StudentID = UsernameToID(Session["Username"].ToString());

            // Insert/Update interestlevel
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            string sqlQuery;
            int[] matchRecord = getMatch(StudentID, JobID);
            if (matchRecord == null)    // student has not yet interacted with listing
                sqlQuery = "INSERT INTO JobMatch (IsInterest, StudentID, JobID) VALUES (2, " + StudentID + ", " + JobID + ")";
            else  // record of interaction exists
                sqlQuery = "UPDATE JobMatch SET IsInterest = 2 WHERE JobMatchID = " + matchRecord[0] + ";";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
        }

        // helper method to execute stored procedure (username [GUID within program] -> StudentID/MemberID)
        protected int UsernameToID(string username)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("dbo.OSAG_UsernameToID", sqlConnect);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@Username", username);
            sqlConnect.Open();
            return (int)sqlCommand.ExecuteScalar();
        }

        // helper method to get matchID and bookmark status
        public int[] getMatch(int stuID, int itemID)
        {
            try
            {
                // query for match ID and bookmark status
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                String sqlQuery = "SELECT JobMatchID, IsBookmark, IsInterest FROM JobMatch WHERE StudentID = " + stuID + " AND JobID = " + itemID + ";";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
                sqlConnection.Open();
                SqlDataReader queryResults = sqlCommand.ExecuteReader();
                queryResults.Read();
                // returns integer array with match ID index 0, bookmark status at 1, and interest level at 2
                int[] intArr = new int[3];
                intArr[0] = (int)queryResults["JobMatchID"];
                // handles null values (null = false/0)
                if (bitToBoolean(queryResults["IsBookmark"]))
                    intArr[1] = 1;
                else
                    intArr[1] = 0;
                // handles null values (null = -1)
                if (queryResults["IsInterest"] == DBNull.Value)
                    intArr[2] = -1; // for main method handling, prevents null -> int conversion error
                else
                    intArr[2] = Convert.ToInt32(queryResults["IsInterest"]);
                return intArr;
            }
            catch (InvalidOperationException)
            {   // if query results is empty, return null for main method handling
                return null;
                throw;
            }
        }

        // SQL Server BIT -> Boolean. read above comments for more details
        private bool bitToBoolean(object o)
        {
            if (o == DBNull.Value)
                return false;
            return (bool)o;
        }
    }
}