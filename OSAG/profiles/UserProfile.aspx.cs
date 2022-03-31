using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
//Connection Strings in web.config
using System.Web.Configuration;
using System.Drawing;
using System.IO;

namespace OSAG.profiles
{
    public partial class UserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }

            // only when loading page for the first time
            if (!IsPostBack)
            {
                // define connection to DB and query String
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
                String sqlQuery;

                if (Session["UserType"].ToString() == "student")
                {
                    sqlQuery = "SELECT FirstName, LastName, Email, GradDate, Major FROM Student WHERE Username = '" + Session["Username"].ToString() + "';";
                    SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();

                    // read data onto page
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read()) // this will read the single record that matches the entered username
                    {
                        txtFirstName.Text = reader["FirstName"].ToString();
                        txtLastName.Text = reader["LastName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        txtGradDate.Text = DateTime.Parse(reader["GradDate"].ToString()).ToString("yyy-MM-dd");
                        txtMajor.Text = reader["Major"].ToString();
                    }
                    sqlConnect.Close();

                    // populate resume embed
                    String fpath = Request.PhysicalApplicationPath + "textfiles\\" + Session["Username"].ToString() + ".pdf";
                    if (File.Exists(fpath))
                    {
                        ltEmbed.Visible = true;
                        string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"500px\" height=\"300px\">";
                        embed += "If you are unable to view file, you can download from <a href = \"{0}\">here</a>";
                        embed += " or download <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
                        embed += "</object>";
                        ltEmbed.Text = string.Format(embed, ResolveUrl("~/textfiles/" + Session["Username"].ToString() + ".pdf"));
                    }
                }
                else if (Session["UserType"].ToString() == "mentor") // in case there is coder error
                {
                    sqlQuery = "SELECT FirstName,LastName,Email,City,M_State FROM Mentor WHERE Username =  '" + Session["Username"].ToString() + "'; ";
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

        // event handler for profile update. if/else depends on user type
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // define connection to DB and query String
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            String sqlQuery;

            if (Session["UserType"].ToString() == "student")
            {
                sqlQuery = "UPDATE [Student] SET [FirstName] = '" + txtFirstName.Text + "', [LastName] = '" + txtLastName.Text + "'," +
                "[Email] = '" + txtEmail.Text + "'," +
                "[Major] = '" + txtMajor.Text + "'," +
                "[GradDate] = '" + txtGradDate.Text + "' " +
                " WHERE[Username] = '" + Session["Username"].ToString() + "'";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }
            else if (Session["UserType"].ToString() == "mentor")
            {
                sqlQuery = "UPDATE [Mentor] SET [FirstName] = '" + mtxtFirstName.Text + "', [LastName] = '" + mtxtLastName.Text + "'," +
                "[Email] = '" + txtMentorEmail.Text + "'," +
                "[M_State] = '" + txtState.Text + "'," +
                "[City] = '" + txtCity.Text + "' " +
                " WHERE[Username] = '" + Session["Username"].ToString() + "'";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }
        }

        // event handler for resume upload button
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            // set embed visibility to true
            ltEmbed.Visible = true;
            // check if file exists
            if (!Directory.Exists(Server.MapPath("~/Files")))
                Directory.CreateDirectory(Server.MapPath("~/Files"));

            // upload resume if a file was uploaded
            if (fileUploadText.HasFile)
            {
                String fpath = Request.PhysicalApplicationPath + "textfiles\\" +
                 Session["Username"].ToString() + ".pdf";
                fileUploadText.SaveAs(fpath);
                if (File.Exists(fpath))
                {
                    string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"500px\" height=\"300px\">";
                    embed += "</object>";
                    ltEmbed.Text = string.Format(embed, ResolveUrl("~/textfiles/" + Session["Username"].ToString() + ".pdf"));
                }
            }
        }
    }
}
