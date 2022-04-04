using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            // Redirect the client's browser 

            Response.Redirect("/login/LoginPage.aspx?loggedout=true");
        }

        protected void ddlNavigation_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlNavigation.SelectedValue == " ")
                return;
            else if (ddlNavigation.SelectedValue == "PROFILE")
                Response.Redirect("/profiles/ViewProfile.aspx");
            else if (ddlNavigation.SelectedValue == "CHAT")
                Response.Redirect("/profiles/StartChat.aspx");
            else if (ddlNavigation.SelectedValue == "BOOKMARKS")
                Response.Redirect("/student/Bookmarks.aspx");
            else if (ddlNavigation.SelectedValue == "SIGN OUT")
                Response.Redirect("/login/LoginPage.aspx");
            else
                return;

        }
    }
}