using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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

        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text;
            Response.Redirect("OpportunityDetails.aspx");
        }

        protected void btnBookmark_Click(object sender, EventArgs e)
        {
            int StudentID = 0;
            int OpportunityID = 0;
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            String OpportunityName = gvr.Cells[0].Text;
            String AwardAmount = gvr.Cells[1].Text;

            //Retrieve StudentID of user
            //Query
            String sqlQuery = "Select StudentID FROM Student Where UserName = '" + Session["Username"] + "'";

            // Define the Connection
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

            //Create and Format the Command
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;

            // Execute the Query and get results
            sqlConnection.Open();
            SqlDataReader queryResults = sqlCommand.ExecuteReader();
            while (queryResults.Read())
            {
                StudentID = (int)queryResults["StudentID"];
            }

            //Retrieve Opportunity ID of posting
            //Query
            String sqlQuery3 = "Select OpportunityID FROM Opportunity Where AwardName = '" + OpportunityName + "'";

            // Define the Connection
            SqlConnection sqlConnection2 = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

            //Create and Format the Command
            SqlCommand sqlCommand3 = new SqlCommand();
            sqlCommand3.Connection = sqlConnection2;
            sqlCommand3.CommandType = CommandType.Text;
            sqlCommand3.CommandText = sqlQuery3;

            // Execute the Query and get results
            sqlConnection.Open();
            SqlDataReader queryResults2 = sqlCommand.ExecuteReader();
            while (queryResults.Read())
            {
                OpportunityID = (int)queryResults2["OpportunityID"];
            }

            //Insert bookmark into database
            String sqlQuery2 = "INSERT INTO OpportunityMatch(isBookmark,StudentID,OpportunityID) VALUES(1,'" + StudentID + "','" + OpportunityID + "'";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

            SqlCommand sqlCommand2 = new SqlCommand();
            sqlCommand2.Connection = sqlConnect;
            sqlCommand2.CommandType = CommandType.Text;
            sqlCommand2.CommandText = sqlQuery2;

            sqlConnect.Open();
            sqlCommand2.ExecuteScalar();
            sqlConnect.Close();
        }
    }
}