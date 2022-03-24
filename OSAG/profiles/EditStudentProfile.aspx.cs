using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// sql imports
using System.Data;
using System.Data.SqlClient;
// web.config imports
using System.Web.Configuration;
// colored response import
using System.Drawing;
// For File read
using System.IO;

namespace OSAG.profiles
{
    public partial class EditStudentProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // so data does not replace itself when clicking button to commit changes
            {                // i forgot button clicks cause postback.
                try
                {
                    populatePage();
                }
                catch (SqlException)
                {
                    Session["MustLogIn"] = "You must log in to access that page.";
                    Response.Redirect("/login/Login.aspx");
                    throw;
                }
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileResume.HasFile)
            {
                String fpath = Request.PhysicalApplicationPath + "resumes\\" + Session["Username"] + ".pdf";
                File.Delete(fpath);
                fileResume.SaveAs(fpath);
            }
            else
                lblStatus.Text = "Something went wrong!";
            // force postback
            Response.Redirect("/profiles/EditStudentProfile.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            String sqlQuery = "UPDATE Student SET " +
               "FirstName = @FN, " +
               "LastName = @LN, " +
               "Email = @Email, " +
               "GraduationDate = @GradDate, " +
               "EmployerID = @EmpID " +
               "WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", (String)Session["Username"]);
            sqlCommand.Parameters.AddWithValue("@FN", validate(firstName.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@LN", validate(lastName.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@Email", validate(email.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@GradDate", validate(gradDate.Value.ToString()));
            if (ddlEmployers.SelectedValue == "0") // if unemployed, set EmployerID to null
                sqlCommand.Parameters.AddWithValue("@EmpID", DBNull.Value); // blank box value is "0"
            else
                sqlCommand.Parameters.AddWithValue("@EmpID", ddlEmployers.SelectedValue); // otherwise take input as param
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblUpdateStatus.Text = "Profile successfully updated.";
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("/profiles/StudentProfile.aspx");
        }

        protected void populatePage()
        {
            String sqlQuery = "SELECT FirstName, LastName, Email, GraduationDate, EmployerID FROM Student WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", (String)Session["Username"]);
            sqlConnect.Open();
            SqlDataReader queryResults = sqlCommand.ExecuteReader();
            queryResults.Read();
            firstName.Value = queryResults["FirstName"].ToString();
            lastName.Value = queryResults["LastName"].ToString();
            email.Value = queryResults["Email"].ToString();
            gradDate.Value = DateTime.Parse(queryResults["GraduationDate"].ToString()).ToString("yyyy-MM-dd"); // why
            if (queryResults["EmployerID"] == DBNull.Value) // if empID is null set selected value to 0
                ddlEmployers.SelectedValue = "0";
            else // load page with current employer
                ddlEmployers.SelectedValue = queryResults["EmployerID"].ToString();
            queryResults.Close();
            sqlConnect.Close();
            // iframe will only try to display a file if it exists. otherwise, nothing happens and its Src remains blank.
            // since this entire method is called on page load, it is TECHNICALLY a live-preview. As long as PostBack works.
            if (File.Exists(Request.PhysicalApplicationPath + "resumes\\" + Session["Username"] + ".pdf"))
                embedResume.Src = "/resumes/" + (String)Session["Username"] + ".pdf"; 
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