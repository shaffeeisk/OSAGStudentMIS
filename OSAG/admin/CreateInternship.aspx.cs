/*code behind for creating internship*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// SQL imports
using System.Data;
using System.Data.SqlClient;
// web.config imports
using System.Web.Configuration;
using System.Web.UI.HtmlControls;

namespace OSAG.member
{
    public partial class CreateInternship : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSaveIntern_Click(object sender, EventArgs e)
        {
            if (ddlCompany.SelectedValue == "") // ensure a company is selected to prevent sql errors
                lblSuccess.Text = "Please select a company.";
            else if (internshipExists(txtInternshipName.Text, ddlCompany.SelectedValue.ToString())) // check if a similar internship already exists
            {
                lblSuccess.Text = "An internship for " + ddlCompany.SelectedItem.ToString() + " with the same name already exists. Continue adding?";
                btnOverride.Visible = true;
                btnCancel.Visible = true;
                btnSaveIntern.Visible = false;
            }
            else
                saveInternship();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearInternData();
        }

        // event handler for override button
        protected void btnOverride_Click(object sender, EventArgs e)
        {
            saveInternship();
            btnOverride.Visible = false;
            btnCancel.Visible = false;
            btnSaveIntern.Visible = true;
            // reset for next click
            ClearInternData();
        }

        // event handler for cancel button
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            lblSuccess.Text = "";
            btnOverride.Visible = false;
            btnCancel.Visible = false;
            btnSaveIntern.Visible = true;
        }

        // helper method to determine if internship exists
        protected bool internshipExists(string name, string company)
        {
            String sqlQuery = "SELECT COUNT(*) FROM Internship WHERE InternshipName = @InternshipName AND CompanyID = '" + ddlCompany.SelectedValue + "';";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@InternshipName", txtInternshipName.Text);
            sqlConnect.Open();
            int i = Int32.Parse(sqlCommand.ExecuteScalar().ToString());
            sqlConnect.Close();
            if (i > 0)
                return true;
            return false;
        }
        
        // helper method to save internship
        protected void saveInternship()
        {
            // execute parameterized insert statement
            String sqlQuery = "INSERT INTO Internship (InternshipName, InternshipDescription, ApplicationDeadline, StartDate, WeeklyHours, Payment, CompanyID) " +
                "VALUES (@InternshipName, @InternshipDescription, @ApplicationDeadline, @StartDate, @WeeklyHours, @Payment, @CompanyID);";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@InternshipName", txtInternshipName.Text);
            sqlCommand.Parameters.AddWithValue("@InternshipDescription", validate(txtInternshipDescription.Text));
            sqlCommand.Parameters.AddWithValue("@ApplicationDeadline", validate(txtApplicationDeadline.Text));
            sqlCommand.Parameters.AddWithValue("@StartDate", validate(txtStartDate.Text));
            sqlCommand.Parameters.AddWithValue("@WeeklyHours", validate(txtWeeklyHours.Text));
            sqlCommand.Parameters.AddWithValue("@Payment", validate(txtPayment.Text));
            sqlCommand.Parameters.AddWithValue("@CompanyID", ddlCompany.SelectedValue.ToString());
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            
            // display success message and reset input
            lblSuccess.Text = "New internship(s) successfully created";
            ClearInternData();
        }

        protected void ClearInternData()
        {
            txtInternshipName.Text = "";
            txtInternshipDescription.Text = "";
            txtApplicationDeadline.Text = "";
            txtStartDate.Text = "";
            txtWeeklyHours.Text = "";
            txtPayment.Text = "";
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