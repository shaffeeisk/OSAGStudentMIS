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

namespace OSAG.login
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MustLogin"] == null)
            {
                lblStatus.Text = "Please login to continue!";
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
            // check to make sure user is approved first, if not do not attempt login
            if (!isApproved(txtUsername.Text))
            {
                Session["MustLogin"] = "Your account is pending approval. Please try again at a later time.";
                Response.Redirect("LoginPage.aspx");
                return;
            }

            // Ensure login was successful, if not update status text
            String correctPassword = getHashedPass(txtUsername.Text);

            if (PasswordHash.ValidatePassword(txtPassword.Text, correctPassword))
            {
                // ensure there are no lingering MustLogin/AccessDenied by setting them to null
                // session not wiped here in case later funtionality requires session data
                Session["Username"] = txtUsername.Text;
                Session["MustLogin"] = null;
                Session["AccessDenied"] = null;
                declareUserType(txtUsername.Text);
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
            sqlCommand.Parameters.AddWithValue("@Username", txtUsername.Text);
            sqlConnect.Open();
            int userType = Convert.ToInt32(sqlCommand.ExecuteScalar());
            sqlConnect.Close();

            if (userType == 1) // user is student (found in Student table)
                Session["UserType"] = "student";
            else // user is member (not found in Student table)
                Session["UserType"] = "mentor";
            Response.Redirect("/profiles/UserProfile.aspx");
        }


        // run query, return number indiating whether password exists
        // i = 0 if password exists. i = 1 if password does not exist
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

        protected void lnkCreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("/login/RegistrationPage.aspx");
        }
    }
}