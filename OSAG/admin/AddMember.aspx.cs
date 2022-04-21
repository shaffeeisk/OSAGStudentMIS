/*Code behind for adding new member */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// SQL Imports
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Drawing;
// import password generator
using System.Web.Security;

namespace OSAG.admin
{
    public partial class AddMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        // event handler for create member account button
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            if (usernameExists(txtUsername.Text))
            {
                lblStatus.ForeColor = Color.Red;
                lblStatus.Font.Bold = true;
                lblStatus.Text = "Username " + txtUsername.Text + " is already in use.";
                txtUsername.Text = "";
                return;
            }
            String sqlQuery = "INSERT INTO Member (MemberType, FirstName, LastName, Email, Phone, City, M_State, IsApproved, Username, Pass) " +
                "VALUES (@MemberType, @FirstName, @LastName, @Email, @Phone, @City, @M_State, 'FALSE', @Username, @Pass)";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@MemberType", ddlMemberType.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@FirstName", validate(txtFirstName.Text));
            sqlCommand.Parameters.AddWithValue("@LastName", validate(txtLastName.Text));
            sqlCommand.Parameters.AddWithValue("@Email", validate(txtEmail.Text));
            sqlCommand.Parameters.AddWithValue("@Phone", validatePhone(txtPhone.Text));
            sqlCommand.Parameters.AddWithValue("@City", validate(txtCity.Text));
            sqlCommand.Parameters.AddWithValue("@M_State", validate(txtState.Text));
            sqlCommand.Parameters.AddWithValue("@Username", txtUsername.Text);
            sqlCommand.Parameters.AddWithValue("@Pass", PasswordHash.HashPassword(txtPassword.Text));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            ClearMemberData();
            lblStatus.Text = "User successfully created.";
        }

        // helper method to clear user input
        protected void ClearMemberData()
        {
            ddlMemberType.SelectedValue = "4";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtCity.Text = "";
            txtState.Text = "";
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

        // helper method to validate data. trims input string of leading/trailing white space.
        // then returns null if user input is empty. otherwise, returns the trimmed string.
        // allows data integrity to allow querying null input (also saves disk space :D)
        // (e.g. display students who don't have graduation dates so member can help them figure out when they should graduate)
        private object validate(String s)
        {
            s = s.Trim();
            if (s == "")
                return (object)DBNull.Value;
            return s;
        }

        protected void btnGenerateUser_Click(object sender, EventArgs e)
        {
            txtUsername.Text = removeNonAlpha(Membership.GeneratePassword(15, 0));
        }

        protected void btnGeneratePass_Click(object sender, EventArgs e)
        {
            txtPassword.Text = Membership.GeneratePassword(14, 4);
        }

        // helper method to return non-numeric stripped string from input
        private string validatePhone(string s)
        {
            return new string(s.Where(c => char.IsDigit(c)).ToArray());
        }

        // helper method to return non-letter stripped string from input
        private string removeNonAlpha(string s)
        {
            return new string(s.Where(c => char.IsLetter(c)).ToArray());
        }
    }
}