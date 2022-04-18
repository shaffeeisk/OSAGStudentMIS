/* code behind for opportunities page*/
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

namespace OSAG.opportunities
{
    public partial class Opportunities : System.Web.UI.Page
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

                // for each grid row
                for (int i = 0; i < grdvwOpportunities.Rows.Count; i++)
                {
                    // define button to be changed and gridview row being used
                    Button btn = (Button)grdvwOpportunities.Rows[i].FindControl("btnBookmark");

                    // Retrieve OpportunityID from row
                    int ItemID = (int)grdvwOpportunities.DataKeys[((GridViewRow)btn.NamingContainer).RowIndex]["OpportunityID"];

                    // check bookmark. get match record (if any)
                    int[] match = getMatch(StudentID, ItemID);
                    // go to next row if no record exists
                    if (match == null)
                        continue;
                    // if bookmarked, change button text
                    if (match[1] == 1)
                        btn.Text = "Remove Bookmark";
                }
            }
        }

        protected void btnBookmark_Click(object sender, EventArgs e)
        {
            // Define btn and retrieve OpportunityID from gridview
            Button btn = (Button)sender;
            int OpportunityID = (int)grdvwOpportunities.DataKeys[((GridViewRow)btn.NamingContainer).RowIndex].Value;

            // define database connection & retrieve StudentID of user
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            int StudentID = UsernameToID(Session["Username"].ToString());
            string sqlQuery;

            // Insert/Remove bookmark
            int[] matchRecord = getMatch(StudentID, OpportunityID);
            if (matchRecord == null)        // add match record for bookmark
            {
                sqlQuery = "INSERT INTO OpportunityMatch (IsBookmark, StudentID, OpportunityID) VALUES (1, " + StudentID + ", " + OpportunityID + ")";
                btn.Text = "Remove Bookmark";
            }
            else if (matchRecord[1] == 0)   // set bookmarked in existing match record to true
            {
                sqlQuery = "UPDATE OpportunityMatch SET IsBookmark = 1 WHERE OpportunityMatchID = " + matchRecord[0] + ";";
                btn.Text = "Remove Bookmark";
            }
            else                            // set bookmarked in existing match record to false
            {
                sqlQuery = "UPDATE OpportunityMatch SET IsBookmark = 0 WHERE OpportunityMatchID = " + matchRecord[0] + ";";
                btn.Text = "Bookmark";
            }
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
            sqlConnection.Close();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Session["View"] = grdvwOpportunities.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex].Value;
            Response.Redirect("OpportunityDetails.aspx");
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
                String sqlQuery = "SELECT OpportunityMatchID, IsBookmark, IsInterest FROM OpportunityMatch WHERE StudentID = " + stuID + " AND OpportunityID = " + itemID + ";";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
                sqlConnection.Open();
                SqlDataReader queryResults = sqlCommand.ExecuteReader();
                queryResults.Read();
                // returns integer array with match ID index 0, bookmark status at 1, and interest level at 2
                int[] intArr = new int[3];
                intArr[0] = (int)queryResults["OpportunityMatchID"];
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            String search = "SELECT OpportunityID, OpportunityName, EventDate, CompanyName FROM Opportunity o LEFT JOIN Company c on o.CompanyID = c.CompanyID WHERE OpportunityName like '%[Search]%' OR CompanyName like '%[Search]%'";
            sqlsrc.SelectCommand = search.Replace("[Search]", HttpUtility.HtmlEncode(searchBar.Value.Trim()));
        }
    }
}