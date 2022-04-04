using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.templates
{
    public partial class Details : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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