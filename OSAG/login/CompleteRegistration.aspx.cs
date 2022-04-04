using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.login
{
    public partial class CompleteRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
                return;
            if(Session["UserType"].ToString() != "member")
            {
                Session["AccessDenied"] = "You do not have access to that page.";
                Response.Redirect("UserProfile.aspx");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {

        }

        // run query, return number indiating whether user is approved
        protected bool isApproved(String s)
        {
            String sqlQuery = "EXEC dbo.OSAG_NotApproved @Username";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", txtUsername.Text);
            sqlConnect.Open();
            int i = Convert.ToInt32(sqlCommand.ExecuteScalar());
            sqlConnect.Close();

            // return bool
            if (i == 1)
                return false;
            return true;
        }
    }
}