using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.profiles
{
    public partial class StartChat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["Username"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }
            sqlsrcStudent.SelectCommand = "Select StudentID,FirstName,LastName FROM Student where Username != '" + Session["Username"].ToString() + "'";
            sqlsrcMentor.SelectCommand = "Select MentorID,FirstName,LastName FROM Mentor where Username != '" + Session["Username"].ToString() + "'";
        }

        protected void btn_studentChat_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["UserChatID"] = grdvStudent.DataKeys[gvr.RowIndex].Value;
            Session["UserChatType"] = "Student";
            Response.Redirect("ViewChat.aspx");
        }

        protected void btn_mentorChat_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["UserChatID"] = grdvMentor.DataKeys[gvr.RowIndex].Value;
            Session["UserChatType"] = "Mentor";
            Response.Redirect("ViewChat.aspx");
        }
    }
}