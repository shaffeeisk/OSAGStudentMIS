/*Code behind for registration page */
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
    public partial class RegistrationPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
                lblStatus.Text = "Welcome! Please enter your new profile information.";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // REPLACE WITH INPUT VALIDATOR???S??????????
            if (txtUsername.Text == "" || txtPassword.Text == "" || txtFirstName.Text == "" || txtLastName.Text == "")
            {
                lblStatus.ForeColor = Color.Red;
                lblStatus.Font.Bold = true;
                lblStatus.Text = "Please fill out all fields.";
                return;
            }

            if (usernameExists(txtUsername.Text))
            {
                lblStatus.ForeColor = Color.Red;
                lblStatus.Font.Bold = true;
                lblStatus.Text = "Username " + txtUsername.Text + " has already been taken";
                txtUsername.Text = "";
                return;
            }

            // run query (ONLY STUDENTS NOW)
            String sqlQuery = "INSERT INTO Student (Username, Pass, RegistrationYear, FirstName, LastName, IsApproved, Email) " +
                "VALUES (@Username, @Pass, @RegistrationYear, @FirstName, @LastName, 'FALSE', @Email);";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", txtUsername.Text);
            sqlCommand.Parameters.AddWithValue("@Pass", PasswordHash.HashPassword(txtPassword.Text));
            sqlCommand.Parameters.AddWithValue("@RegistrationYear", DateTime.Now.Year);
            sqlCommand.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
            sqlCommand.Parameters.AddWithValue("@LastName", txtLastName.Text);
            sqlCommand.Parameters.AddWithValue("@Email", txtEmail.Text);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();

            // redirect to signup complete
            Session["TempUsername"] = txtUsername.Text;
            Session["UserType"] = "student";
            Response.Redirect("SignUpComplete.aspx");
        }

        // helper method to query student and member tables for existing username
        // if count is > 0 return true, otherwise return false
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

        // event handler for Login button
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("/login/LoginPage.aspx");
        }

        // helper method to clear text boxes
        protected void ClearData()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
            txtEmail.Text = "";
        }
    }
}