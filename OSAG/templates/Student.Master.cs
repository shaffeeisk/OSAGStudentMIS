using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG
{
    public partial class Student : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            // Redirect the client's browser 

            Response.Redirect("/login/LoginPage.aspx?loggedout=true");

        }

        protected void navigation_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (navigation.SelectedValue == "Homepage")
                Response.Redirect("Homepage.aspx");
            else if (navigation.SelectedValue == "View Jobs")
                Response.Redirect("/jobs/Jobs.aspx");
            else if (navigation.SelectedValue == "View Internships")
                Response.Redirect("/internships/Internships.aspx");
            else if (navigation.SelectedValue == "View Opportunities")
                Response.Redirect("/opportunities/Opportunities.aspx");
            else if (navigation.SelectedValue == "View Bookmarks")
                Response.Redirect("/student/Bookmarks.aspx");
            else return;
        }

        protected void btnReturnHome_Click(object sender, EventArgs e)
        {

        }
    }
}