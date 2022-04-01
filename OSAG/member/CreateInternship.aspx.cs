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
            // create string from input, send to DB, clear dat.
            // placeholder parts to be replaced included in string
            String sqlQuery = "INSERT INTO Internship (InternshipName, InternshipDescription, ApplicationDeadline, StartDate, WeeklyHours, Payment, CompanyID) " +
                "VALUES (@InternshipName, @InternshipDescription, @ApplicationDeadline, @StartDate, @WeeklyHours, @Payment, @CompanyID);";

            // create sql connection with connection string one-liner
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

            // create sql command with the existing query and connection one liner
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);

            // parameters.AddWithValue replaces placeholder text (arg1) with data (arg2)
            sqlCommand.Parameters.AddWithValue("@InternshipName", txtInternshipName.Text);
            sqlCommand.Parameters.AddWithValue("@InternshipDescription", validate(txtInternshipDescription.Text));
            sqlCommand.Parameters.AddWithValue("@ApplicationDeadline", validate(txtApplicationDeadline.Text));
            sqlCommand.Parameters.AddWithValue("@StartDate", validate(txtStartDate.Text));
            sqlCommand.Parameters.AddWithValue("@WeeklyHours", validate(txtWeeklyHours.Text));
            sqlCommand.Parameters.AddWithValue("@Payment", validate(txtPayment.Text));
            sqlCommand.Parameters.AddWithValue("@CompanyID", ddlCompany.SelectedValue.ToString());
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblSuccess.Text = "New internship(s) successfully created";

            // force postback by refreshing page (updates table via Page_Load method)
            Response.Redirect("/member/CreateInternship.aspx");
            // reset for next click
            ClearInternData();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearInternData();
            // force postback to update table
            Response.Redirect("/member/createInternship.aspx");
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