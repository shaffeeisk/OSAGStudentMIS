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
    public partial class DeclareMajor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                if (Session["Username"] == null)
                    return;

            int id = UsernameToID(Session["Username"].ToString());

            // data bind gridview
            sqlsrcHasMajor.SelectCommand = "SELECT h.MajorID, StudentID, MemberID, MajorName, IsMinor FROM HasMajor h " +
                    "JOIN Major m ON h.MajorID = m.MajorID WHERE " + Session["UserType"].ToString() + "ID = '" + id + "';";

            // data bind dropdown list
            if (lblHead.Text == "Add Major(s)") // adding majors
            {
                sqlsrcMajors.SelectCommand = "SELECT * FROM Major WHERE (IsMinorOnly IS NULL OR IsMinorOnly = 0) " +
                    "AND MajorID NOT IN (SELECT MajorID FROM HasMajor " +
                    "WHERE " + Session["UserType"].ToString() + "ID = '" + id + "') ORDER BY MajorName;";
            }
            else // adding minors
            {
                sqlsrcMajors.SelectCommand = "SELECT * FROM Major WHERE (HasMinor = 1 OR IsMinorOnly = 1) " +
                    "AND MajorID NOT IN (SELECT MajorID FROM HasMajor " +
                    "WHERE " + Session["UserType"].ToString() + "ID = '" + id + "') ORDER BY MajorName;";
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
            string sqlQuery = "IF NOT EXISTS(SELECT * FROM HasMajor WHERE " +
                Session["UserType"].ToString() + "ID = @" + Session["UserType"].ToString() + "ID " +
                "AND MajorID = @MajorID AND ";
            if (lblHead.Text == "Add Major(s)") // adding major or minor
                sqlQuery += "IsMinor IS NULL) ";
            else
                sqlQuery += "IsMinor = @IsMinor) ";
            sqlQuery += "BEGIN " +
                "INSERT INTO HasMajor (StudentID, MemberID, MajorID, IsMinor) VALUES (@StudentID, @MemberID, @MajorID, @IsMinor) " +
                "END";

            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);

            sqlCommand.Parameters.AddWithValue("@MajorID", ddlMajors.SelectedValue); // majorID from ddl
            if (Session["UserType"].ToString() == "student") // student/member ID depending on logged in user
            {
                sqlCommand.Parameters.AddWithValue("@StudentID", UsernameToID(Session["Username"].ToString()));
                sqlCommand.Parameters.AddWithValue("@MemberID", DBNull.Value);
            }
            else
            {
                sqlCommand.Parameters.AddWithValue("@MemberID", UsernameToID(Session["Username"].ToString()));
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
            ddlMajors.DataBind();
        }

        protected void btnDoneMajors_Click(object sender, EventArgs e)
        {
            if (lblHead.Text == "Add Major(s)")
                lblHead.Text = "Add Minor(s)";
            else
                Response.Redirect("UserProfile.aspx?viewstate=edit");
        }

        protected void grdvHasMajor_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach (TableCell c in e.Row.Cells)
                if (c.Text == "True")
                    c.Text = "Minor";
        }

        protected void grdvHasMajor_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            ddlMajors.DataBind();
        }
    }
}