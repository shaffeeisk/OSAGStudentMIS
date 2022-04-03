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
    public partial class CreateOpportunity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSaveSchol_Click(object sender, EventArgs e)
        {
            // create string from input, send to DB, clear dat.
            // placeholder parts to be replaced included in string
            String sqlQuery = "INSERT INTO Scholarship (AwardName, AwardAmount, AwardDescription) " +
                "VALUES (@AwardName, @AwardAmount,@AwardDescription);";

            // create sql connection with connection string one-liner
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

            // create sql command with the existing query and connection one liner
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);

            // parameters.AddWithValue replaces placeholder text (arg1) with data (arg2)
            sqlCommand.Parameters.AddWithValue("@AwardName", validate(txtAwardName.Text));
            sqlCommand.Parameters.AddWithValue("@DollarAmount", validate(txtAmount.Text));
            sqlCommand.Parameters.AddWithValue("@AwardDescription", validate(txtDescription.Text));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblSuccess.Text = "New scholarship successfully created";

            // force postback by refreshing page (updates table via Page_Load method)
            Response.Redirect("/member/CreateScholarship.aspx");
            // reset for next click
            ClearScholData();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearScholData();
            // force postback to update table
            Response.Redirect("/member/CreateScholarship.aspx");
        }
        protected void ClearScholData()
        {
            txtAwardName.Text = "";
            txtAmount.Text = "";
            txtDescription.Text = "";
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