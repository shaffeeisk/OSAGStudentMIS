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

namespace OSAG.admin
{
    public partial class AddMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Username"] = "admin";
            Session["UserType"] = "member";
        }

        // event handler for create member account button
        protected void btnCreate_Click(object sender, EventArgs e)
        {            
            String sqlQuery = "INSERT INTO Member (MemberType, FirstName, LastName, Email, PhoneNumber, City, M_State, IsApproved) " +
                "VALUES (@MemberType, @FirstName, @LastName, @Email, @PhoneNumber, @City, @M_State, 'FALSE')";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@MemberType", ddlMemberType.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@FirstName", validate(txtFirstName.Text));
            sqlCommand.Parameters.AddWithValue("@LastName", validate(txtLastName.Text));
            sqlCommand.Parameters.AddWithValue("@Email", validate(txtEmail.Text));
            sqlCommand.Parameters.AddWithValue("@PhoneNumber", validatePhone(txtPhone.Text));
            sqlCommand.Parameters.AddWithValue("@City", validate(txtCity.Text));
            sqlCommand.Parameters.AddWithValue("@M_State", validate(txtState.Text));
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

        // helper method to return non-numeric stripped string from input
        private string validatePhone(String i)
        {
            return new string(i.Where(c => char.IsDigit(c)).ToArray());
        }
    }
}