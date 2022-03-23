using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG
{
    public partial class ViewTable : System.Web.UI.MasterPage
    {
        // on page load kick user from ALL pages requiring login
        // otherwise populate login bar with username
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || (String)Session["UserType"] != "member")
            {
                Session["MustLogin"] = "You do not have access to that page. Please log in to continue.";
                Response.Redirect("logIn.aspx");
            }
            else
            {
                lblUsername.Text = Session["Username"].ToString();
            }
        }

        // handle nav bar dropdown list selection
        protected void navigation_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (navigation.SelectedValue == "Homepage")
                Response.Redirect("memberHome.aspx");
            else if (navigation.SelectedValue == "View Profile")
                Response.Redirect("viewMemberProfile.aspx");
            else if (navigation.SelectedValue == "View Student Profiles")
                Response.Redirect("viewTableStudent.aspx");
            else if (navigation.SelectedValue == "View Scholarships")
                Response.Redirect("viewTableScholarship.aspx");
            else if (navigation.SelectedValue == "View Internships")
                Response.Redirect("viewTableInternship.aspx");
            else if (navigation.SelectedValue == "View Jobs")
                Response.Redirect("viewTableJob.aspx");
            else
                return;
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            /********************************************
            *  Any user data that you need to work with *
            *  do here before you abandon session       *
            *********************************************/

            // wipe user session data (user bubble gets popped)
            Session.Abandon();
            Response.Redirect("homePage.aspx");
        }

        protected void btnReturnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("memberHome.aspx");
        }
    }
}