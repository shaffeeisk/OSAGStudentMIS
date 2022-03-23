using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Lab3
{
    public partial class editTemplate : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["Username"] != null)
            {
                lblUsername.Text = (String)Session["Username"];
            }
            else
            {
                Session["MustLogIn"] = "You must log in to access that page.";
                Response.Redirect("logIn.aspx");
            }
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

        protected void navigation_SelectedIndexChanged(object sender, EventArgs e)
        {
            // this so cleverly hurts my brain
            if ((String)Session["usertype"] == "member")
            {
                if (navigation.SelectedValue == "Homepage")
                    Response.Redirect("memberHome.aspx");
                else if (navigation.SelectedValue == "View Profile")
                    Response.Redirect("viewMemberProfile.aspx");
            }
            else if ((String)Session["usertype"] == "student")
            {
                if (navigation.SelectedValue == "Homepage")
                    Response.Redirect("studentHome.aspx");
                else if (navigation.SelectedValue == "View Profile")
                    Response.Redirect("viewTableStudent.aspx");
            }
            else if (navigation.SelectedValue == "View Scholarships")
                Response.Redirect("viewTableScholarship.aspx");
            else if (navigation.SelectedValue == "View Internships")
                Response.Redirect("viewTableInternship.aspx");
            else if (navigation.SelectedValue == "View Jobs")
                Response.Redirect("viewTableJob.aspx");
        }
    }
}