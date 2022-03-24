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

namespace OSAG.admin
{
    public partial class ApproveRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if ((String)Session["Username"] != "admin")
            //{
            //    Session["AccessDenied"] = "You do not have access to that page.";
            //    if ((String)Session["UserType"] == "student")
            //        Response.Redirect("studentHome.aspx");
            //    else if ((String)Session["UserType"] == "member")
            //        Response.Redirect("memberHome.aspx");
            //    else
            //        Response.Redirect("homePage.aspx");
            //}

        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            // update user
            String sqlQuery = "UPDATE @UserType SET IsApproved = 1 WHERE Username = @Username;";

            // def connections, create commands and insert parameters
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", lstSelectNewUser.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@UserType", "student"); // how to pull usertype?

            // execute query
            sqlConnect.Open();
            String s = (String)sqlCommand.ExecuteScalar();
            sqlConnect.Close();

            // refresh page and inform the user (admin) that the user was successfully approved
            Response.Redirect("ApproveRegistration.aspx");
            lblStatus.Text = "User successfully approved.";
        }
    }
}