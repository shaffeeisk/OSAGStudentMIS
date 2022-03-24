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
        // populatePage() requires Session["InstanceStudent"]. This does not get checked in Master Page
        // so try/catch is required to redirect Mentors to the correct place. Also, since Page_Load has
        // contents, it overrides .Master for some reason so the rest of the if/else if is required.
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // so data does not replace itself when clicking button to commit changes
            {
                try
                {
                    if ((String)Session["UserType"] == "Mentor" && Session["Username"] != null)
                        populatePage(); // goal of Page_Load
                    else if (Session["Username"] == null)
                    {   // user not logged in, go to LogIn
                        Session["MustLogIn"] = "You must log in to access that page";
                        //Response.Redirect("logIn.aspx");
                    }
                    else if ((String)Session["UserType"] == "student")
                    {   // not Mentor, go to Student Home
                        Session["AccessDenied"] = "You do not have access to that page.";
                        Response.Redirect("studentHome.aspx");
                    }
                }
                catch (SqlException)
                {
                    Session["AccessDenied"] = "Access Denied: An unknown error occurred.";
                    //Response.Redirect("MentorHome.aspx");
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
                "FirstName = @FN, " +
                "LastName = @LN, " +
                "Email = @Email, " +
                "GraduationDate = @GradDate, " +
                "MentorID = @MembID " +
                "WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", (String)Session["InstanceStudent"]);
            sqlCommand.Parameters.AddWithValue("@FN", validate(firstName.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@LN", validate(lastName.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@Email", validate(email.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@GradDate", validate(gradDate.Value.ToString()));
            if (ddlMentor.SelectedValue.ToString() == "0") // if no mentor is assigned, set ID to null
                sqlCommand.Parameters.AddWithValue("@MembID", DBNull.Value); // blank box value is set to "0"
            else // take input as param
                sqlCommand.Parameters.AddWithValue("@MembID", ddlMentor.SelectedValue); 
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblUpdateStatus.Text = "Student successfully updated.";
        }

        // helper method to populate page with data
        protected void populatePage()
        {
            String sqlQuery = "SELECT FirstName, LastName, Email, GraduationDate, MentorID " +
                            "FROM Student WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", (String)Session["InstanceStudent"]);
            sqlConnect.Open();
            SqlDataReader queryResults = sqlCommand.ExecuteReader();
            queryResults.Read();
            firstName.Value = queryResults["FirstName"].ToString();
            lastName.Value = queryResults["LastName"].ToString();
            email.Value = queryResults["Email"].ToString();
            gradDate.Value = DateTime.Parse(queryResults["GraduationDate"].ToString()).ToString("yyyy-MM-dd"); // why
            if (queryResults["MentorID"] == DBNull.Value)
                ddlMentor.SelectedValue = "0";
            else
                ddlMentor.SelectedValue = queryResults["MentorID"].ToString();
            queryResults.Close();
            sqlConnect.Close();
        }

        // helper method to validate data. trims input string of leading/trailing white space.
        // then returns null if user input is empty. otherwise, returns the trimmed string.
        // allows data integrity to allow querying null input (also saves disk space :D)
        // (e.g. display students who don't have graduation dates so mentor can help them figure out when they should graduate)
        private object validate(String s)
        {
            s = s.Trim();
            if (s == "")
                return (object)DBNull.Value;
            return s;
        }
    }
}