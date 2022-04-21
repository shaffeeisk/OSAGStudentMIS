/* code behind for start chat */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.profiles
{
    // can probably copy over logic/code from ListUsers search functionality
    public partial class StartChat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["Username"] == null)
            {
                // return; <-- alternative solution (Master Page_Load runs instead)
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }
            sqlsrcStudent.SelectCommand = "Select StudentID,FirstName,LastName,CASE WHEN EXISTS(Select " + Session["UserType"] + "ReceiverID FROM ChatNotification LEFT JOIN Student ON Student.StudentID = ChatNotification.StudentSenderID WHERE " + Session["UserType"] + "ReceiverID = " + "(SELECT " + Session["UserType"].ToString() + "ID FROM " + Session["UserType"].ToString() + " WHERE Username = '" + Session["Username"] + "') AND StudentSenderID = StudentID)  THEN 'NEW' ELSE 'Read' END AS Status" +
                " FROM Student s LEFT JOIN ChatMessage cm ON (cm.StudentReceiverID = s.StudentID OR cm.StudentSenderID = s.StudentID) LEFT JOIN ChatNotification cn ON s.StudentID = cn.StudentSenderID where Username != '" + Session["Username"].ToString() + "' " +
                "AND (cm." + Session["UserType"].ToString() + "ReceiverID = (SELECT " + Session["UserType"].ToString() + "ID FROM " + Session["UserType"].ToString() + " WHERE Username = '" + Session["Username"] + "')" +
                " OR cm." + Session["UserType"].ToString() + "SenderID = (SELECT " + Session["UserType"].ToString() + "ID FROM " + Session["UserType"].ToString() + " WHERE Username = '" + Session["Username"] + "'))" +
                " GROUP BY StudentID,FirstName,LastName";

            sqlsrcMember.SelectCommand = "Select MemberID,FirstName,LastName,CASE WHEN EXISTS(Select " + Session["UserType"] + "ReceiverID FROM ChatNotification LEFT JOIN Member ON Member.MemberID = ChatNotification.MemberSenderID WHERE " + Session["UserType"] + "ReceiverID = " + "(SELECT " + Session["UserType"].ToString() + "ID FROM " + Session["UserType"].ToString() + " WHERE Username = '" + Session["Username"] + "') AND MemberSenderID = MemberID)  THEN 'NEW' ELSE 'Read' END AS Status" +
                " FROM Member s LEFT JOIN ChatMessage cm ON (cm.MemberReceiverID = s.MemberID OR cm.MemberSenderID = s.MemberID) LEFT JOIN ChatNotification cn ON s.MemberID = cn.MemberSenderID where Username != '" + Session["Username"].ToString() + "' " +
                "AND (cm." + Session["UserType"].ToString() + "ReceiverID = (SELECT " + Session["UserType"].ToString() + "ID FROM " + Session["UserType"].ToString() + " WHERE Username = '" + Session["Username"] + "')" +
                " OR cm." + Session["UserType"].ToString() + "SenderID = (SELECT " + Session["UserType"].ToString() + "ID FROM " + Session["UserType"].ToString() + " WHERE Username = '" + Session["Username"] + "'))" +
                " GROUP BY MemberID, FirstName, LastName";
        }

        protected void btn_studentChat_Click(object sender, EventArgs e)
        {
            Session["UserChatID"] = grdvStudent.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex].Value;
            Session["UserChatType"] = "Student";
            Response.Redirect("ViewChat.aspx");
        }

        protected void btn_memberChat_Click(object sender, EventArgs e)
        {
            Session["UserChatID"] = grdvMember.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex].Value;
            Session["UserChatType"] = "Member";
            Response.Redirect("ViewChat.aspx");
        }

        protected void btn_newChat_Click(object sender, EventArgs e)
        {
            Response.Redirect("NewChat.aspx");
        }
    }
}