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
            sqlsrcStudent.SelectCommand = "Select StudentID,FirstName,LastName FROM Student where Username != '" + Session["Username"].ToString() + "'";
            sqlsrcMember.SelectCommand = "Select MemberID,FirstName,LastName FROM Member where Username != '" + Session["Username"].ToString() + "'";
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
    }
}