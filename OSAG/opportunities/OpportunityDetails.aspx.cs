/* code behind for opportunity details*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//Sql Imports
using System.Data;
using System.Data.SqlClient;
//Connection Strings in web.config
using System.Web.Configuration;

namespace OSAG.opportunities
{
    public partial class OpportunityDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                    ViewState["PreviousPage"] = Request.UrlReferrer;
                
                //Query
                String sqlQuery = "SELECT  OpportunityName, OpportunityDescription, EventDate, ApplicationDeadline, " +
                    "IsScholarship, OpportunityAward FROM Opportunity WHERE Opportunity.OpportunityID = '" + Session["View"].ToString() + "'";
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnection);

                // Execute the Query and display results
                sqlConnection.Open();
                SqlDataReader queryResults = sqlCommand.ExecuteReader();
                queryResults.Read();
                lblDetails1.Text = "Opportunity Name: " + queryResults["OpportunityName"].ToString();
                lblDetails2.Text = "Description: " + queryResults["OpportunityDescription"].ToString();
                lblDetails3.Text = "Event Date: " + queryResults["EventDate"].ToString();
                lblDetails4.Text = "Application Deadline: " + queryResults["ApplicationDeadline"].ToString();
                lblDetails5.Text = "Scholarship? " + queryResults["IsScholarship"].ToString();
                lblDetails6.Text = "Scholarship Award: " + queryResults["OpportunityAward"].ToString();
            }
            catch (NullReferenceException)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
                throw;
            }

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            if (ViewState["PreviousPage"] != null)
            {
                Response.Redirect(ViewState["PreviousPage"].ToString());
            }
        }
    }
}