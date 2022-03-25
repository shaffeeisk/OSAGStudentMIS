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
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlsrc.SelectCommand = "SELECT JobName, CompanyName FROM Job LEFT JOIN JobMatch ON JobMatch.JobID = Job.JobID" +
             "LEFT JOIN Student ON Student.StudentID = JobMatch.StudentID WHERE JobMatch.isBookmark = 1 AND Student.Username = '" + Session["Username"] + "'";
            sqlsrc2.SelectCommand = "SELECT InternshipName, CompanyName FROM Internship LEFT JOIN InternshipMatch ON InternshipMatch.InternshipID = Internship.InternshipID" +
             "LEFT JOIN Student ON Student.StudentID = InternshipMatch.StudentID WHERE InternshipMatch.isBookmark = 1 AND Student.Username = '" + Session["Username"] + "'";
            sqlsrc3.SelectCommand = "SELECT AwardName, AwardAmount FROM Internship LEFT JOIN InternshipMatch ON InternshipMatch.InternshipID = Internship.InternshipID" +
             "LEFT JOIN Student ON Student.StudentID = InternshipMatch.StudentID WHERE InternshipMatch.isBookmark = 1 AND Student.Username = '" + Session["Username"] + "'"; 
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text + gvr.Cells[1].Text;
            Response.Redirect("JobDetails.aspx");
        }

        protected void btnView2_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text + gvr.Cells[1].Text;
            Response.Redirect("InternshipDetails.aspx");
        }

        protected void btnView3_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["View"] = gvr.Cells[0].Text;
            Response.Redirect("OpportunityDetails.aspx");
        }
    }
}