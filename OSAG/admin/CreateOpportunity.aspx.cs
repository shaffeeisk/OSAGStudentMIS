/*code behind for creating opportunity*/
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
            if (OpportunityExists(txtOpportunityName.Text, ddlCompany.SelectedValue.ToString())) // check if a similar opportunity already exists
            {
                lblSuccess.Text = "An opportunity for " + ddlCompany.SelectedItem.ToString() + " with the same name already exists. Continue adding?";
                btnOverride.Visible = true;
                btnCancel.Visible = true;
                btnSaveOpportunity.Visible = false;
            }
            else
                SaveOpportunity(); 
        }

        // event handler for override button
        protected void btnOverride_Click(object sender, EventArgs e)
        {
            SaveOpportunity();
            btnOverride.Visible = false;
            btnCancel.Visible = false;
            btnSaveOpportunity.Visible = true;
            // reset for next click
            ClearOpportunityData();
        }

        // event handler for cancel button
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            lblSuccess.Text = "";
            btnOverride.Visible = false;
            btnCancel.Visible = false;
            btnSaveOpportunity.Visible = true;
        }

        // event handler to clear input
        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearOpportunityData();
        }

        // helper method to determine if opportunity exists
        protected bool OpportunityExists(string name, string company)
        {
            String sqlQuery = "SELECT COUNT(*) FROM Opportunity WHERE OpportunityName = @OpportunityName AND CompanyID ";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            // query does not work with = null, must use IS NULL instead
            if (ddlCompany.SelectedValue == "")
                sqlQuery += "IS NULL;";
            else
                sqlQuery += "= '" + ddlCompany.SelectedValue + "';";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@OpportunityName", txtOpportunityName.Text);
            sqlConnect.Open();
            int i = Int32.Parse(sqlCommand.ExecuteScalar().ToString());
            sqlConnect.Close();
            if (i > 0)
                return true;
            return false;
        }

        // helper method to save opportunity
        protected void SaveOpportunity()
        {
            String sqlQuery = "INSERT INTO Opportunity " +
                "(OpportunityName, OpportunityDescription, EventDate, ApplicationDeadline, CompanyID) " +
                "VALUES " +
                "(@OpportunityName, @OpportunityDescription, @EventDate, @ApplicationDeadline, @CompanyID);";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@OpportunityName", validate(txtOpportunityName.Text));
            sqlCommand.Parameters.AddWithValue("@OpportunityDescription", validate(txtDescription.Text));
            sqlCommand.Parameters.AddWithValue("@EventDate", validate(txtEventDate.Text));
            sqlCommand.Parameters.AddWithValue("@ApplicationDeadline", validate(txtDeadline.Text));
            sqlCommand.Parameters.AddWithValue("@CompanyID", validate(ddlCompany.SelectedValue));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            
            // display success message and reset input
            lblSuccess.Text = "New opportunity successfully created";
            ClearOpportunityData();
            dlistOpportunities.DataBind();
        }

        // helper method to clear input
        protected void ClearOpportunityData()
        {
            txtOpportunityName.Text = "";
            txtDescription.Text = "";
            txtDeadline.Text = "";
            txtEventDate.Text = "";
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