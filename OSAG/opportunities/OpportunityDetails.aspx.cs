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
                if (!IsPostBack) // check if page is being loaded for the first time
                    ViewState["PreviousPage"] = Request.UrlReferrer; // Saves the Previous page url in ViewState
                if (ViewState["PreviousPage"] == null) // prevent user from abusing querystring
                    throw new NullReferenceException();

                // retrieve querystring if it is being used
                if (Int32.TryParse(Request.QueryString["id"], out int i))
                    Session["View"] = i;

                // Query to populate page with data
                String sqlQuery = "SELECT  OpportunityName, OpportunityDescription, EventDate, ApplicationDeadline, OpportunityLink " +
                    "FROM Opportunity WHERE Opportunity.OpportunityID = '" + Session["View"].ToString() + "'";
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);

                // Execute the Query and display results
                sqlConnection.Open();
                SqlDataReader queryResults = sqlCommand.ExecuteReader();
                queryResults.Read();
                lblName.Text = queryResults["OpportunityName"].ToString().ToUpper();
                lblDescription.Text =queryResults["OpportunityDescription"].ToString();
                lblEventDate.Text =queryResults["EventDate"].ToString();
                // give the linkbutton the stored URL
                if (queryResults["OpportunityLink"] != DBNull.Value)
                {
                    divDidYouApply.Visible = true;
                    lnkbtnApply.OnClientClick = "Navigate('" + queryResults["OpportunityLink"].ToString() + "')";
                }
                sqlConnection.Close(); // marks end of above query run

                // populate radio buttons / bookmark button with current match status
                int stuID = UsernameToID(Session["Username"].ToString());
                int[] match = getMatch(stuID, (int)Session["View"]);
                if (match == null) // no record -> do nothing
                    return;
                else // record exists
                {
                    if (match[1] == 1)
                        btnBookmark.Text = "REMOVE BOOKMARK";
                    // switch statement for IsInterest record
                    switch (match[2])
                    {
                        case -1:    // NULL
                            break;
                        case 0:     // Low
                            rdoLow.Checked = true;
                            break;
                        case 1:     // Medium
                            rdoMed.Checked = true;
                            break;
                        case 2:     // High
                            rdoHi.Checked = true;
                            break;
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

        protected void btnBookmark_Click(object sender, EventArgs e)
        {
            // Define btn and retrieve OpportunityID from Session variable
            Button btn = (Button)sender;
            int OpportunityID = Int32.Parse(Session["View"].ToString());

            // define database connection & retrieve StudentID of user
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            int StudentID = UsernameToID(Session["Username"].ToString());
            string sqlQuery;

            // Insert/Remove bookmark
            int[] matchRecord = getMatch(StudentID, OpportunityID);
            if (matchRecord == null)        // add match record for bookmark
            {
                sqlQuery = "INSERT INTO OpportunityMatch (IsBookmark, StudentID, OpportunityID) VALUES (1, " + StudentID + ", " + OpportunityID + ")";
                btn.Text = "REMOVE BOOKMARK";
            }
            else if (matchRecord[1] == 0)   // set bookmarked in existing match record to true
            {
                sqlQuery = "UPDATE OpportunityMatch SET IsBookmark = 1 WHERE OpportunityMatchID = " + matchRecord[0] + ";";
                btn.Text = "REMOVE BOOKMARK";
            }
            else                            // set bookmarked in existing match record to false
            {
                sqlQuery = "UPDATE OpportunityMatch SET IsBookmark = 0 WHERE OpportunityMatchID = " + matchRecord[0] + ";";
                btn.Text = "BOOKMARK";
            }
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
            sqlConnection.Close();
        }

        // event handler for low selection
        protected void rdoLow_CheckedChanged(object sender, EventArgs e)
        {
            // Retrieve OpportunityID from Session Variable
            int OpportunityID = Int32.Parse(Session["View"].ToString());

            // Retrieve StudentID of user
            int StudentID = UsernameToID(Session["Username"].ToString());

            // Insert/Update interestlevel
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            string sqlQuery;
            int[] matchRecord = getMatch(StudentID, OpportunityID);
            if (matchRecord == null)    // student has not yet interacted with listing
                sqlQuery = "INSERT INTO OpportunityMatch (IsInterest, StudentID, OpportunityID) VALUES (0, " + StudentID + ", " + OpportunityID + ")";
            else  // record of interaction exists
                sqlQuery = "UPDATE OpportunityMatch SET IsInterest = 0 WHERE OpportunityMatchID = " + matchRecord[0] + ";";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
        }

        // event handler for medium selection
        protected void rdoMed_CheckedChanged(object sender, EventArgs e)
        {
            // Retrieve OpportunityID from Session Variable
            int OpportunityID = Int32.Parse(Session["View"].ToString());

            // Retrieve StudentID of user
            int StudentID = UsernameToID(Session["Username"].ToString());

            // Insert/Update interestlevel
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            string sqlQuery;
            int[] matchRecord = getMatch(StudentID, OpportunityID);
            if (matchRecord == null)    // student has not yet interacted with listing
                sqlQuery = "INSERT INTO OpportunityMatch (IsInterest, StudentID, OpportunityID) VALUES (1, " + StudentID + ", " + OpportunityID + ")";
            else  // record of interaction exists
                sqlQuery = "UPDATE OpportunityMatch SET IsInterest = 1 WHERE OpportunityMatchID = " + matchRecord[0] + ";";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
        }

        // event handler for high selection
        protected void rdoHi_CheckedChanged(object sender, EventArgs e)
        {
            // Retrieve OpportunityID from Session Variable
            int OpportunityID = Int32.Parse(Session["View"].ToString());

            // Retrieve StudentID of user
            int StudentID = UsernameToID(Session["Username"].ToString());

            // Insert/Update interestlevel
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            string sqlQuery;
            int[] matchRecord = getMatch(StudentID, OpportunityID);
            if (matchRecord == null)    // student has not yet interacted with listing
                sqlQuery = "INSERT INTO OpportunityMatch (IsInterest, StudentID, OpportunityID) VALUES (2, " + StudentID + ", " + OpportunityID + ")";
            else  // record of interaction exists
                sqlQuery = "UPDATE OpportunityMatch SET IsInterest = 2 WHERE OpportunityMatchID = " + matchRecord[0] + ";";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
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
            divDidYouApply.Visible = true;
            if (lnkbtnApply.OnClientClick != null)
                divApplyButton.Visible = false;
            else
            {
                btnApplied.Visible = false;
                btnDidNotApply.Visible = false;
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
        // returns integer array with match ID index 0, bookmark status at 1, and interest level at 2
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

        // SQL Server BIT -> Boolean. read above comments for more details
        private bool bitToBoolean(object o)
        {
            if (o == DBNull.Value)
                return false;
            return (bool)o;
        }
    }
}