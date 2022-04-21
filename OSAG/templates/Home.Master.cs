/*code behind for master home page*/
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG
{
    public partial class Home : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }
            else
                lblUsername.Text = Session["Username"].ToString();

            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("SELECT COUNT(*) FROM ChatNotification WHERE " +
                Session["UserType"].ToString() + "ReceiverID = '" +
                UsernameToID(Session["Username"].ToString()) + "';", sqlConnect);
            sqlConnect.Open();
            lblNewChats.Text = sqlCommand.ExecuteScalar().ToString() + " New Chats";
            if (lblNewChats.Text == "1 New Chats")
                lblNewChats.Text = "1 New Chat";
        }

        protected void lnkbtnSignOut_Click(object sender, EventArgs e)
        {
            /********************************************
            *  Any user data that you need to work with *
            *  do here before you abandon session       *
            *********************************************/
            Session.Abandon();
            Response.Redirect("/homepages/HomePage.aspx");
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