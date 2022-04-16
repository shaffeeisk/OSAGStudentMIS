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
    public partial class NewChat : System.Web.UI.Page
    {
        static String[] memberRecipients = new String[10];
        static String[] studentRecipients = new String[10];
        static int m = 0;
        static int s = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                s = 0;
                m = 0;
                Array.Clear(memberRecipients, 0, memberRecipients.Length);
                Array.Clear(studentRecipients, 0, studentRecipients.Length);
            }

            if (Session["Username"] == null)
            {
                // return; <-- alternative solution (Master Page_Load runs instead)
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }
            sqlsrcStudents.SelectCommand = "Select StudentID, FirstName + ' ' + Lastname as Name FROM Student Where Username != '" + Session["Username"].ToString() + "'";
            sqlsrcMembers.SelectCommand = "Select MemberID, FirstName + ' ' + Lastname as Name FROM Member Where Username != '" + Session["Username"].ToString() + "'";
        }

        protected void btn_Send_Click(object sender, EventArgs e)
        {
            if (txtChatBox.Text == "")
                return;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            for(int i = 0; i < s; i++)
            {
                sqlQuery = "INSERT INTO ChatMessage (MessageText, " + Session["UserType"].ToString() + "SenderID, StudentReceiverID, SenderName, IsRead) " +
                                "VALUES (@MessageText, '" + getID() + "', '" + studentRecipients[i].ToString() + "', '" + getName() + "', 0)";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlCommand.Parameters.AddWithValue("@MessageText", txtChatBox.Text);
                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }
            for(int i = 0; i < m; i++)
            {
                sqlQuery = "INSERT INTO ChatMessage (MessageText, " + Session["UserType"].ToString() + "SenderID, MemberReceiverID, SenderName, IsRead) " +
                                "VALUES (@MessageText, '" + getID() + "', '" + memberRecipients[i].ToString() + "', '" + getName() + "', 0)";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlCommand.Parameters.AddWithValue("@MessageText", txtChatBox.Text);
                sqlConnect.Open();
                sqlCommand.ExecuteScalar();
                sqlConnect.Close();
            }

            // if already on ViewChat page u *can* instead use GridView.Databind()
            txtChatBox.Text = "";
            s = 0;
            m = 0;
            Array.Clear(memberRecipients, 0, memberRecipients.Length);
            Array.Clear(studentRecipients, 0, studentRecipients.Length);
            txtMembers.Text = "";
            txtStudents.Text = "";
        }

        protected void ddl_MemberRecipient_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (m < 10)
            {
                if (m > 0)
                    txtMembers.Text += ", " + ddl_MemberRecipient.SelectedItem.Text;
                else
                    txtMembers.Text += ddl_MemberRecipient.SelectedItem.Text;
                memberRecipients[m] = ddl_MemberRecipient.SelectedValue;
                m++;
            }
            else
                lblMemberMax.Text = "Error: Can only select 10 members at a time.";


        }

        protected void ddl_StudentRecipient_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (s < 10)
            {
                if (s > 0)
                    txtStudents.Text += ", " + ddl_StudentRecipient.SelectedItem.Text;
                else
                    txtStudents.Text += ddl_StudentRecipient.SelectedItem.Text;
                studentRecipients[s] = ddl_StudentRecipient.SelectedValue;
                s++;
            }
            else
                lblStudentMax.Text = "Error: Can only select 10 Students at a time.";

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
                if (Session["UserType"].ToString() == "student")
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