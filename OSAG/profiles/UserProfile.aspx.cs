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
                    sqlQuery = "SELECT FirstName, LastName, Email, GradDate, Major, Class, Gpa, Phone, Bio, IsApproved FROM Student WHERE Username = '" + Session["Username"].ToString() + "';";
                    SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();

                    String approval = "";
                    // read data onto page
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read()) // this will read the single record that matches the entered username
                    {
                        txtFirstName.Text = reader["FirstName"].ToString();
                        txtLastName.Text = reader["LastName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        if (reader["GradDate"] == DBNull.Value)
                            txtGradDate.Text = "";
                        else
                            txtGradDate.Text = DateTime.Parse(reader["GradDate"].ToString()).ToString("yyy-MM-dd");
                        txtMajor.Text = reader["Major"].ToString();
                        txtClass.Text = reader["Class"].ToString();
                        txtGpa.Text = reader["Gpa"].ToString();
                        txtPhone.Text = reader["Phone"].ToString();
                        txtBio.Text = reader["Bio"].ToString();
                        approval = reader["IsApproved"].ToString();
                        if(isApproved())
                        {
                            lblApprove.Text = "User Profile Approved";
                        }
                        else 
                        {
                            lblApprove.Text = "User Profile Not Yet Approved";
                        }
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
                else if (Session["UserType"].ToString() == "member") // in case there is coder error
                {
                    sqlQuery = "SELECT FirstName,LastName,Email,City,M_State,GradDate,Major,PositionTitle,Phone,Bio,IsApproved FROM Member WHERE Username =  '" + Session["Username"].ToString() + "'; ";
                    SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();
                    String approval = "";
                    // read data onto page
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        mtxtFirstName.Text = reader["FirstName"].ToString();
                        mtxtLastName.Text = reader["LastName"].ToString();
                        txtMemberEmail.Text = reader["Email"].ToString();
                        txtCity.Text = reader["City"].ToString();
                        txtState.Text = reader["M_State"].ToString();
                        txtMemberGrad.Text = reader["GradDate"].ToString();
                        txtMemberMajor.Text = reader["Major"].ToString();
                        txtPosition.Text = reader["PositionTitle"].ToString();
                        txtMemberPhone.Text = reader["Phone"].ToString();
                        txtMemberBio.Text = reader["Bio"].ToString();
                        approval = reader["IsApproved"].ToString();
                        if (isApproved())
                        {
                            lblApprove.Text = "User Profile Approved";
                        }
                        else
                        {
                            lblApprove.Text = "User Profile Not Yet Approved";
                        }
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
                "[Phone] = '" + txtPhone.Text + "'," +
                "[Class] = '" + txtClass.Text + "'," +
                "[Gpa] = '" + txtGpa.Text + "'," +
                "[Bio] = '" + txtBio.Text + "'," +
                "[GradDate] = '" + txtGradDate.Text + "' " +
                " WHERE[Username] = '" + Session["Username"].ToString() + "'";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }
            else if (Session["UserType"].ToString() == "member")
            {
                sqlQuery = "UPDATE [Member] SET [FirstName] = '" + mtxtFirstName.Text + "', [LastName] = '" + mtxtLastName.Text + "'," +
                "[Email] = '" + txtMemberEmail.Text + "'," +
                "[M_State] = '" + txtState.Text + "'," +
                "[PositionTitle] = '" + txtPosition.Text + "'," +
                "[Phone] = '" + txtMemberPhone.Text + "'," +
                "[Bio] = '" + txtMemberBio.Text + "'," +
                "[GradDate] = '" + txtMemberGrad.Text + "'," +
                "[Major] = '" + txtMemberMajor.Text + "'," +
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
        protected bool isApproved()
        {
            String sqlQuery = "EXEC dbo.OSAG_NotApproved @Username";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", Session["Username"].ToString());
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
