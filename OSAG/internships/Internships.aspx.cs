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
namespace OSAG.internships
{
    public partial class Internships : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnBookmark_Click(object sender, EventArgs e)
        {
            int StudentID = 0;
            int InternshipID = 0;
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            String InternshipName = gvr.Cells[0].Text;
            String CompanyName = gvr.Cells[1].Text;


            // Define the Connection
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

            // Retrieve StudentID of user
            String sqlQuery = "SELECT StudentID FROM Student WHERE UserName = '" + Session["Username"] + "'";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            StudentID = (int)sqlCommand.ExecuteScalar();
            sqlConnection.Close();

            // Retrieve InternshipID from gridview
            InternshipID = (int)grdvwInternships.DataKeys[gvr.RowIndex]["InternshipID"];

            // Insert/Remove bookmark
            int[] matchRecord = getMatch(StudentID, InternshipID);
            if (matchRecord == null)
                sqlQuery = "INSERT INTO InternshipMatch (IsBookmark, StudentID, InternshipID) VALUES (1, " + StudentID + ", " + InternshipID + ")";
            else if (matchRecord[1] == 0)
                sqlQuery = "UPDATE InternshipMatch SET IsBookmark = 1 WHERE InternshipMatchID = " + matchRecord[0] + ";";
            else
                sqlQuery = "UPDATE InternshipMatch SET IsBookmark = 0 WHERE InternshipMatchID = " + matchRecord[0] + ";";
            sqlCommand.CommandText = sqlQuery;
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
            sqlConnection.Close();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text + gvr.Cells[1].Text;
            Response.Redirect("InternshipDetails.aspx");
        }

        // helper method to get matchID and bookmark status
        public int[] getMatch(int stuID, int itemID)
        {
            try
            {
                // query for match ID and bookmark status
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                String sqlQuery = "SELECT InternshipMatchID, IsBookmark FROM InternshipMatch WHERE StudentID = " + stuID + " AND InternshipID = " + itemID + ";";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
                sqlConnection.Open();
                SqlDataReader queryResults = sqlCommand.ExecuteReader();
                queryResults.Read();
                // returns integer array with match ID at index 0 and bookmark status at index 1
                int[] intArr = new int[2];
                intArr[0] = (int)queryResults["InternshipMatchID"];
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