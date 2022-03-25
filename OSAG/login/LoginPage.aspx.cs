using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Drawing;

namespace OSAG.login
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MustLogin"] == null)
            {
                lblStatus.Text = "Please login to continue!";
            }
            else
            {
                lblStatus.Text = Session[HttpUtility.HtmlEncode("MustLogin")].ToString();
            }
        }
            protected void lnkCreate_Click(object sender, EventArgs e)
            {
                Response.Redirect("RegistrationPage.aspx", false);
            }


            protected void btnLogin_Click(object sender, EventArgs e)
            {
                // connect to database to retrieve stored password string
                try
                {
                    System.Data.SqlClient.SqlConnection sc = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
                    lblStatus.Text = "Database Connection Successful";

                    SqlCommand loginCommand = new SqlCommand();
                    loginCommand.Connection = sc;
                    loginCommand.CommandType = CommandType.StoredProcedure;
                    loginCommand.CommandText = "OSAG_NotApproved";
                    loginCommand.Parameters.AddWithValue("@Username", txtUsername.Text.ToString());

                    sc.Open();
                    System.Data.SqlClient.SqlCommand findPass = new System.Data.SqlClient.SqlCommand();
                    findPass.Connection = sc;
                    // SELECT PASSWORD STRING WHERE THE ENTERED USERNAME MATCHES
                    findPass.CommandText = "SELECT PasswordHash FROM Pass WHERE Username = @Username";
                    findPass.Parameters.Add(new SqlParameter("@Username", txtUsername.Text));

                    SqlDataReader reader = findPass.ExecuteReader(); // create a reader

                    if (reader.HasRows) // if the username exists, it will continue
                    {
                    while (reader.Read()) // this will read the single record that matches the entered username
                    {
                        string storedHash = reader["PasswordHash"].ToString(); // store the database password into this variable

                        if (PasswordHash.ValidatePassword(txtPassword.Text, storedHash)) // if the entered password matches what is stored, it will show success
                        {
                            lblStatus.Text = "Success!";
                            btnLogin.Enabled = false;
                            txtUsername.Enabled = false;
                            txtPassword.Enabled = false;
                            Session["Username"] = txtUsername.Text;
                            //Retrieve StudentID of user
                            //Query
                            String sqlQuery = "Select UserType FROM Person Where UserName = '" + Session["Username"] + "'";

                            // Define the Connection
                            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);

                            //Create and Format the Command
                            SqlCommand sqlCommand = new SqlCommand();
                            sqlCommand.Connection = sqlConnection;
                            sqlCommand.CommandType = CommandType.Text;
                            sqlCommand.CommandText = sqlQuery;

                            // Execute the Query and get results
                            sqlConnection.Open();
                            SqlDataReader queryResults = sqlCommand.ExecuteReader();
                            while (queryResults.Read())
                            {
                                Session["UserType"] = queryResults["UserType"];
                            }
                            if (Session["UserType"].ToString() == "Student")
                            {
                                Response.Redirect("/profiles/StudentProfile.aspx");
                            }
                            else
                            {
                                Response.Redirect("/profiles/MentorProfile.aspx");
                            }
                            lblStatus.ForeColor = Color.Red;
                            lblStatus.Font.Bold = true;
                            lblStatus.Text = "Username and/or Password was Incorrect. Please try again.";
                        }
                    }
                    }
                    else // if the username doesn't exist, it will show failure
                        lblStatus.Text = "Login failed.";

                    if (!isApproved(txtUsername.Text))
                    {
                        Session["MustLogin"] = "Your account is pending approval. Please try again at a later time.";
                        Response.Redirect("logIn.aspx");
                        return;
                    }


                    sc.Close();
                }
                catch
                {
                    lblStatus.Text = "User does not exist. Please create an account.";
                }
            }
            protected bool isApproved(String s)
            {
                String sqlQuery = "EXEC dbo.AUTH_NotApproved @Username";
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlCommand.Parameters.AddWithValue("@Username", txtUsername.Text);
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