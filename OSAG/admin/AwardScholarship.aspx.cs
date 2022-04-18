using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
// web.config imports
using System.Web.Configuration;
using System.Web.UI.HtmlControls;

namespace OSAG.admin
{
    public partial class AwardScholarship : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                // return; <-- alternative solution (Master Page_Load runs instead)
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }

        }
        protected void btnSaveScholarship_Click(object sender, EventArgs e)
        {
            if (ddl_Student.SelectedValue == "") // ensure a company is selected to prevent sql errors
                lblSuccess.Text = "Please select a company.";
            else
                SaveScholarship();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearScholarshipData();
        }


        // helper method to save Scholarship
        protected void SaveScholarship()
        {
            // execute parameterized insert statement
            String sqlQuery = "INSERT INTO Scholarship (AwardeeID, AwardYear, ApplicationDeadline, AwardAmount) " +
                "VALUES (@AwardeeID, @AwardYear, @ApplicationDeadline, @AwardAmount);";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@AwardeeID", ddl_Student.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@AwardYear", validate(txtYear.Text));
            sqlCommand.Parameters.AddWithValue("@ApplicationDeadline", validate(txtDeadline.Text));
            sqlCommand.Parameters.AddWithValue("@AwardAmount", validate(txtAwardAmount.Text));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();

            // display success message and reset input
            lblSuccess.Text = "New Scholarship successfully created";
            ClearScholarshipData();
        }

        protected void ClearScholarshipData()
        {
            
            txtYear.Text = "";
            txtDeadline.Text = "";
            txtAwardAmount.Text = "";
            ddl_Student.SelectedValue = "";
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
    }
}