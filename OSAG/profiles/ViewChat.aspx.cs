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
            // handle invalid access
            if (Session["Username"] == null)
                return;
            else if(Session["UserChatType"] == null || Session["UserChatID"] == null)
            {
                Session["AccessDenied"] = "Access Denied: An unknown error occurred.";
                Response.Redirect("UserProfile.aspx");
            }
            // otherwise set select command
            sqlsrc.SelectCommand = "Select DateCreated, MessageText, SenderName FROM ChatMessage WHERE (" +
                Session["UserType"].ToString() + "SenderID = '" + getID() + "' AND " +
                 Session["UserChatType"].ToString() + "ReceiverID = " + Session["UserChatID"] + ") OR (" +
                 Session["UserType"].ToString() + "ReceiverID = '" + getID() + "' AND " +
                 Session["UserChatType"].ToString() + "SenderID = '" + Session["UserChatID"] + "')";
        }

        protected void btn_Send_Click(object sender, EventArgs e)
        {
            if (txtChatBox.Text == "")
                return;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            sqlQuery = "INSERT INTO ChatMessage (MessageText, " + Session["UserType"].ToString() + "SenderID, " + Session["UserChatType"].ToString() + "ReceiverID, SenderName) " +
                "VALUES (@MessageText, '" + getID() + "', '" + Session["UserChatID"].ToString() + "', '" + getName() + "')";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@MessageText", txtChatBox.Text);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            // if already on ViewChat page u *can* instead use GridView.Databind()
            Response.Redirect("ViewChat.aspx");
        }

        // might be a better way than querying for ID and Name EVERY message send
        // maybe run these helper methods in page_load and compare/set with Session variables
        // reader not needed, selecting one column entry (can use ExecuteScalar)
        // FYI ExecuteScalar() returns First Column of First Row of query result
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
                if(Session["UserType"].ToString() == "student")
                {
                    ID = reader["StudentID"].ToString();
                }
                else
                {
                    ID = reader["MemberID"].ToString();

                }

            }

            return ID;
        }

        // also, is sender name even needed in the SQL? since you have ID you should be able
        // to databound display the name. either way idk how it affects performance but generally i think
        // it would be better coding practice to do *not this* (Reminder: im only speculating)
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

        //// converts all timestamps in gridview to local time each refresh
        //public void updateTimes()
        //{
            
        //    foreach (GridViewRow r in grdvChat.Rows)
        //        r.Cells[0].Text = DateTime.Parse(r.Cells[0].Text).ToLocalTime().ToString();
        //}

    }
}