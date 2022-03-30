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

            //Insert bookmark into database
            sqlQuery = "INSERT INTO InternshipMatch (IsBookmark, StudentID, InternshipID) VALUES (1, @StudentID, @InternshipID)";
            sqlCommand.CommandText = sqlQuery;
            sqlCommand.Parameters.AddWithValue("@StudentID", StudentID);
            sqlCommand.Parameters.AddWithValue("@InternshipID", InternshipID);
            sqlConnection.Open();
            sqlCommand.ExecuteScalar();
            sqlConnection.Close();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text+gvr.Cells[1].Text;
            Response.Redirect("InternshipDetails.aspx");
        }
    }
}