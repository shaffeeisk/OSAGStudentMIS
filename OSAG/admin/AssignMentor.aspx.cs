using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// sql imports
using System.Data;
using System.Data.SqlClient;
// web.config imports
using System.Web.Configuration;
// colored response import
using System.Drawing;

namespace OSAG.admin
{
    public partial class AssignMentor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        // updates DB with user input data. query written to be legible
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            String sqlQuery = "UPDATE Student SET " +
                "MentorID = @MentorID " +
                "WHERE StudentID = @StudentID;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@StudentID", lstStudents.SelectedValue.ToString());
            if (ddlMentor.SelectedValue.ToString() == "0") // if no mentor is assigned, set ID to null
                sqlCommand.Parameters.AddWithValue("@MentorID", DBNull.Value); // blank box value is set to "0"
            else // take input as param
                sqlCommand.Parameters.AddWithValue("@MentorID", ddlMentor.SelectedValue); 
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblUpdateStatus.Text = "Mentor assignment successful.";
        }

        // change mentor dropdown list to reflect selected student
        protected void lstStudents_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("SELECT MentorID FROM Student WHERE StudentID = @StudentID", sqlConnect);
            sqlCommand.Parameters.AddWithValue("@StudentID", lstStudents.SelectedValue);
            sqlConnect.Open();
            ddlMentor.SelectedValue = sqlCommand.ExecuteScalar().ToString();
            sqlConnect.Close();
        }
    }
}