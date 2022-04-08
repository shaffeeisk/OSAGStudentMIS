/* code behind for complete registration */
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
    public partial class CompleteRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
                return; // runs .master page_load instead
            if(isApproved(Session["Username"].ToString()) || Session["UserType"].ToString() != "member")
            {   // send user to profile if student or acc already approved
                Session["AccessDenied"] = "You do not have access to that page.";
                Response.Redirect("/profiles/UserProfile.aspx");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txtUsername.Text == "" || txtPassword.Text == "")
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

            String sqlQuery = "UPDATE Member SET (Username = @Username, Pass = @Password) WHERE Username = '" + Session["Username"] + "';";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", txtUsername.Text);
            sqlCommand.Parameters.AddWithValue("@Password", PasswordHash.HashPassword(txtPassword.Text));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Session["Username"] = txtUsername.Text;
            lblStatus.Text = "Registration successfully completed. Click the button below to view your profile.";
            btnSubmit.Visible = false;
            btnContinue.Visible = true;
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            Response.Redirect("/profiles/UserProfile.aspx");
        }

        // helper method running query to determine if user is approved
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
    }
}