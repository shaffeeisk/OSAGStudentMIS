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

            // try to stop browser from caching images
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(.1));

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
                SqlCommand sqlCommand;

                if (Session["UserType"].ToString() == "student")
                {
                    // column for resume is probably not a good idea in this query. imagine thousands of page_loads
                    // with Reader being sent in with +100-200 kb due to byte array
                    sqlQuery = "SELECT StudentID, RegistrationYear, FirstName, LastName, Class, GradDate, Email, Gpa, Phone, Bio, IsApproved " +
                        "FROM Student WHERE Username = '" + Session["Username"].ToString() + "' " +
                        // separate into 2 result sets
                        "SELECT MajorName, IsMinor " +
                        "FROM Student s " +
                        "LEFT JOIN HasMajor h on h.StudentID = s.StudentID " +
                        "LEFT JOIN Major m on m.MajorID = h.MajorID " +
                        "WHERE Username = '" + Session["Username"].ToString() + "';";
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
                            imgViewPFP.ImageUrl = fpath;
                        else
                            imgViewPFP.ImageUrl = "\\_images\\user.png"; // default profile pic
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
                else if (Session["UserType"].ToString() == "member") // in case there is coder error
                {
                    sqlQuery = "SELECT MemberID, FirstName, LastName, Email, City, M_State, GradDate, PositionTitle, Phone, Bio, IsApproved " +
                        "FROM Member " +
                        "WHERE Username = '" + Session["Username"].ToString() + "' " +
                        "SELECT MajorName, IsMinor FROM Member m " +
                        "LEFT JOIN HasMajor h on h.MemberID = m.MemberID " +
                        "LEFT JOIN Major z on z.MajorID = h.MajorID " +
                        "WHERE Username =  '" + Session["Username"].ToString() + "';";
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
                            imgViewPFP.ImageUrl = fpath;
                        else
                            imgViewPFP.ImageUrl = "\\_images\\user.png"; // default profile pic
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
                // clear/format major(s)/minor(s) text
                lblViewDesc.Text = lblViewDesc.Text.TrimEnd('/') + " Major";
                lblViewMajor.Text = lblViewMajor.Text.Trim().TrimEnd(',');
                lblViewMinor.Text = lblViewMinor.Text.Trim().TrimEnd(',');
                if (lblViewMinor.Text == "")
                    lblViewMinor.Text = "-";
                if (lblViewMajor.Text == "")
                    lblViewMajor.Text = "-";
                if (Request.QueryString["viewstate"] == "edit")
                    btnEditMode_Click(btnEditMode, e);
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
                    "WHERE Username = '" + Session["Username"].ToString() + "';";
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
                    "WHERE Username = '" + Session["Username"].ToString() + "';";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlCommand.Parameters.AddWithValue("@FirstName", validate(txtFirstName.Text));
                sqlCommand.Parameters.AddWithValue("@LastName", validate(txtLastName.Text));
                sqlCommand.Parameters.AddWithValue("@Email", validate(txtEmail.Text));
                sqlCommand.Parameters.AddWithValue("@Phone", validate(txtPhone.Text));
                sqlCommand.Parameters.AddWithValue("@City", validate(txtCity.Text));
                sqlCommand.Parameters.AddWithValue("@M_State", validate(txtState.Text));
                sqlCommand.Parameters.AddWithValue("@PositionTitle", validate(txtPosition.Text));
                sqlCommand.Parameters.AddWithValue("@Bio", validate(txtBio.Text));
                sqlCommand.Parameters.AddWithValue("@GradDate", validate(txtGradDate.Text));
                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }
            Response.Write("<script>alert('Changes successfully saved.');</script>");
        }

        // event handler for resume upload button
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            // upload resume if a file was uploaded
            if (fileResume.HasFile)
            {
                // ensure file is not too large. http error if 4MB+, handled in Global.asax.
                // do not want to change web.config http timeout settings because DDoS = bad
                if (fileResume.PostedFile.ContentLength > 2097152)
                {
                    // file is too large (>2mb)
                    txtBio.Text = "file larger than 2mb"; // TEST CODE REPLACE WITH ACTUAL ERROR MESSAGE
                    return;
                }
                // make sure file is pdf
                string cType = fileResume.PostedFile.ContentType;
                if (cType != "application/pdf")
                {
                    // file is not pdf
                    txtBio.Text = "file is not pdf"; // TEST CODE REPLACE WITH ACTUAL ERROR MESSAGE
                    return;
                }

                // define filestream and create binary reader
                Stream fs = fileResume.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);

                // then insert file into Student table
                string sqlQuery = "UPDATE Student SET ResumeFile = @ResumeFile WHERE Username = @Username;";
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                SqlCommand sqlCommand = new SqlCommand(sqlQuery);
                sqlCommand.Connection = sqlConnect;
                sqlCommand.Parameters.AddWithValue("@Username", Session["Username"].ToString());
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
            byte[] resumeFile = getResumeBytes(Session["Username"].ToString());
            if (resumeFile == null)
            {
                btnDownloadResume.Text = "No Resume Uploaded!";
                btnDownloadResume.Enabled = false;
                return;
            }
            // can change file download name, simply change content of filename= below
            // cannot use original file name unless it is stored when uploading.
            Response.AddHeader("content-disposition", "attachment;filename=resume_" + Session["Username"].ToString() + "_saved.pdf");
            Response.ContentType = "application/octectstream";
            Response.BinaryWrite(resumeFile);
            Response.End();
        }


        // event handler for profile pic upload
        protected void btnPFP_Click(object sender, EventArgs e)
        {
            // upload resume if a file was uploaded
            if (filePFP.HasFile)
            {
                // ensure file is not too large. http error if 4MB+, handled in Global.asax.
                // do not want to change web.config http timeout settings because DDoS = bad
                if (filePFP.PostedFile.ContentLength > 2097152)
                {
                    // file is too large (>2mb)
                    lblPFP.Text = "file larger than 2mb"; // TEST CODE REPLACE WITH ACTUAL ERROR MESSAGE
                    return;
                }
                // make sure file is jpg
                string cType = filePFP.PostedFile.ContentType;
                if (cType != "image/jpeg")
                {
                    // file is not jpg
                    lblPFP.Text = "file must be jpeg"; // TEST CODE REPLACE WITH ACTUAL ERROR MESSAGE
                    return;
                }

                // try to get client browser to clear cache
                Response.Cache.SetExpires(DateTime.Now.AddSeconds(.05));

                // upload profile picture
                if (Session["UserType"].ToString() == "student")
                {
                    int[] arr = UsernameToIDAndRegYear(Session["Username"].ToString()); // arr[0] = studentID, arr[1] = regYear
                    string fpath = Request.PhysicalApplicationPath + "_images\\sPFP\\" + arr[1];
                    Directory.CreateDirectory(fpath);
                    fpath += "\\" + arr[0] + ".jpg";
                    if (File.Exists(fpath)) // delete existing file if exists
                    {
                        File.Delete(fpath);
                        imgViewPFP.ImageUrl = "\\_images\\sPFP\\" + arr[1] + "\\" + arr[0] + ".jpg"; // make client look for deleted image
                    }
                    filePFP.SaveAs(fpath); // save upload
                    Response.Cache.SetLastModified(DateTime.Now); // tell client cached image was modified
                    imgViewPFP.ImageUrl = "\\_images\\sPFP\\" + arr[1] + "\\" + arr[0] + ".jpg"; // make client look for new image
                }
                else // user is Member
                {
                    int id = UsernameToID(Session["Username"].ToString());
                    string fpath = Request.PhysicalApplicationPath + "_images\\mPFP\\" + id + ".jpg";
                    if (File.Exists(fpath))
                    {
                        File.Delete(fpath);
                        Response.Cache.SetLastModified(DateTime.Now); // tell client cached image was modified
                        imgViewPFP.ImageUrl = "\\_images\\mPFP\\" + id + ".jpg"; // make client look for deleted image
                    }
                    filePFP.SaveAs(fpath); // save upload
                    Response.Cache.SetLastModified(DateTime.Now); // tell client cached image was modified
                    imgViewPFP.ImageUrl = "\\_images\\mPFP\\" + id + ".jpg"; // set image again
                }

                // remove file upload controls and display success message
                filePFP.Visible = false;
                btnPFP.Visible = false;
                lblPFP.Text = "Profile picture successfully changed.";
            }
            else
            {
                // display error message or something here
                lblPFP.Text = "no image uploaded";
            }
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


        // helper method for file upload (STUDENT ONLY)
        protected int[] UsernameToIDAndRegYear(string studentUsername)
        {
            int[] arr = new int[2];
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("SELECT StudentID, RegistrationYear FROM Student WHERE Username = @Username;", sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", studentUsername);
            sqlConnect.Open();
            SqlDataReader reader = sqlCommand.ExecuteReader();
            reader.Read();
            arr[0] = (int)reader["StudentID"];
            arr[1] = (int)(short)reader["RegistrationYear"];
            return arr;
        }

        protected void btnEditMode_Click(object sender, EventArgs e)
        {
            // transfer data over to edit controls
            imgEditPFP.ImageUrl = imgViewPFP.ImageUrl;
            txtFirstName.Text = lblViewName.Text.Split(' ')[0];
            txtLastName.Text = lblViewName.Text.Split(' ')[1];
            txtEmail.Text = lblViewEmail.Text;
            txtPhone.Text = lblViewPhone.Text;
            if (DateTime.TryParse(lblViewGradDate.Text, out DateTime dt))
                txtGradDate.Text = dt.ToString("yyyy-MM-dd");
            lblEditMajor.Text = lblViewMajor.Text;
            lblEditMinor.Text = lblViewMinor.Text;
            txtBio.Text = lblViewBio.Text;

            if (Session["UserType"].ToString() == "student")
            {
                txtClass.Text = lblViewClass.Text;
                txtGpa.Text = lblViewGpa.Text;
            }
            else
            {
                txtCity.Text = lblViewCity.Text;
                txtState.Text = lblViewState.Text;
            }
            // then flip visibility of view/edit
            divModeView.Visible = false;
            divModeEdit.Visible = true;
            btnUpdate.Visible = true;
            btnReturn.Visible = true;
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            // flip visibility of view/edit
            divModeView.Visible = true;
            divModeEdit.Visible = false;
            btnUpdate.Visible = false;
            btnReturn.Visible = false;
        }

        protected void btnDeclareMajor_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeclareMajor.aspx");
        }
    }
}
