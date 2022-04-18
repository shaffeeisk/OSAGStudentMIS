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
                SqlCommand sqlCommand;

                if (Session["ViewProfileUserType"].ToString() == "student")
                {
                    // column for resume is probably not a good idea in this query. imagine thousands of page_loads
                    // with Reader being sent in with +100-200 kb due to byte array
                    sqlQuery = "SELECT StudentID, RegistrationYear, FirstName, LastName, Class, GradDate, Email, Gpa, Phone, Bio, IsApproved " +
                        "FROM Student WHERE Username = '" + Session["ViewProfileUsername"].ToString() + "' " +
                        // separate into 2 result sets
                        "SELECT MajorName, IsMinor " +
                        "FROM Student s " +
                        "LEFT JOIN HasMajor h on h.StudentID = s.StudentID " +
                        "LEFT JOIN Major m on m.MajorID = h.MajorID " +
                        "WHERE Username = '" + Session["ViewProfileUsername"].ToString() + "';";
                    sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();

                    // read data onto page
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read()) // this will read the first record table (student info)
                    {
                        lblViewName.Text = reader["FirstName"].ToString();
                        lblViewName.Text += " " + reader["LastName"].ToString();
                        lblViewClass.Text = reader["Class"].ToString();
                        if (reader["GradDate"] == DBNull.Value)
                            lblViewGradDate.Text = "Unknown";
                        else
                            lblViewGradDate.Text = DateTime.Parse(reader["GradDate"].ToString()).ToString("MMMM yyyy");
                        lblViewEmail.Text = reader["Email"].ToString();
                        lblViewGpa.Text = reader["Gpa"].ToString();
                        lblViewPhone.Text = reader["Phone"].ToString();
                        lblViewBio.Text = reader["Bio"].ToString();
                        lblViewDesc.Text = reader["Class"].ToString() + " ";

                        if (bitToBoolean(reader["IsApproved"]))
                            isApproved.Visible = true;
                        else
                            isApproved.Visible = false;

                        // load pfp onto page
                        String fpath = "\\_images\\sPFP\\" + reader["RegistrationYear"].ToString() + "\\" + reader["StudentID"].ToString() + ".jpg";
                        if (File.Exists(Request.PhysicalApplicationPath + fpath))
                            imgProfile.ImageUrl = fpath;
                        else
                            imgProfile.ImageUrl = "\\_images\\user.png"; // default profile pic
                    }
                    reader.NextResult(); // go to bext result table (majors/IsMinor)
                    while (reader.Read()) // this will read records of majors and input into the singular textboxes
                    {
                        if (bitToBoolean(reader["IsMinor"]))
                            lblViewMinor.Text += reader["MajorName"].ToString() + ", ";
                        else
                        {
                            lblViewMajor.Text += reader["MajorName"].ToString() + ", ";
                            lblViewDesc.Text += reader["MajorName"].ToString() + "/";
                        }
                    }
                    sqlConnect.Close();
                }
                else if (Session["ViewProfileUserType"].ToString() == "member") // in case there is coder error
                {
                    sqlQuery = "SELECT MemberID, MemberType, FirstName, LastName, Email, City, M_State, GradDate, PositionTitle, Phone, Bio, IsApproved " +
                        "FROM Member " +
                        "WHERE Username = '" + Session["ViewProfileUsername"].ToString() + "' " +
                        "SELECT MajorName, IsMinor FROM Member m " +
                        "LEFT JOIN HasMajor h on h.MemberID = m.MemberID " +
                        "LEFT JOIN Major z on z.MajorID = h.MajorID " +
                        "WHERE Username =  '" + Session["ViewProfileUsername"].ToString() + "';";
                    sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();

                    // read data onto page
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read()) // this will read the first record table (member info)
                    {
                        lblViewName.Text = reader["FirstName"].ToString();
                        lblViewName.Text += " " + reader["LastName"].ToString();
                        lblViewEmail.Text = reader["Email"].ToString();
                        lblViewCity.Text = reader["City"].ToString();
                        lblViewState.Text = reader["M_State"].ToString();
                        if (reader["GradDate"] == DBNull.Value)
                            lblViewGradDate.Text = "Unknown";
                        else
                            lblViewGradDate.Text = DateTime.Parse(reader["GradDate"].ToString()).ToString("yyyy");
                        lblViewDesc.Text = reader["PositionTitle"].ToString();
                        lblViewPhone.Text = reader["Phone"].ToString();
                        lblViewBio.Text = reader["Bio"].ToString();
                        if (bitToBoolean(reader["IsApproved"]))
                            isApproved.Visible = true;
                        else
                            isApproved.Visible = false;

                        // load pfp onto page
                        String fpath = "\\_images\\mPFP\\" + reader["MemberID"].ToString() + ".jpg";
                        if (File.Exists(Request.PhysicalApplicationPath + fpath))
                            imgProfile.ImageUrl = fpath;
                        else
                            imgProfile.ImageUrl = "\\_images\\user.png"; // default profile pic

                        // if User is student and member is Mentor+, display "request mentor" button
                        if (Session["UserType"].ToString() == "student")
                        {
                            if ((byte)reader["MemberType"] < 4) // byte used b/c TINYINT in SQL
                                btnRequest.Visible = true; // enable request as mentor
                        }
                    }
                    reader.NextResult(); // go to bext result table (majors/IsMinor)
                    while (reader.Read()) // this will read records of majors and input into the singular textboxes
                    {
                        if (bitToBoolean(reader["IsMinor"])) // read all majors/minors
                            lblViewMinor.Text += reader["MajorName"].ToString() + ", ";
                        else
                            lblViewMajor.Text += reader["MajorName"].ToString() + ", ";
                    }
                    sqlConnect.Close();
                }
                // clear/format text
                if (Session["ViewProfileUserType"].ToString() == "student")
                    lblViewDesc.Text = lblViewDesc.Text.TrimEnd('/') + " Major";
                lblViewMajor.Text = lblViewMajor.Text.Trim().TrimEnd(',');
                lblViewMinor.Text = lblViewMinor.Text.Trim().TrimEnd(',');
                if (lblViewMinor.Text == "")
                    lblViewMinor.Text = "-";
                if (lblViewMajor.Text == "")
                    lblViewMajor.Text = "-";
                if (lblViewBio.Text == "")
                    lblViewBio.Text = "User has not yet submitted their biography.";

                // handle viewstate
                if (Session["UserType"].ToString() == "student")
                {
                    if (Session["ViewProfileUserType"].ToString() == "student")
                    {
                        lblViewEmail.Text = "-Private-";
                        lblViewPhone.Text = "-Private-";
                        lblViewGpa.Text = "-Private-";
                    }
                    else
                        lblViewPhone.Text = "-Private-";
                }
                else // (Session["UserType"].ToString() == "member")
                {
                    switch (Int32.Parse(Session["MemberType"].ToString())) // provite different access levels
                    {
                        case 4: // member
                            if (Session["ViewProfileUserType"].ToString() == "student")
                                lblViewGpa.Text = "-Private-";
                            lblViewEmail.Text = "-Private-";
                            lblViewPhone.Text = "-Private-";
                            break;
                        case 3: // mentor
                            lblViewPhone.Text = "-Private-";
                            break;
                        case 2: // leadership
                            lblViewPhone.Text = "-Private-";
                            break;
                        default: // case: 1 (admin)
                            break;
                    }
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
                btnDownloadResume.Text = "NO RESUME UPLOADED";
                btnDownloadResume.Enabled = false;
                btnDownloadResume.CssClass = "btn btn-alert mb-3";
                return;
            }
            // can change file download name, simply change content of filename= below
            // cannot use original file name unless it is stored when uploading.
            Response.AddHeader("content-disposition", "attachment;filename=resume_" + Session["ViewProfileUsername"].ToString() + "_saved.pdf");
            Response.ContentType = "application/octectstream";
            Response.BinaryWrite(resumeFile);
            Response.End();
        }

        protected void btnRequest_Click(object sender, EventArgs e)
        {
            string sqlQuery = "IF NOT EXISTS(SELECT * FROM Mentorship WHERE StudentID = @StudentID AND MemberID = @MemberID) " +
                "BEGIN " +
                "INSERT INTO Mentorship (StudentID, MemberID, IsRequest) VALUES (@StudentID, @MemberID, 1) " +
                "END " +
                "ELSE " +
                "BEGIN " +
                "UPDATE Mentorship SET IsRequest = 1 WHERE StudentID = @StudentID AND MemberID = @MemberID " +
                "AND EndDate IS NOT NULL AND IsRequest IS NULL" + // IsRequest IS NULL prevents re-requesting after request denied
                "END";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@StudentID", UsernameToID(Session["Username"].ToString()));
            sqlCommand.Parameters.AddWithValue("@MemberID", UsernameToID(Session["ViewProfileUsername"].ToString()));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            lblRequestStatus.Text = "Request submitted.";
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

        // helper method to execute stored procedure (username [GUID within program] -> StudentID/MemberID)
        protected int UsernameToID(string username)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("dbo.OSAG_UsernameToID", sqlConnect);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@Username", username);
            sqlConnect.Open();
            return (int)sqlCommand.ExecuteScalar();
        }
    }
}