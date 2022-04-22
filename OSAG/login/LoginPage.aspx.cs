/*code behind for log in page */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// sql imports
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Drawing;

namespace OSAG.login
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MustLogin"] == null)
            {
                lblStatus.Text = "";
            }
            else
            {
                lblStatus.ForeColor = Color.Red;
                lblStatus.Font.Bold = true;
                lblStatus.Text = Session["MustLogin"].ToString();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // removed required field validators for aesthetics
            if (txtUsername.Text.Trim() == "" || txtPassword.Text.Trim() == "")
            {
                lblStatus.Text = "Please enter both your username and password.";
                lblStatus.ForeColor = Color.Red;
                lblStatus.Font.Bold = true;
                return;
            }

            // Ensure username exists before trying to compare password -_-
            // otherwise throws null reference exception in PasswordHash.cs
            if (!usernameExists(txtUsername.Text)) // also username is parameterized in helper method
            {
                lblStatus.ForeColor = Color.Red;
                lblStatus.Font.Bold = true;
                lblStatus.Text = "Username and/or password was incorrect. Please try again.";
                return;
            }

            // Ensure login was successful, if not update status text
            String correctPassword = getHashedPass(txtUsername.Text);

            if (PasswordHash.ValidatePassword(txtPassword.Text, correctPassword))
            {
                // ensure there are no lingering MustLogin/AccessDenied by setting them to null
                // session not wiped here in case later funtionality requires session data
                Session["MustLogin"] = null;
                Session["AccessDenied"] = null;
                // handle approval redirect
                if (!isApproved(txtUsername.Text))
                {
                    Session["TempUsername"] = txtUsername.Text;
                    declareUnapprovedUserType(txtUsername.Text);
                }
                else
                {
                    Session["Username"] = txtUsername.Text;
                    declareUserType(txtUsername.Text);
                }
            }
            else
            {
                lblStatus.ForeColor = Color.Red;
                lblStatus.Font.Bold = true;
                lblStatus.Text = "Username and/or password was incorrect. Please try again.";
            }
        }

        // queries Student table, declares session UserType variable and redirects to proper profile
        protected void declareUserType(String s)
        {
            String sqlQuery = "SELECT COUNT(*) FROM Student WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", s);
            sqlConnect.Open();
            int userType = (int)sqlCommand.ExecuteScalar();
            sqlConnect.Close();

            if (userType == 1) // user is student (found in Student table)
            {
                Session["UserType"] = "student";
                Response.Redirect("/homepages/Dashboard.aspx");
            }
            else // user is member (not found in Student table)
            {
                Session["UserType"] = "member"; // set User type
                // query for and set Member Type to affect access level
                sqlCommand.CommandText = "SELECT MemberType FROM Member WHERE Username = '" + s + "';";
                sqlConnect.Open();
                int sw = (int)(byte)sqlCommand.ExecuteScalar();
                sqlConnect.Close();
                switch (sw)
                {
                    case 4:
                        Session["MemberType"] = "4"; //Member
                        break;
                    case 3:
                        Session["MemberType"] = "3"; //Mentor
                        break;
                    case 2:
                        Session["MemberType"] = "2"; //Leadership
                        break;
                    case 1:
                        Session["MemberType"] = "1"; //admin
                        break;
                }
                Response.Redirect("/homepages/Dashboard.aspx");
            }
        }

        protected void declareUnapprovedUserType(String s)
        {
            String sqlQuery = "SELECT COUNT(*) FROM Student WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", s);
            sqlConnect.Open();
            int userType = (int)sqlCommand.ExecuteScalar();
            sqlConnect.Close();

            if (userType == 1) // user is student (found in Student table)
            {
                Session["UserType"] = "student";
                Response.Redirect("/profiles/UnapprovedUserProfile.aspx");
            }
            else // user is member (not found in Student table)
            {
                Session["UserType"] = "member"; // set User type
                // query for and set Member Type to affect access level
                sqlCommand.CommandText = "SELECT MemberType FROM Member WHERE Username = '" + s + "';";
                sqlConnect.Open();
                int sw = (int)(byte)sqlCommand.ExecuteScalar();
                sqlConnect.Close();
                switch (sw)
                {
                    case 4:
                        Session["MemberType"] = "4";
                        break;
                    case 3:
                        Session["MemberType"] = "3";
                        break;
                    case 2:
                        Session["MemberType"] = "2";
                        break;
                    case 1:
                        Session["MemberType"] = "1";
                        break;
                }
                Response.Redirect("/login/CompleteRegistration.aspx");
            }
        }


        // run query, return number indiating whether user is approved
        protected bool isApproved(String s)
        {
            String sqlQuery = "EXEC dbo.OSAG_NotApproved @Username";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", txtUsername.Text);
            sqlConnect.Open();
            int i = Convert.ToInt32(sqlCommand.ExecuteScalar());
            sqlConnect.Close();

            // return bool
            if (i == 1)
                return false;
            return true;
        }

        // helper method to determine if username exists
        public bool usernameExists(String s)
        {
            String sqlQuery = "SELECT (SELECT COUNT(*) FROM Student WHERE Username = @Username) " +
                "+ (SELECT COUNT(*) FROM Member WHERE Username = @Username)";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", s);
            sqlConnect.Open();
            int i = Convert.ToInt32(sqlCommand.ExecuteScalar());
            sqlConnect.Close();
            if (i > 0)
                return true;
            return false;
        }

        // runs stored procedure to declare String with value of correct pass
        protected String getHashedPass(String s)
        {
            String sqlQuery = "EXEC dbo.OSAG_GivePass @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", txtUsername.Text);
            sqlConnect.Open();
            String hashedPassword = (String)sqlCommand.ExecuteScalar();
            sqlConnect.Close();

            return hashedPassword;
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("/login/RegistrationPage.aspx");
        }
    }
}