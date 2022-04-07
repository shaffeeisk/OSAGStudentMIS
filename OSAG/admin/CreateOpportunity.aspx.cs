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
        
        // event handler for save opportunity button. executes query and clears input, displaying success message
        protected void btnSaveOpportunity_Click(object sender, EventArgs e)
        {
            String sqlQuery = "INSERT INTO Opportunity " +
                "(OpportunityName, OpportunityDescription, EventDate, ApplicationDeadline, IsScholarship, OpportunityAward) " +
                "VALUES " +
                "(@OpportunityName, @OpportunityDescription, @EventDate, @ApplicationDeadline, @IsScholarship, @OpportunityAward);";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@OpportunityName", validate(txtOpportunityName.Text));
            sqlCommand.Parameters.AddWithValue("@OpportunityDescription", validate(txtDescription.Text));
            sqlCommand.Parameters.AddWithValue("@EventDate", validate(txtEventDate.Text));
            sqlCommand.Parameters.AddWithValue("@ApplicationDeadline", validate(txtDeadline.Text));
            if(ckbxIsScholarship.Checked)
                sqlCommand.Parameters.AddWithValue("@IsScholarship", true);
            else
                sqlCommand.Parameters.AddWithValue("@IsScholarship", false);
            sqlCommand.Parameters.AddWithValue("@OpportunityAward", validate(txtAward.Text));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            ClearOpportunityData();
            lblSuccess.Text = "New opportunity successfully created";
        }

        // event handler to clear input
        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearOpportunityData();
        }

        // helper method to clear input
        protected void ClearOpportunityData()
        {
            txtOpportunityName.Text = "";
            txtAward.Text = "";
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