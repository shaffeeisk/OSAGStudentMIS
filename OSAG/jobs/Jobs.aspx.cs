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
                // define database connection
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                // Retrieve StudentID of user
                String sqlQuery = "SELECT StudentID FROM Student WHERE UserName = '" + Session["Username"] + "'";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
                sqlConnection.Open();
                int stuID = (int)sqlCommand.ExecuteScalar();
                sqlConnection.Close();

                // for each grid row
                for (int i = 0; i < grdvwJobs.Rows.Count; i++)
                {
                    // define button to be changed and gridview row being used
                    Button btn = (Button)grdvwJobs.Rows[i].FindControl("btnBookmark");
                    GridViewRow gvr = (GridViewRow)btn.NamingContainer;

                    // Retrieve JobID from row
                    int itemID = (int)grdvwJobs.DataKeys[gvr.RowIndex]["JobID"];

                    // check bookmark status
                    sqlQuery = "SELECT COUNT(*) FROM JobMatch WHERE StudentID = " + stuID + " AND JobID = " + itemID + "AND IsBookmark = 1;";
                    sqlCommand.CommandText = sqlQuery;
                    sqlConnection.Open();
                    int isBookmark = (int)sqlCommand.ExecuteScalar();
                    sqlConnection.Close();
                    if (isBookmark == 1)
                        btn.Text = "Remove Bookmark";
                }
            }
        }

        protected void btnBookmark_Click(object sender, EventArgs e)
        {
            // Retrieve JobID from gridview and define btn
            Button btn = (Button)sender;
            int JobID = (int)grdvwJobs.DataKeys[((GridViewRow)btn.NamingContainer).RowIndex].Value;

            // Retrieve StudentID of user
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            String sqlQuery = "SELECT StudentID FROM Student WHERE UserName = '" + Session["Username"] + "'";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            int StudentID = (int)sqlCommand.ExecuteScalar();
            sqlConnection.Close();

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

        // helper method to get matchID and bookmark status
        public int[] getMatch(int stuID, int itemID)
        {
            try
            {
                // query for match ID and bookmark status
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                String sqlQuery = "SELECT JobMatchID, IsBookmark FROM JobMatch WHERE StudentID = " + stuID + " AND JobID = " + itemID + ";";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
                sqlConnection.Open();
                SqlDataReader queryResults = sqlCommand.ExecuteReader();
                queryResults.Read();
                // returns integer array with match ID at index 0 and bookmark status at index 1
                int[] intArr = new int[2];
                intArr[0] = (int)queryResults["JobMatchID"];
                intArr[1] = Convert.ToInt32(queryResults["IsBookmark"]); // SQL BIT is treated as Boolean, C# does not handle Boolean as T/F = 0/1
                queryResults.Close();
                sqlConnection.Close();
                return intArr;
            }
            catch (InvalidOperationException)
            {   // if query results is empty, return null for main method handling
                return null;
                throw;
            }
        }
    }
}