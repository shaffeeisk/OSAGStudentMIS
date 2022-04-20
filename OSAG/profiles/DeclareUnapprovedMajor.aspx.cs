using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace OSAG.profiles
{
    public partial class DeclareUnapprovedMajor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TempUsername"] == null)
                return;

            if (Session["UserType"].ToString() == "student")
            {
                sqlsrcHasMajor.SelectCommand = "SELECT h.MajorID, StudentID, MemberID, MajorName, IsMinor FROM HasMajor h " +
                    "JOIN Major m ON h.MajorID = m.MajorID WHERE StudentID = '" + UsernameToID(Session["TempUsername"].ToString()) + "';";
            }
            else // (Session["UserType"].ToString() == "member")
            {
                sqlsrcHasMajor.SelectCommand = "SELECT h.MajorID, StudentID, MemberID, MajorName, IsMinor FROM HasMajor h " +
                    "JOIN Major m ON h.MajorID = m.MajorID WHERE MemberID = '" + UsernameToID(Session["TempUsername"].ToString()) + "';";
            }
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

        protected void btnAddMajor_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            string sqlQuery = "INSERT INTO HasMajor (StudentID, MemberID, MajorID, IsMinor) VALUES (@StudentID, @MemberID, @MajorID, @IsMinor)";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);

            sqlCommand.Parameters.AddWithValue("@MajorID", ddlMajors.SelectedValue); // majorID from ddl
            if (Session["UserType"].ToString() == "student") // student/member ID depending on logged in user
            {
                sqlCommand.Parameters.AddWithValue("@StudentID", UsernameToID(Session["TempUsername"].ToString()));
                sqlCommand.Parameters.AddWithValue("@MemberID", DBNull.Value);
            }
            else
            {
                sqlCommand.Parameters.AddWithValue("@MemberID", UsernameToID(Session["TempUsername"].ToString()));
                sqlCommand.Parameters.AddWithValue("@StudentID", DBNull.Value);
            }
            if (lblHead.Text == "Add Major(s)") // adding major or minor
                sqlCommand.Parameters.AddWithValue("@IsMinor", DBNull.Value);
            else
                sqlCommand.Parameters.AddWithValue("@IsMinor", 1);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            grdvHasMajor.DataBind();
        }

        protected void btnDoneMajors_Click(object sender, EventArgs e)
        {
            if (lblHead.Text == "Add Major(s)")
            {
                lblHead.Text = "Add Minor(s)";
                sqlsrcMajors.SelectCommand = "SELECT * FROM Major WHERE HasMinor = 1 OR IsMinorOnly = 1 ORDER BY MajorName;";
            }
            else
                Response.Redirect("UnapprovedUserProfile.aspx?viewstate=edit");
        }
    }
}