using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//SQL imports
using System.Data;
using System.Data.SqlClient;
//Connection Strings in web.config
using System.Web.Configuration;
using System.Drawing;
using System.IO;

namespace OSAG.profiles
{
    public partial class ViewProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // prevent errors when trying to access page illegally >:(
            if (Session["Username"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }
            if (Session["ViewProfileUsername"] == null)
            {
                Session["AccessDenied"] = "Access Denined: An unknown error has occurred.";
                Response.Redirect("UserProfile.aspx");
            }

            // on page initialization
            if (!IsPostBack)
            {
                // define db connection
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
                String sqlQuery;

                // if trying to view a student
                if (Session["ViewProfileUserType"].ToString() == "student")
                {
                    // query for student data
                    sqlQuery = "SELECT FirstName,LastName,Email,GradDate, Major FROM Student WHERE Username = '" + Session["ViewProfileUsername"].ToString() + "';";
                    SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();

                    // read data onto page
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        txtFirstName.Text = reader["FirstName"].ToString();
                        txtLastName.Text = reader["LastName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        txtGradDate.Text = DateTime.Parse(reader["GradDate"].ToString()).ToString("yyy-MM-dd");
                        txtMajor.Text = reader["Major"].ToString();
                    }
                    sqlConnect.Close();

                    // and populate embed with resume (only if student)
                    String fpath = Request.PhysicalApplicationPath + "textfiles\\" + Session["ViewProfileUsername"].ToString() + ".pdf";
                    if (File.Exists(fpath))
                    {
                        ltEmbed.Visible = true;
                        string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"500px\" height=\"300px\">";
                        embed += "If you are unable to view file, you can download from <a href = \"{0}\">here</a>";
                        embed += " or download <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
                        embed += "</object>";
                        ltEmbed.Text = string.Format(embed, ResolveUrl("~/textfiles/" + Session["ViewProfileUsername"].ToString() + ".pdf"));
                    }
                }

                // otherwise querying mentor
                else if (Session["ViewProfileUserType"].ToString() == "mentor") // in case there is coder error
                {
                    sqlQuery = "SELECT FirstName,LastName,Email,City,M_State FROM Mentor WHERE Username =  '" + Session["ViewProfileUsername"].ToString() + "'; ";
                    SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();

                    // read data onto page
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        mtxtFirstName.Text = reader["FirstName"].ToString();
                        mtxtLastName.Text = reader["LastName"].ToString();
                        txtMentorEmail.Text = reader["Email"].ToString();
                        txtCity.Text = reader["City"].ToString();
                        txtState.Text = reader["M_State"].ToString();
                    }
                    sqlConnect.Close();
                }
            }
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListUsers.aspx");
        }
    }
}