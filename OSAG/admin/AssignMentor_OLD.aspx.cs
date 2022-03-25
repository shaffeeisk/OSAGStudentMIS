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
    public partial class AssignMentor_OLD : System.Web.UI.Page
    {
        // populatePage() requires Session["InstanceStudent"]. This does not get checked in Master Page
        // so try/catch is required to redirect Mentors to the correct place. Also, since Page_Load has
        // contents, it overrides .Master for some reason so the rest of the if/else if is required.
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // so data does not replace itself when clicking button to commit changes
            {
                try
                {
                    if ((String)Session["UserType"] == "mentor" && Session["Username"] != null)
                        populatePage(); // goal of Page_Load
                    else if (Session["Username"] == null)
                    {   // user not logged in, go to LogIn
                        Session["MustLogIn"] = "You must log in to access that page";
                        Response.Redirect("/login/LoginPage.aspx");
                    }
                    else if ((String)Session["UserType"] == "student")
                    {   // not Mentor, go to Student Home
                        Session["AccessDenied"] = "You do not have access to that page.";
                        Response.Redirect("/profiles/StudentProfile.aspx");
                    }
                }
                catch (SqlException)
                {
                    Session["AccessDenied"] = "Access Denied: An unknown error occurred.";
                    Response.Redirect("profiles/MentorProfile.aspx");
                    throw;
                }
            }
        }

        // return to list of students
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewTableStudent.aspx");
        }

        // updates DB with user input data. query written to be legible
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            String sqlQuery = "UPDATE Student SET " +
                "MentorID = @MentorID " +
                "WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", (String)Session["InstanceStudent"]);
            if (ddlMentor.SelectedValue.ToString() == "0") // if no mentor is assigned, set ID to null
                sqlCommand.Parameters.AddWithValue("@MentorID", DBNull.Value); // blank box value is set to "0"
            else // take input as param
                sqlCommand.Parameters.AddWithValue("@MentorID", ddlMentor.SelectedValue); 
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblUpdateStatus.Text = "Student successfully updated.";
        }

        // helper method to populate page with data
        protected void populatePage()
        {
            String sqlQuery = "SELECT FirstName, LastName, MentorID " +
                            "FROM Student WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", (String)Session["InstanceStudent"]);
            sqlConnect.Open();
            SqlDataReader queryResults = sqlCommand.ExecuteReader();
            queryResults.Read();
            lblFN.Text = queryResults["FirstName"].ToString();
            lblLN.Text = queryResults["LastName"].ToString();
            if (queryResults["MentorID"] == DBNull.Value)
                ddlMentor.SelectedValue = "0";
            else
                ddlMentor.SelectedValue = queryResults["MentorID"].ToString();
            queryResults.Close();
            sqlConnect.Close();
        }
    }
}