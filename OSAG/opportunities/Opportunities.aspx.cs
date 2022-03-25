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
            String AwardName = gvr.Cells[0].Text;
            String AwardAmount = gvr.Cells[1].Text;

            // Define the Connection
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

            // Retrieve StudentID of user
            String sqlQuery = "SELECT StudentID FROM Student WHERE UserName = '" + Session["Username"] + "'";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            StudentID = (int)sqlCommand.ExecuteScalar();
            sqlConnection.Close();

            // Retrieve Opportunity ID of posting
            sqlQuery = "SELECT OpportunityID FROM Opportunity WHERE AwardName = '" + AwardName + "'";
            sqlCommand.CommandText = sqlQuery;
            sqlConnection.Open();
            OpportunityID = (int)sqlCommand.ExecuteScalar();
            sqlConnection.Close();

            //Insert bookmark into database
            sqlQuery = "INSERT INTO OpportunityMatch (IsBookmark, StudentID, OpportunityID) VALUES (1, @StudentID, @OpportunityID)";
            sqlCommand.CommandText = sqlQuery;
            sqlCommand.Parameters.AddWithValue("@StudentID", StudentID);
            sqlCommand.Parameters.AddWithValue("@OpportunityID", OpportunityID);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
            sqlConnection.Close();
        }
    }
}