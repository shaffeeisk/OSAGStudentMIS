/* code behind for view profile*/
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
                    sqlQuery = "SELECT FirstName, LastName, Email, GradDate, Phone, Class, Gpa, Bio FROM Student " +
                        "WHERE Username = '" + Session["ViewProfileUsername"].ToString() + "' " +
                        "SELECT MajorName, IsMinor FROM Student s " +
                        "LEFT JOIN HasMajor h ON s.StudentID = h.StudentID " +
                        "LEFT JOIN Major m ON h.MajorID = m.MajorID " +
                        "WHERE Username = '" + Session["ViewProfileUsername"].ToString() + "';";
                    SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read()) // this will read the first record table (student info)
                    {
                        // populate student attributes
                        txtFirstName.Text = reader["FirstName"].ToString();
                        txtLastName.Text = reader["LastName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        if (reader["GradDate"] != DBNull.Value)
                            txtGradDate.Text = DateTime.Parse(reader["GradDate"].ToString()).ToString("yyyy-MM-dd");
                        txtPhone.Text = reader["Phone"].ToString();
                        txtClass.Text = reader["Class"].ToString();
                        txtGPA.Text = reader["Gpa"].ToString();
                        txtBio.Text = reader["Bio"].ToString();
                    }
                    reader.NextResult(); // go to bext result table (majors/IsMinor)
                    while (reader.Read()) // this will read records of majors and input into the singular textboxes
                    {
                        if (bitToBoolean(reader["IsMinor"]))
                            txtMinor.Text += reader["MajorName"].ToString() + ", ";
                        else
                            txtMajor.Text += reader["MajorName"].ToString() + ", ";
                    }
                    txtMajor.Text = txtMajor.Text.Trim().TrimEnd(',');
                    txtMinor.Text = txtMinor.Text.Trim().TrimEnd(',');
                    sqlConnect.Close();
                }

                // otherwise querying member
                else if (Session["ViewProfileUserType"].ToString() == "member") // in case there is coder error
                {
                    sqlQuery = "SELECT FirstName, LastName, Email, City, M_State, Phone, GradDate, PositionTitle, Bio FROM Member" +
                        " WHERE Username = '" + Session["ViewProfileUsername"].ToString() + "' " +
                        "SELECT FirstName,LastName,Email,City,M_State, m.MajorName, IsMinor FROM Member s LEFT JOIN HasMajor h ON s.MemberID = h.MemberID " +
                        "LEFT JOIN Major m ON h.MajorID = m.MajorID" +
                        " WHERE Username = '" + Session["ViewProfileUsername"].ToString() + "';";
                    SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();

                    // read data onto page
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read()) // this will read the first record table (member info)
                    {
                        mtxtFirstName.Text = reader["FirstName"].ToString();
                        mtxtLastName.Text = reader["LastName"].ToString();
                        txtMemberEmail.Text = reader["Email"].ToString();
                        txtCity.Text = reader["City"].ToString();
                        txtState.Text = reader["M_State"].ToString();
                        txtMemberPhone.Text = reader["Phone"].ToString();
                        if (reader["GradDate"] != DBNull.Value)
                            txtMemberGradDate.Text = DateTime.Parse(reader["GradDate"].ToString()).ToString("yyyy-MM-dd");
                        txtPositionTitle.Text = reader["PositionTitle"].ToString();
                        txtMemberBio.Text = reader["Bio"].ToString();
                    }
                    reader.NextResult(); // go to bext result table (majors/IsMinor)
                    while (reader.Read()) // this will read records of majors and input into the singular textboxes
                    {
                        if (bitToBoolean(reader["IsMinor"]))
                            txtMemberMinors.Text += reader["MajorName"].ToString() + ", ";
                        else
                            txtMemberMajors.Text += reader["MajorName"].ToString() + ", ";
                    }
                    txtMemberMajors.Text = txtMemberMajors.Text.Trim().TrimEnd(',');
                    txtMemberMinors.Text = txtMemberMinors.Text.Trim().TrimEnd(',');
                    sqlConnect.Close();
                    btnDownloadResume.Visible = false;
                }
            }
        }

        // writes file directly to client (no hard memory save of resume on server).
        // some browsers will prompt client, chrome will immediately begin download.
        protected void btnDownloadResume_Click(object sender, EventArgs e)
        {
            byte[] resumeFile = getResumeBytes(Session["ViewProfileUsername"].ToString());
            if (resumeFile == null)
            {
                // ERROR MESSAGE HANDLING PLEASE (NO RESUME UPLOADED)
                btnDownloadResume.Text = "no resume uploaded"; // TEST CODE REPLACE WITH ACTUAL ERROR MESSAGE
                return;
            }
            // can change file download name, simply change content of filename= below
            // cannot use original file name unless it is stored when uploading.
            Response.AddHeader("content-disposition", "attachment;filename=resume_" + Session["ViewProfileUsername"].ToString() + "_saved.pdf");
            Response.ContentType = "application/octectstream";
            Response.BinaryWrite(resumeFile);
            Response.End();
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListUsers.aspx");
        }

        // helper method that queries for resume file and returns byte array
        protected byte[] getResumeBytes(string s)
        {
            byte[] fileBytes;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("SELECT ResumeFile FROM Student WHERE Username = @Username;", sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", s);
            sqlConnect.Open();
            SqlDataReader reader = sqlCommand.ExecuteReader();
            reader.Read();
            if (reader["ResumeFile"] == DBNull.Value)
                return null;
            fileBytes = new byte[(reader.GetBytes(0, 0, null, 0, int.MaxValue))];
            reader.GetBytes(0, 0, fileBytes, 0, fileBytes.Length);
            sqlConnect.Close();
            return fileBytes;
        }

        private bool bitToBoolean(object o)
        {
            if (o == DBNull.Value)
                return false;
            return (bool)o;
        }
    }
}