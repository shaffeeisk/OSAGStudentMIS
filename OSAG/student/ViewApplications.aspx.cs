using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
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
            sqlsrc3.SelectCommand = "SELECT Opportunity.OpportunityID, OpportunityName, CompanyName, AppStatus FROM Opportunity " +
                "LEFT JOIN Company ON Opportunity.CompanyID = Company.CompanyID " +
                "LEFT JOIN OpportunityMatch ON OpportunityMatch.OpportunityID = Opportunity.OpportunityID " +
                "LEFT JOIN Student ON Student.StudentID = OpportunityMatch.StudentID " +
                "WHERE AppStatus IS NOT NULL AND Student.Username = '" + Session["Username"] + "'";
        }

        // jobs bookmarked
        protected void btnView_Click(object sender, EventArgs e)
        {
            Session["View"] = grdvwJobs.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex]["JobID"];
            Response.Redirect("/jobs/JobDetails.aspx");
        }

        // internships bookmarked
        protected void btnView2_Click(object sender, EventArgs e)
        {
            Session["View"] = grdvwInternships.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex]["InternshipID"];
            Response.Redirect("/internships/InternshipDetails.aspx");
        }

        // opportunities bookmarked
        protected void btnView3_Click(object sender, EventArgs e)
        {
            Session["View"] = grdvwOpportunities.DataKeys[((GridViewRow)((Button)sender).NamingContainer).RowIndex]["OpportunityID"];
            Response.Redirect("/opportunities/OpportunityDetails.aspx");
        }

        // jobs status changed
        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            string jobID = grdvwJobs.DataKeys[((GridViewRow)((DropDownList)sender).NamingContainer).RowIndex]["JobID"].ToString();
            string sqlQuery = "UPDATE JobMatch SET AppStatus = @AppStatus WHERE JobID = '" + jobID + "' " +
                "AND StudentID = '" + UsernameToID(Session["Username"].ToString()) + "';";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@AppStatus", validate(ddl.SelectedValue)); // param used for N/A -> NULL instead of ''
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
        }

        // internships status changed
        protected void ddlStatus2_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            string internshipID = grdvwInternships.DataKeys[((GridViewRow)((DropDownList)sender).NamingContainer).RowIndex]["InternshipID"].ToString();
            string sqlQuery = "UPDATE InternshipMatch SET AppStatus = @AppStatus WHERE InternshipID = '" + internshipID + "' " +
                "AND StudentID = '" + UsernameToID(Session["Username"].ToString()) + "';";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect); // param used for N/A -> NULL instead of ''
            sqlCommand.Parameters.AddWithValue("@AppStatus", validate(ddl.SelectedValue));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
        }

        // opportunities status changed
        protected void ddlStatus3_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            string opportunityID = grdvwOpportunities.DataKeys[((GridViewRow)((DropDownList)sender).NamingContainer).RowIndex]["OpportunityID"].ToString();
            string sqlQuery = "UPDATE OpportunityMatch SET AppStatus = @AppStatus WHERE OpportunityID = '" + opportunityID + "' " +
                "AND StudentID = '" + UsernameToID(Session["Username"].ToString()) + "';";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect); // param used for N/A -> NULL instead of ''
            sqlCommand.Parameters.AddWithValue("@AppStatus", validate(ddl.SelectedValue));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
        }

        // when data binds to jobs gridviewrow
        protected void grdvwJobs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // convert row's AppStatus (datakey) to string
                string appstatus = grdvwJobs.DataKeys[((GridViewRow)e.Row).RowIndex]["AppStatus"].ToString();
                // set the dropdown value
                (e.Row.FindControl("ddlStatus") as DropDownList).Items.FindByValue(appstatus).Selected = true;
            }
        }

        // when data binds to internships gridviewrow
        protected void grdvwInternships_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // convert row's AppStatus (datakey) to string
                string appstatus = grdvwInternships.DataKeys[((GridViewRow)e.Row).RowIndex]["AppStatus"].ToString();
                // set the dropdown value
                (e.Row.FindControl("ddlStatus2") as DropDownList).Items.FindByValue(appstatus).Selected = true;
            }
        }

        // when data binds to opportunities gridviewrow
        protected void grdvwOpportunities_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // convert row's AppStatus (datakey) to string
                string appstatus = grdvwOpportunities.DataKeys[((GridViewRow)e.Row).RowIndex]["AppStatus"].ToString();
                // set the dropdown value
                (e.Row.FindControl("ddlStatus3") as DropDownList).Items.FindByValue(appstatus).Selected = true;
            }
        }

        // helper method to execute stored procedure (username [GUID within program] -> StudentID/MemberID)
        protected int UsernameToID(string username)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("dbo.OSAG_UsernameToID", sqlConnect);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@Username", username);
            sqlConnect.Open();
            return (int)sqlCommand.ExecuteScalar();
        }

        // helper method to validate data. trims input string of leading/trailing white space.
        // then returns null if user input is empty. otherwise, returns the trimmed string.
        // allows data integrity to allow querying null input (also saves disk space :D)
        // (e.g. display students who don't have graduation dates so member can help them figure out when they should graduate)
        private object validate(String s)
        {
            s = s.Trim();
            if (s == "")
                return (object)DBNull.Value;
            return s;
        }
    }
}