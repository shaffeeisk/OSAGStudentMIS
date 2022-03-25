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

            if ((String)Session["Username"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }
            else if ((String)Session["UserType"] == "student")
            {
                Session["AccessDenied"] = "You do not have access to that page.";
                Response.Redirect("/profiles/StudentProfile.aspx");
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            // update command, helper method used to determine table to be used
            String sqlQuery = "UPDATE USERTYPE SET IsApproved = 'TRUE' WHERE Username = @Username;";
            sqlQuery = sqlQuery.Replace("USERTYPE", ParamUserType(lstSelectNewUser.SelectedValue));

            // def connections, create commands, insert parameter, and execute query
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", lstSelectNewUser.SelectedValue);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();

            // refresh page and inform the user (admin) that the user was successfully approved
            Response.Redirect("ApproveRegistration.aspx");
            lblStatus.Text = "User successfully approved.";
        }

        // queries Student table, returns "Student" if student is found, "Mentor" if not
        protected String ParamUserType(String s)
        {
            // create and execute query
            String sqlQuery = "SELECT COUNT(*) FROM Student WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", lstSelectNewUser.SelectedValue);
            sqlConnect.Open();
            int userType = Convert.ToInt32(sqlCommand.ExecuteScalar());
            sqlConnect.Close();

            // return String value
            if (userType == 1) // user is student (found in Student table)
                return "Student";
            else // user is mentor (not found in Student table)
                return "Mentor";
        }
    }
}