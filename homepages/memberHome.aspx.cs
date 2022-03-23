using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// colored response import
using System.Drawing;

namespace Lab2
{
    public partial class memberHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccessDenied"] != null)
            {
                lblAccessDenied.Text = Session["AccessDenied"].ToString();
                lblAccessDenied.ForeColor = Color.Red;
                lblAccessDenied.Font.Bold = true;
            }
            if ((String)Session["Username"] == "admin")
            {
                btnApproveRegistration.Enabled = true;
            }
        }

        protected void btnViewMember_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewMemberProfile.aspx");
        }

        protected void btnViewScholarships_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewTableScholarship.aspx");
        }

        protected void btnViewInternships_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewTableInternship.aspx");
        }

        protected void btnViewJobs_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewTableJob.aspx");
        }

        protected void btnViewStudents_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewTableStudent.aspx");
        }

        protected void btnApproveRegistration_Click(object sender, EventArgs e)
        {
            Response.Redirect("registrationApproval.aspx");
        }
    }
}