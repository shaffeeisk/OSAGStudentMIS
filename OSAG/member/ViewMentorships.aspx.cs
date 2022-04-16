using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.member
{
    public partial class ViewMentorships : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["UserType"].ToString() == "student")
                return;
            sqlsrcMentorships.SelectCommand =
                "SELECT FirstName + ' ' + LastName AS FullName, Gpa, GradDate, s.StudentID " +
                "FROM Student s JOIN Mentorship y ON s.StudentID = y.StudentID " +
                "WHERE MemberID = '" + UsernameToID(Session["Username"].ToString()) + "' " +
                "AND IsRequest IS NULL;";
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
    }
}