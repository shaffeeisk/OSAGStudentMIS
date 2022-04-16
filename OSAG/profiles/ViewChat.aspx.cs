/* code behind for view chat*/
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
using System.Data;

namespace OSAG.profiles
{
    public partial class ViewChat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // handle invalid access
            if (Session["Username"] == null)
                return;
            else if(Session["UserChatType"] == null || Session["UserChatID"] == null)
            {
                Session["AccessDenied"] = "Access Denied: An unknown error occurred.";
                Response.Redirect("UserProfile.aspx");
            }

            // otherwise set select command
            int userID = UsernameToID(Session["Username"].ToString());
            sqlsrc.SelectCommand = "Select DateCreated, MessageText, SenderName, IsRead FROM ChatMessage WHERE (" +
                Session["UserType"].ToString() + "SenderID = '" + userID + "' AND " +
                 Session["UserChatType"].ToString() + "ReceiverID = " + Session["UserChatID"] + ") OR (" +
                 Session["UserType"].ToString() + "ReceiverID = '" + userID + "' AND " +
                 Session["UserChatType"].ToString() + "SenderID = '" + Session["UserChatID"] + "')";
            // and set page messages to read
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            sqlQuery = "UPDATE ChatMessage SET IsRead = 1 WHERE " +
                Session["UserType"].ToString() + "ReceiverID = '" + userID + "' AND " +
                 Session["UserChatType"].ToString() + "SenderID = '" + Session["UserChatID"] + "'";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
        }

        protected void btn_Send_Click(object sender, EventArgs e)
        {
            if (txtChatBox.Text == "")
                return;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            sqlQuery = "INSERT INTO ChatMessage (MessageText, " + Session["UserType"].ToString() + "SenderID, " + Session["UserChatType"].ToString() + "ReceiverID, SenderName, IsRead) " +
                "VALUES (@MessageText, '" + UsernameToID(Session["Username"].ToString()) + "', '" + Session["UserChatID"].ToString() + "', '" + getName() + "', 0)";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@MessageText", txtChatBox.Text);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            // if already on ViewChat page u *can* instead use GridView.Databind()
            Response.Redirect("ViewChat.aspx");
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

        // also, is sender name even needed in the SQL? since you have ID you should be able
        // to databound display the name. either way idk how it affects performance but generally i think
        // it would be better coding practice to do *not this* (Reminder: im only speculating)
        protected String getName()
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            sqlQuery = "SELECT FirstName + ' ' + LastName as Name FROM " + Session["UserType"] + " WHERE Username = '" + Session["Username"].ToString() + "';";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            SqlDataReader reader = sqlCommand.ExecuteReader();
            reader.Read();
            return reader["Name"].ToString();
        }
    }
}