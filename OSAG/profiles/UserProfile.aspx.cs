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
            String fpath = Request.PhysicalApplicationPath + "textfiles\\" +
            Session["UserName"].ToString() + ".pdf";
            if (File.Exists(fpath))
            {
                ltEmbed.Visible = true;
                string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"500px\" height=\"300px\">";
                embed += "If you are unable to view file, you can download from <a href = \"{0}\">here</a>";
                embed += " or download <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
                embed += "</object>";
                ltEmbed.Text = string.Format(embed, ResolveUrl("~/textfiles/" + Session["UserName"].ToString() + ".pdf"));
            }
            System.Data.SqlClient.SqlConnection sc = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            if (!IsPostBack)
            {
                if (Session["UserType"].ToString() == "Student")
                {
                    sc.Open();
                    System.Data.SqlClient.SqlCommand findPass = new System.Data.SqlClient.SqlCommand();
                    findPass.Connection = sc;
                    // SELECT PASSWORD STRING WHERE THE ENTERED USERNAME MATCHES
                    findPass.CommandText = "SELECT FirstName,LastName,Email,GradDate, Major FROM Student WHERE Username = @Username";
                    findPass.Parameters.Add(new SqlParameter("@Username", Session["Username"].ToString()));

                    SqlDataReader reader = findPass.ExecuteReader(); // create a reader

                    if (reader.HasRows) // if the username exists, it will continue
                    {
                        while (reader.Read()) // this will read the single record that matches the entered username
                        {
                            string first = reader["FirstName"].ToString();
                            string last = reader["LastName"].ToString();
                            string email = reader["Email"].ToString();
                            string grad = reader["GradDate"].ToString();
                            string major = reader["Major"].ToString();

                            txtFirstName.Text = first;
                            txtLastName.Text = last;
                            txtEmail.Text = email;
                            txtGradDate.Text = grad;
                            txtMajor.Text = major;
                        }
                    }

                    sc.Close();
                }
                if (Session["UserType"].ToString() == "Mentor")
                {
                    sc.Open();
                    System.Data.SqlClient.SqlCommand findPass = new System.Data.SqlClient.SqlCommand();
                    findPass.Connection = sc;
                    // SELECT PASSWORD STRING WHERE THE ENTERED USERNAME MATCHES
                    findPass.CommandText = "SELECT FirstName,LastName,Email,City,M_State FROM Mentor WHERE Username = @Username";
                    findPass.Parameters.Add(new SqlParameter("@Username", Session["Username"].ToString()));

                    SqlDataReader reader = findPass.ExecuteReader(); // create a reader

                    if (reader.HasRows) // if the username exists, it will continue
                    {
                        while (reader.Read()) // this will read the single record that matches the entered username
                        {
                            string first = reader["FirstName"].ToString();
                            string last = reader["LastName"].ToString();
                            string MentorEmail = reader["Email"].ToString();
                            string MentorCity = reader["City"].ToString();
                            string MentorState = reader["M_State"].ToString();

                            mtxtFirstName.Text = first;
                            mtxtLastName.Text = last;
                            txtMentorEmail.Text = MentorEmail;
                            txtCity.Text = MentorCity;
                            txtState.Text = MentorState;
                        }
                    }

                    sc.Close();
                }

            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Session["UserType"].ToString() == "Student")
            {
                String sqlQuery = "UPDATE [Student] SET [FirstName] = '" + txtFirstName.Text + "', [LastName] = '" + txtLastName.Text + "'," +
                "[Email] = '" + txtEmail.Text + "'," +
                "[Major] = '" + txtMajor.Text + "'," +
                "[GradDate] = '" + txtGradDate.Text + "' " +
                " WHERE[Username] = '" + Session["UserName"].ToString() + "'";
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnect;
                sqlCommand.CommandType = CommandType.Text;
                sqlCommand.CommandText = sqlQuery;

                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }
            if (Session["UserType"].ToString() == "Mentor")
            {
                String sqlQuery = "UPDATE [Mentor] SET [FirstName] = '" + mtxtFirstName.Text + "', [LastName] = '" + mtxtLastName.Text + "'," +
                "[Email] = '" + txtMentorEmail.Text + "'," +
                "[M_State] = '" + txtState.Text + "'," +
                "[StAddress] = '" + txtAddress.Text + "'," +
                "[City] = '" + txtCity.Text + "' " +
                " WHERE[Username] = '" + Session["UserName"].ToString() + "'";
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnect;
                sqlCommand.CommandType = CommandType.Text;
                sqlCommand.CommandText = sqlQuery;

                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }
        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            ltEmbed.Visible = true;
            if (!System.IO.Directory.Exists(Server.MapPath("~/Files")))
            {
                System.IO.Directory.CreateDirectory(Server.MapPath("~/Files"));
            }
            if (fileUploadText.HasFile)
            {
                String fpath = Request.PhysicalApplicationPath + "textfiles\\" +
                 Session["UserName"].ToString() + ".pdf";
                fileUploadText.SaveAs(fpath);
                if (File.Exists(fpath))
                {
                    string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"500px\" height=\"300px\">";
                    embed += "</object>";
                    ltEmbed.Text = string.Format(embed, ResolveUrl("~/textfiles/" + Session["UserName"].ToString() + ".pdf"));
                }
            }
        }
    }
}
