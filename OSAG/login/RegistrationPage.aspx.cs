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
    public partial class RegistrationPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txtFirstName.Text != "" && txtLastName.Text != "" && txtPassword.Text != "" && txtUsername.Text != "") // all fields must be filled out
            {
                try
                {

                    System.Data.SqlClient.SqlConnection sc = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
                    lblStatus.Text = "Database Connection Successful";

                    sc.Open();

                    System.Data.SqlClient.SqlCommand createUser = new System.Data.SqlClient.SqlCommand();
                    createUser.Connection = sc;
                    // INSERT USER RECORD
                    createUser.CommandText = "INSERT INTO Person (UserType, FirstName, LastName, Username) VALUES (@UserType, @FName, @LName, @Username)";
                    createUser.Parameters.Add(new SqlParameter("@UserType", HttpUtility.HtmlEncode(txtUserType.Text)));
                    createUser.Parameters.Add(new SqlParameter("@FName", HttpUtility.HtmlEncode(txtFirstName.Text)));
                    createUser.Parameters.Add(new SqlParameter("@LName", HttpUtility.HtmlEncode(txtLastName.Text)));
                    createUser.Parameters.Add(new SqlParameter("@Username", HttpUtility.HtmlEncode(txtUsername.Text)));

                    createUser.ExecuteNonQuery();

                    System.Data.SqlClient.SqlCommand setPass = new System.Data.SqlClient.SqlCommand();
                    setPass.Connection = sc;
                    // INSERT PASSWORD RECORD AND CONNECT TO USER
                    setPass.CommandText = "INSERT INTO Pass (UserID, Username, PasswordHash) VALUES ((select max(userid) from person), @Username, @Password)";
                    setPass.Parameters.Add(new SqlParameter("@Username", HttpUtility.HtmlEncode(txtUsername.Text)));
                    setPass.Parameters.Add(new SqlParameter("@Password", PasswordHash.HashPassword(txtPassword.Text))); // hash entered password
                    setPass.ExecuteNonQuery();

                    sc.Close();



                    lblStatus.Text = HttpUtility.HtmlEncode("User committed!");
                    txtFirstName.Enabled = false;
                    txtLastName.Enabled = false;
                    txtUsername.Enabled = false;
                    txtPassword.Enabled = false;
                    btnSubmit.Enabled = false;
                    lnkAnother.Visible = true;
                }
                catch
                {
                    lblStatus.Text = "Database Error - User not committed.";
                }
            }
            else
                lblStatus.Text = "Fill all fields.";

            System.Data.SqlClient.SqlConnection sqlc = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            lblStatus.Text = "Database Connection Successful";

            sqlc.Open();

            if (txtUserType.Text != "Member")
            {

                System.Data.SqlClient.SqlCommand ifStudent = new System.Data.SqlClient.SqlCommand();
                ifStudent.Connection = sqlc;

                ifStudent.CommandText = "INSERT INTO Student (FirstName, LastName, Email) VALUES (@FirstName, @LastName, @Email)";
                ifStudent.Parameters.Add(new SqlParameter("@FirstName", HttpUtility.HtmlEncode(txtFirstName.Text)));
                ifStudent.Parameters.Add(new SqlParameter("@LastName", HttpUtility.HtmlEncode(txtLastName.Text)));
                ifStudent.Parameters.Add(new SqlParameter("@Email", HttpUtility.HtmlEncode(txtEmail.Text)));
                ifStudent.ExecuteNonQuery();
            }
            else
            {
                System.Data.SqlClient.SqlCommand ifMember = new System.Data.SqlClient.SqlCommand();
                ifMember.Connection = sqlc;

                ifMember.CommandText = "INSERT INTO Mentor (FirstName, LastName, Email) VALUES (@FName, @LName, @Email)";
                ifMember.Parameters.Add(new SqlParameter("@FName", HttpUtility.HtmlEncode(txtFirstName.Text)));
                ifMember.Parameters.Add(new SqlParameter("@LName", HttpUtility.HtmlEncode(txtLastName.Text)));
                ifMember.Parameters.Add(new SqlParameter("@Email", HttpUtility.HtmlEncode(txtEmail.Text)));
                ifMember.Parameters.Add(new SqlParameter("@PhoneNumber", HttpUtility.HtmlEncode(txtPhone.Text)));
                ifMember.ExecuteNonQuery();
            }

            sqlc.Close();
        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginPage.aspx", false);
        }

        protected void lnkAnother_Click(object sender, EventArgs e)
        {
            txtFirstName.Enabled = true;
            txtLastName.Enabled = true;
            txtUsername.Enabled = true;
            txtPassword.Enabled = true;
            btnSubmit.Enabled = true;
            lnkAnother.Visible = false;
            txtFirstName.Text = HttpUtility.HtmlEncode("");
            txtLastName.Text = HttpUtility.HtmlEncode("");
            txtUsername.Text = HttpUtility.HtmlEncode("");
            txtPassword.Text = HttpUtility.HtmlEncode("");
        }
    }
}