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
            
        }

        protected void btnBookmark_Click(object sender, EventArgs e)
        {
            int StudentID=0;
            int JobID=0;
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            String JobName = gvr.Cells[0].Text;
            String CompanyName = gvr.Cells[1].Text;

            // Define the Connection
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

            // Retrieve StudentID of user
            String sqlQuery = "SELECT StudentID FROM Student WHERE UserName = '" + Session["Username"] + "'";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
            sqlConnection.Open();
            StudentID = (int)sqlCommand.ExecuteScalar();
            sqlConnection.Close();

            // Retrieve Job ID of posting
            sqlQuery = "SELECT JobID FROM Job WHERE JobName = '" + JobName + "'";
            sqlCommand.CommandText = sqlQuery;
            sqlConnection.Open();
            JobID = (int)sqlCommand.ExecuteScalar();
            sqlConnection.Close();

            //Insert bookmark into database
            sqlQuery = "INSERT INTO JobMatch (IsBookmark, StudentID, JobID) VALUES (1, @StudentID, @JobID)";
            sqlCommand.CommandText = sqlQuery;
            sqlCommand.Parameters.AddWithValue("@StudentID", StudentID);
            sqlCommand.Parameters.AddWithValue("@JobID", JobID);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
            sqlConnection.Close();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text+gvr.Cells[1].Text;
            Response.Redirect("JobDetails.aspx");
        }
    }
}