using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.profiles
{
    public partial class ListUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        // event handler to search student
        protected void btnSearchStu_Click(object sender, EventArgs e)
        {
            String stuFilter = "SELECT Username, FirstName, LastName FROM Student " +
                   "WHERE FirstName + ' ' + LastName LIKE '%[Search]%';";
            sqlsrcStudentQuery.SelectCommand = stuFilter.Replace("[Search]", HttpUtility.HtmlEncode(searchBar.Value.Trim()));
            grdvStudent.DataBind(); // COMMAND FIXES BUG WHERE PREVIOUS SEARCH PERSISTS AFTER CLEARING SEARCHBAR
        }

        // event handler to search mentor
        protected void btnSearchMent_Click(object sender, EventArgs e)
        {
            String mentFilter = "SELECT Username, FirstName, LastName FROM Mentor " +
                   "WHERE FirstName + ' ' + LastName LIKE '%[Search]%';";
            sqlsrcMentorQuery.SelectCommand = mentFilter.Replace("[Search]", HttpUtility.HtmlEncode(searchBar2.Value.Trim()));
            grdvMentor.DataBind(); // COMMAND FIXES BUG WHERE PREVIOUS SEARCH PERSISTS AFTER CLEARING SEARCHBAR
        }

        protected void grdvUser_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='aquamarine';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='white';";
                e.Row.ToolTip = "Click \"Select\" to edit this student.";
            }
        }

        protected void grdvStudent_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["ViewProfileUsername"] = grdvStudent.SelectedRow.Cells[1].Text;
            Session["ViewProfileUserType"] = "student";
            Response.Redirect("ViewProfile.aspx");
        }
        
        protected void grdvMentor_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["ViewProfileUsername"] = grdvMentor.SelectedRow.Cells[1].Text;
            Session["ViewProfileUserType"] = "mentor";
            Response.Redirect("ViewProfile.aspx");
        }
    }
}