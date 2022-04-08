/* Code behind for assign member */
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
    public partial class AssignMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        // updates DB with user input data. query written to be legible
        // TEMPORARY FIX: EVERY UPDATE CLICK CREATES A NEW MENTORSHIP. IT PROBABLY WONT WORK LOL.
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            String sqlQuery = "INSERT INTO Mentorship (StudentID, MemberID) VALUES (@StudentID, @MemberID);";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@StudentID", lstStudents.SelectedValue.ToString());
            if (ddlMember.SelectedValue.ToString() == "0") // if no member is assigned, set ID to null
                sqlCommand.Parameters.AddWithValue("@MemberID", DBNull.Value); // blank box value is set to "0"
            else // take input as param
                sqlCommand.Parameters.AddWithValue("@MemberID", ddlMember.SelectedValue); 
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblUpdateStatus.Text = "Member assignment successful.";
        }

        // change member dropdown list to reflect selected student
        // TEMPORARY FIX: ONLY 1 MENTOR GETS ASSIGNED AT A TIME
        protected void lstStudents_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("SELECT MemberID FROM Mentorship WHERE StudentID = @StudentID", sqlConnect);
            sqlCommand.Parameters.AddWithValue("@StudentID", lstStudents.SelectedValue);
            sqlConnect.Open();
            ddlMember.SelectedValue = sqlCommand.ExecuteScalar().ToString();
            sqlConnect.Close();
        }
    }
}