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
                {
                    ViewState["PreviousPage"] =
                Request.UrlReferrer;
                }
                //Query
                String sqlQuery = "Select 'Award Name: ' + AwardName as Name, 'Award Amount: ' +  FORMAT(AwardAmount,'C') as Amount, 'Award Description: ' + AwardDescription as Description from Opportunity where AwardName = '" + Session["View"].ToString()
                    + "'";

                // Define the Connection
                SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

                //Create and Format the Command
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnection;
                sqlCommand.CommandType = CommandType.Text;
                sqlCommand.CommandText = sqlQuery;

                // Execute the Query and get results
                sqlConnection.Open();
                SqlDataReader queryResults = sqlCommand.ExecuteReader();
                while (queryResults.Read())
                {
                    lblDetails.Text = queryResults["Name"].ToString();
                    lblDetails2.Text = queryResults["Amount"].ToString();
                    lblDetails3.Text = queryResults["Description"].ToString();
                }
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