/*code behind for create job */
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
    public partial class CreateJob : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSaveJob_Click(object sender, EventArgs e)
        {
            if (ddlCompany.SelectedValue == "") // ensure a company is selected to prevent sql errors
                lblSuccess.Text = "Please select a company.";
            else if (jobExists(txtJobName.Text, ddlCompany.SelectedValue.ToString())) // check if a similar job already exists
            {
                lblSuccess.Text = "A job for " + ddlCompany.SelectedItem.ToString() + " with the same name already exists. Continue adding?";
                btnOverride.Visible = true;
                btnCancel.Visible = true;
                btnSaveJob.Visible = false;
            }
            else
                saveJob();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearJobData();
        }

        // event handler for override button
        protected void btnOverride_Click(object sender, EventArgs e)
        {
            saveJob();
            btnOverride.Visible = false;
            btnCancel.Visible = false;
            btnSaveJob.Visible = true;
            // reset for next click
            ClearJobData();
        }

        // event handler for cancel button
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            lblSuccess.Text = "";
            btnOverride.Visible = false;
            btnCancel.Visible = false;
            btnSaveJob.Visible = true;
        }

        // helper method to determine if job exists
        protected bool jobExists(string name, string company)
        {
            String sqlQuery = "SELECT COUNT(*) FROM Job WHERE JobName = @JobName AND CompanyID = '" + ddlCompany.SelectedValue + "';";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@JobName", txtJobName.Text);
            sqlConnect.Open();
            int i = Int32.Parse(sqlCommand.ExecuteScalar().ToString());
            sqlConnect.Close();
            if (i > 0)
                return true;
            return false;
        }

        // helper method to save job
        protected void saveJob()
        {
            // execute parameterized insert statement
            String sqlQuery = "INSERT INTO Job (JobName, JobDescription, ApplicationDeadline, StartDate, WeeklyHours, Payment, CompanyID) " +
                "VALUES (@JobName, @JobDescription, @ApplicationDeadline, @StartDate, @WeeklyHours, @Payment, @CompanyID);";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@JobName", txtJobName.Text);
            sqlCommand.Parameters.AddWithValue("@JobDescription", validate(txtJobDescription.Text));
            sqlCommand.Parameters.AddWithValue("@ApplicationDeadline", validate(txtApplicationDeadline.Text));
            sqlCommand.Parameters.AddWithValue("@StartDate", validate(txtStartDate.Text));
            sqlCommand.Parameters.AddWithValue("@WeeklyHours", validate(txtWeeklyHours.Text));
            sqlCommand.Parameters.AddWithValue("@Payment", validate(txtPayment.Text));
            sqlCommand.Parameters.AddWithValue("@CompanyID", ddlCompany.SelectedValue.ToString());
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();

            // display success message and reset input
            lblSuccess.Text = "New job(s) successfully created";
            ClearJobData();
        }

        protected void ClearJobData()
        {
            txtJobName.Text = "";
            txtJobDescription.Text = "";
            txtApplicationDeadline.Text = "";
            txtStartDate.Text = "";
            txtWeeklyHours.Text = "";
            txtPayment.Text = "";
            ddlCompany.SelectedValue = "";
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