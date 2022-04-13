using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
//Connection Strings in web.config
using System.Web.Configuration;
using System.Drawing;
using System.IO;

namespace OSAG.profiles
{
    public partial class UnapprovedUserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TempUsername"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }

            // only when loading page for the first time
            if (!IsPostBack)
            {
                // Global.asax -> Application_Error Message Handler. Expected error is "File size too large."
                //      Max file size (default) is 4MB but user is told 2MB.
                // is in !IsPostBack because error causes Response.Redirect back to page.
                if (Request.QueryString["Message"] != null) // Request.QueryString["key"] is the .../page.aspx?Message=message%and%etc
                {
                    // CODE FOR TESTING ONLY. PLEASE CHANGE. PLEASE FOR THE LOVE OF GOD.
                    // SERIOUSLY, DO NOT OVERLOOK THIS.
                    btnUpload.Text = Request.QueryString["Message"]; // text of querystring
                    // fun fact: do NOT try to clear the querystring. just response.redirect :sob emoji:
                }

                // define connection to DB and query String
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
                String sqlQuery;

                if (Session["UserType"].ToString() == "student")
                {
                    // column for resume is probably not a good idea in this query. imagine thousands of page_loads
                    // with Reader being sent in with +100-200 kb due to byte array
                    sqlQuery = "SELECT FirstName, LastName, Email, GradDate, Class, Gpa, Phone, Bio, IsApproved " +
                        "FROM Student WHERE Username = '" + Session["TempUsername"].ToString() + "' " +
                        // separate into 2 result sets
                        "SELECT MajorName, IsMinor " +
                        "FROM Student s " +
                        "LEFT JOIN HasMajor h on h.StudentID = s.StudentID " +
                        "LEFT JOIN Major m on m.MajorID = h.MajorID " +
                        "WHERE Username = '" + Session["TempUsername"].ToString() + "';";
                    SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                    sqlConnect.Open();

                    // read data onto page
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read()) // this will read the first record table (student info)
                    {
                        txtFirstName.Text = reader["FirstName"].ToString();
                        txtLastName.Text = reader["LastName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        if (reader["GradDate"] == DBNull.Value)
                            txtGradDate.Text = "";
                        else
                            txtGradDate.Text = DateTime.Parse(reader["GradDate"].ToString()).ToString("yyyy-MM-dd");
                        txtClass.Text = reader["Class"].ToString();
                        txtGpa.Text = reader["Gpa"].ToString();
                        txtPhone.Text = reader["Phone"].ToString();
                        txtBio.Text = reader["Bio"].ToString();

                        if (bitToBoolean(reader["IsApproved"]))
                            lblApprove.Text = "User Profile Approved";
                        else
                            lblApprove.Text = "User Profile Not Yet Approved";
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

                    // maybe instead put button to display or download uploaded resume
                    // or potentially use above reader to download temp resume file.
                    // issue with byte array stored file is turning it into a file without saving it.
                    // see below 
                    /****************************************
                     *                populate              *
                     *                 resume               *
                     *                 embed                *
                     *                  here                *
                     ****************************************/

                }
                else if (Session["UserType"].ToString() == "member") // in case there is coder error
                {
                    sqlQuery = "SELECT FirstName, LastName, Email, City, M_State, GradDate, PositionTitle, Phone, Bio, IsApproved " +
                        "FROM Member " +
                        "WHERE Username = '" + Session["TempUsername"].ToString() + "' " +
                        "SELECT MajorName, IsMinor FROM Member m " +
                        "LEFT JOIN HasMajor h on h.MemberID = m.MemberID " +
                        "LEFT JOIN Major z on z.MajorID = h.MajorID" +
                        " WHERE Username =  '" + Session["TempUsername"].ToString() + "';";
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
                        txtMemberGrad.Text = reader["GradDate"].ToString();
                        txtPosition.Text = reader["PositionTitle"].ToString();
                        txtMemberPhone.Text = reader["Phone"].ToString();
                        txtMemberBio.Text = reader["Bio"].ToString();
                        if (bitToBoolean(reader["IsApproved"]))
                            lblApprove.Text = "User Profile Approved";
                        else
                            lblApprove.Text = "User Profile Not Yet Approved";
                    }
                    reader.NextResult(); // go to bext result table (majors/IsMinor)
                    while (reader.Read()) // this will read records of majors and input into the singular textboxes
                    {
                        if (bitToBoolean(reader["IsMinor"])) // read all majors/minors
                            txtMemberMinor.Text += reader["MajorName"].ToString() + ", ";
                        else
                            txtMemberMajor.Text += reader["MajorName"].ToString() + ", ";
                    }
                    txtMemberMajor.Text = txtMemberMajor.Text.Trim().TrimEnd(',');
                    txtMemberMinor.Text = txtMemberMinor.Text.Trim().TrimEnd(',');
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
                sqlQuery = "UPDATE Student SET " +
                    "FirstName = @FirstName, " +
                    "LastName = @LastName, " +
                    "Email = @Email, " +
                    "Phone = @Phone, " +
                    "Class = @Class, " +
                    "Gpa = @Gpa, " +
                    "Bio = @Bio, " +
                    "GradDate = @GradDate " +
                    "WHERE Username = '" + Session["TempUsername"].ToString() + "';";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlCommand.Parameters.AddWithValue("@FirstName", validate(txtFirstName.Text));
                sqlCommand.Parameters.AddWithValue("@LastName", validate(txtLastName.Text));
                sqlCommand.Parameters.AddWithValue("@Email", validate(txtEmail.Text));
                sqlCommand.Parameters.AddWithValue("@Phone", validate(txtPhone.Text));
                sqlCommand.Parameters.AddWithValue("@Class", validate(txtClass.Text));
                sqlCommand.Parameters.AddWithValue("@Gpa", validateGpa(txtGpa.Text));
                sqlCommand.Parameters.AddWithValue("@Bio", validate(txtBio.Text));
                sqlCommand.Parameters.AddWithValue("@GradDate", validate(txtGradDate.Text));
                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }
            else if (Session["UserType"].ToString() == "member")
            {
                sqlQuery = "UPDATE Member SET " +
                    "FirstName = @FirstName, " +
                    "LastName = @LastName, " +
                    "Email = @Email, " +
                    "Phone = @Phone, " +
                    "City = @City, " +
                    "M_State = @M_State, " +
                    "PositionTitle = @PositionTitle, " +
                    "Bio = @Bio, " +
                    "GradDate = @GradDate " +
                    "WHERE Username = '" + Session["TempUsername"].ToString() + "';";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlCommand.Parameters.AddWithValue("@FirstName", validate(mtxtFirstName.Text));
                sqlCommand.Parameters.AddWithValue("@LastName", validate(mtxtLastName.Text));
                sqlCommand.Parameters.AddWithValue("@Email", validate(txtMemberEmail.Text));
                sqlCommand.Parameters.AddWithValue("@Phone", validate(txtPhone.Text));
                sqlCommand.Parameters.AddWithValue("@City", validate(txtCity.Text));
                sqlCommand.Parameters.AddWithValue("@M_State", validate(txtState.Text));
                sqlCommand.Parameters.AddWithValue("@PositionTitle", validate(txtPosition.Text));
                sqlCommand.Parameters.AddWithValue("@Bio", validate(txtMemberBio.Text));
                sqlCommand.Parameters.AddWithValue("@GradDate", validate(txtMemberGrad.Text));

                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }
        }

        // event handler for resume upload button
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            // upload resume if a file was uploaded
            if (fileUpload.HasFile)
            {
                // ensure file is not too large. http error if 4MB+, handled in Global.asax.
                // do not want to change web.config http timeout settings because DDoS = bad
                if (fileUpload.PostedFile.ContentLength > 2097152)
                {
                    // file is too large (>2mb)
                    txtBio.Text = "file larger than 2mb"; // TEST CODE REPLACE WITH ACTUAL ERROR MESSAGE
                    return;
                }
                // make sure file is pdf
                string cType = fileUpload.PostedFile.ContentType;
                if (cType != "application/pdf")
                {
                    // file is not pdf
                    txtBio.Text = "file is not pdf"; // TEST CODE REPLACE WITH ACTUAL ERROR MESSAGE
                    return;
                }

                // define filestream and create binary reader
                Stream fs = fileUpload.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);

                // then insert file into Student table
                string sqlQuery = "UPDATE Student SET ResumeFile = @ResumeFile WHERE Username = @Username;";
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                SqlCommand sqlCommand = new SqlCommand(sqlQuery);
                sqlCommand.Connection = sqlConnect;
                sqlCommand.Parameters.AddWithValue("@Username", Session["TempUsername"].ToString());
                sqlCommand.Parameters.AddWithValue("@ResumeFile", br.ReadBytes((Int32)fs.Length)); // BinaryReader converts file to byte[]

                sqlConnect.Open();
                sqlCommand.ExecuteNonQuery();
                sqlConnect.Close();
            }
            else
            {
                // display error message or something here
            }

        }

        // writes file directly to client (no hard memory save of resume on server).
        // some browsers will prompt client, chrome will immediately begin download.
        protected void btnDownloadResume_Click(object sender, EventArgs e)
        {
            byte[] resumeFile = getResumeBytes(Session["TempUsername"].ToString());
            if (resumeFile == null)
            {
                // ERROR MESSAGE HANDLING PLEASE (NO RESUME UPLOADED)
                btnDownloadResume.Text = "no resume uploaded"; // TEST CODE REPLACE WITH ACTUAL ERROR MESSAGE
                return;
            }
            // can change file download name, simply change content of filename= below
            // cannot use original file name unless it is stored when uploading.
            Response.AddHeader("content-disposition", "attachment;filename=resume_" + Session["TempUsername"].ToString() + "_saved.pdf");
            Response.ContentType = "application/octectstream";
            Response.BinaryWrite(resumeFile);
            Response.End();
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

        // helper method to validate data. trims input string of leading/trailing white space.
        // then returns null if user input is empty. otherwise, returns the trimmed string.
        // allows data integrity to allow querying null input (also saves disk space :D)
        // (e.g. display students who don't have graduation dates so member can help them figure out when they should graduate)
        private object validate(String s)
        {
            s = s.Trim();
            if (s == "")
                return (object)DBNull.Value;
            return s;
        }

        // helper method for GPA input, since DB is configured with 4 byte floats. C# uses 4 byte float, so float.parse is (probably) optimal. 
        // if user does not enter float-parseable data FormatException will be thrown, returning a null value similar to above.
        private object validateGpa(string s)
        {
            try
            {
                return float.Parse(s);
            }
            catch (FormatException ex)
            {
                return (object)DBNull.Value;
                throw ex;
            }
        }

        // SQL Server BIT -> Boolean. read above comments for more details
        private bool bitToBoolean(object o)
        {
            if (o == DBNull.Value)
                return false;
            return (bool)o;
        }
    }
}