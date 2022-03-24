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

        }

        protected void navigation_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (navigation.SelectedValue == "Homepage")
            //    Response.Redirect("memberHome.aspx");
            //else if (navigation.SelectedValue == "View Profile")
            //    Response.Redirect("viewMemberProfile.aspx");
            //else if (navigation.SelectedValue == "View Scholarships")
            //    Response.Redirect("viewTableScholarship.aspx");
            //else if (navigation.SelectedValue == "View Internships")
            //    Response.Redirect("viewTableInternship.aspx");
            //else if (navigation.SelectedValue == "View Jobs")
            //    Response.Redirect("Job.aspx");
            //else return;
        }

        protected void btnReturnHome_Click(object sender, EventArgs e)
        {

        }
    }
}