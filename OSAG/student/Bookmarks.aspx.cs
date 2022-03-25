using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.student
{
    public partial class Bookmarks : System.Web.UI.Page
    {
        // set select commands based on session variables
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Username"] = "bsterling"; // TESTING PURPOSES ONLY

            sqlsrc.SelectCommand = "SELECT JobName, CompanyName FROM Job " +
                "LEFT JOIN Company ON Job.CompanyID = Company.CompanyID " +
                "LEFT JOIN JobMatch ON JobMatch.JobID = Job.JobID " +
                "LEFT JOIN Student ON Student.StudentID = JobMatch.StudentID " +
                "WHERE JobMatch.isBookmark = 1 AND Student.Username = '" + Session["Username"] + "'";
            sqlsrc2.SelectCommand = "SELECT InternshipName, CompanyName FROM Internship " +
                "LEFT JOIN Company ON Internship.CompanyID = Company.CompanyID " +
                "LEFT JOIN InternshipMatch ON InternshipMatch.InternshipID = Internship.InternshipID " +
                "LEFT JOIN Student ON Student.StudentID = InternshipMatch.StudentID " +
                "WHERE InternshipMatch.IsBookmark = 1 AND Student.Username = '" + Session["Username"] + "'";
            sqlsrc3.SelectCommand = "SELECT AwardName, AwardAmount FROM Opportunity " +
                "LEFT JOIN OpportunityMatch ON OpportunityMatch.OpportunityID = Opportunity.OpportunityID " +
                "LEFT JOIN Student ON Student.StudentID = OpportunityMatch.StudentID " +
                "WHERE OpportunityMatch.IsBookmark = 1 AND Student.Username = '" + Session["Username"] + "'";
        }

        // jobs bookmarked
        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text + gvr.Cells[1].Text;
            Response.Redirect("JobDetails.aspx");
        }

        // internships bookmarked
        protected void btnView2_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text + gvr.Cells[1].Text;
            Response.Redirect("InternshipDetails.aspx");
        }

        // opportunities bookmarked
        protected void btnView3_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text;
            Response.Redirect("OpportunityDetails.aspx");
        }
    }
}