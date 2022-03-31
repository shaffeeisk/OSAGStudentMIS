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
    public partial class ViewChat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            sqlsrc.SelectCommand = "Select MessageID, DateCreated, MessageText, SenderName FROM ChatMessage WHERE (" +
                Session["UserType"].ToString() + "SenderID = '" + getID() + "' AND " +
                 Session["UserChatType"].ToString() + "ReceiverID = " + Session["UserChatID"] + ") OR (" +
                 Session["UserType"].ToString() + "ReceiverID = '" + getID() + "' AND " +
                 Session["UserChatType"].ToString() + "SenderID = '" + Session["UserChatID"] + "')";
        }

        protected void btn_Send_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            sqlQuery = "INSERT INTO ChatMessage (MessageText, " + Session["UserType"].ToString() + "SenderID, " + Session["UserChatType"].ToString() + "ReceiverID, SenderName) " +
                "VALUES (@MessageText, '" + getID() + "', '" + Session["UserChatID"].ToString() + "', '" + getName() + "')";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@MessageText", txtChatBox.Text);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect("ViewChat.aspx");
        }

        protected String getID()
        {
            String ID = "";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            sqlQuery = "SELECT " + Session["UserType"] + "ID FROM " + Session["UserType"] + " WHERE Username = '" + Session["Username"].ToString() + "';";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();

            // read data onto page
            SqlDataReader reader = sqlCommand.ExecuteReader();
            while (reader.Read())
            {
                if(Session["UserType"] == "student")
                {
                    ID = reader["StudentID"].ToString();
                }
                else
                {
                    ID = reader["MentorID"].ToString();

                }

            }

            return ID;
        }

        protected String getName()
        {
            String Name = "";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            sqlQuery = "SELECT FirstName + ' ' + LastName as Name FROM " + Session["UserType"] + " WHERE Username = '" + Session["Username"].ToString() + "';";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();

            // read data onto page
            SqlDataReader reader = sqlCommand.ExecuteReader();
            while (reader.Read())
            {
                Name = reader["Name"].ToString();
            }

            return Name;
        }

    }
}