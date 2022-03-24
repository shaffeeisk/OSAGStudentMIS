using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.mentor
{
    public partial class CreateJob : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected System.Void btnSaveJob_Click()
        {
            // create string from input, send to DB, clear dat.
            // placeholder parts to be replaced included in string
            String sqlQuery = "INSERT INTO Job (Position, Salary, TimeReq, EmployerID) " +
                "VALUES (@Position, @Salary, @TimeReq, @EmployerID);";

            // create sql connection with connection string one-liner
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);

            // create sql command with the existing query and connection one liner
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);

            // parameters.AddWithValue replaces placeholder text (arg1) with data (arg2)
            sqlCommand.Parameters.AddWithValue("@Position", validate(enterJobName.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@Salary", validate(enterSalary.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@EmployerID", ddlEmployer.SelectedValue.ToString());
            if (ddlTime.SelectedValue.ToString() == "0") // handle null entry
                sqlCommand.Parameters.AddWithValue("@TimeReq", DBNull.Value);
            else
                sqlCommand.Parameters.AddWithValue("@TimeReq", ddlTime.SelectedValue);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblSuccess.Text = "New job successfully created";

            // force postback by refreshing page (updates table via Page_Load method)
            Response.Redirect("createJob.aspx");
            // reset for next click
            ClearJobData();
        }

        protected System.Void btnClear_Click()
        {
            ClearJobData();
            // force postback to update table
            Response.Redirect("/mentor/CreateJob.aspx");
        }

        protected void ClearJobData()
        {
            enterJobName.Value = "";
            enterSalary.Value = "";
            ddlTime.SelectedValue = "";
            ddlEmployer.SelectedValue = "";
        }

        // helper method to validate data. trims input string of leading/trailing white space.
        // then returns null if user input is empty. otherwise, returns the trimmed string.
        // allows data integrity to allow querying null input (also saves disk space :D)
        // (e.g. display students who don't have graduation dates so mentor can help them figure out when they should graduate)
        private object validate(String s)
        {
            s = s.Trim();
            if (s == "")
                return (object)DBNull.Value;
            return s;
        }
    }
}