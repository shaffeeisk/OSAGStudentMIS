﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.student
{
    public partial class ViewApplications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["UserType"].ToString() != "student")
                return;
            sqlsrc.SelectCommand = "SELECT Job.JobID, JobName, CompanyName, AppStatus FROM Job " +
                "LEFT JOIN Company ON Job.CompanyID = Company.CompanyID " +
                "LEFT JOIN JobMatch ON JobMatch.JobID = Job.JobID " +
                "LEFT JOIN Student ON Student.StudentID = JobMatch.StudentID " +
                "WHERE AppStatus IS NOT NULL AND Student.Username = '" + Session["Username"] + "'";
            sqlsrc2.SelectCommand = "SELECT Internship.InternshipID, InternshipName, CompanyName, AppStatus FROM Internship " +
                "LEFT JOIN Company ON Internship.CompanyID = Company.CompanyID " +
                "LEFT JOIN InternshipMatch ON InternshipMatch.InternshipID = Internship.InternshipID " +
                "LEFT JOIN Student ON Student.StudentID = InternshipMatch.StudentID " +
                "WHERE AppStatus IS NOT NULL AND Student.Username = '" + Session["Username"] + "'";
            sqlsrc3.SelectCommand = "SELECT Opportunity.OpportunityID, OpportunityName, OpportunityDescription, AppStatus FROM Opportunity " +
                "LEFT JOIN Company ON Opportunity.CompanyID = Company.CompanyID " +
                "LEFT JOIN OpportunityMatch ON OpportunityMatch.OpportunityID = Opportunity.OpportunityID " +
                "LEFT JOIN Student ON Student.StudentID = OpportunityMatch.StudentID " +
                "WHERE AppStatus IS NOT NULL AND Student.Username = '" + Session["Username"] + "'";
        }

        // jobs bookmarked
        protected void btnView_Click(object sender, EventArgs e)
        {
            Session["View"] = grdvwJobs.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex].Value;
            Response.Redirect("/jobs/JobDetails.aspx");
        }

        // internships bookmarked
        protected void btnView2_Click(object sender, EventArgs e)
        {
            Session["View"] = grdvwInternships.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex].Value;
            Response.Redirect("/internships/InternshipDetails.aspx");
        }

        // opportunities bookmarked
        protected void btnView3_Click(object sender, EventArgs e)
        {
            Session["View"] = grdvwOpportunities.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex].Value;
            Response.Redirect("/opportunities/OpportunityDetails.aspx");
        }
    }
}