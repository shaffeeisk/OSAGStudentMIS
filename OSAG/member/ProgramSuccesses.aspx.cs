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

namespace OSAG.member
{
    public partial class ProgramSuccesses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblScholarship.Text = Scholarships().ToString();
            lblMembers.Text = MemberCount().ToString();
            lblStudents.Text = StudentCount().ToString();
            lblJobs.Text = Jobs().ToString();
            lblMentors.Text = MentorCount().ToString();
            lblCompanies.Text = Companies().ToString();
            lblInternship.Text = Internships().ToString();
        }

        protected int MemberCount()
        {
            String sqlQuery = "SELECT COUNT(*) FROM Member";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            int memberCount = (int)sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            return memberCount;
        }
        protected int StudentCount()
        {
            String sqlQuery = "SELECT COUNT(*) FROM Student";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            int studentCount = (int)sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            return studentCount;
        }
        protected int Jobs()
        {
            String sqlQuery = "SELECT Count(*) FROM JobMatch";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            int jobCount = (int)sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            return jobCount;
        }
        protected int MentorCount()
        {
            String sqlQuery = "SELECT COUNT(*) FROM Member WHERE MemberType <= 3;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            int mentorCount = (int)sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            return mentorCount;
        }

        protected int Companies()
        {
            String sqlQuery = "SELECT COUNT(*) FROM Company;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            int companyCount = (int)sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            return companyCount;
        }
        protected int Internships()
        {
            String sqlQuery = "SELECT COUNT(*) FROM InternshipMatch;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            int internshipCount = (int)sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            return internshipCount;
        }
        protected String Scholarships()
        {
            String sqlQuery = "SELECT FORMAT(SUM(AwardAmount),'C') FROM Scholarship;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            String scholarshipAmount = (String)sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            return scholarshipAmount;
        }
    }
}