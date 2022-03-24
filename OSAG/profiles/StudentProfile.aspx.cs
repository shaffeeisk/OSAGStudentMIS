using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.profiles
{
    public partial class StudentProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                "SELECT Student.FirstName + ' ' + Student.LastName AS StuName, " +
               "Student.Email AS StuEmail, GraduationDate, " +
               "Member.FirstName + ' ' + Member.LastName AS MembName, Member.Email AS MembEmail, EmpName " +
               "FROM Member RIGHT JOIN Student ON Member.MemberID = Student.MemberID " +
               "LEFT JOIN Employer ON Employer.EmployerID = Student.EmployerID " +
               "WHERE Student.Username = @Username;";
                sqlsrcMemberQuery.SelectCommand = "SELECT Student.FirstName + ' ' + Student.LastName AS StuName, Student.Email AS StuEmail, GraduationDate, " +
               "Member.FirstName + ' ' + Member.LastName AS MembName, Member.Email AS MembEmail, EmpName " +
               "FROM Member RIGHT JOIN Student ON Member.MemberID = Student.MemberID LEFT JOIN Employer ON Employer.EmployerID = Student.EmployerID " +
                    "FROM Student WHERE Username = '" + (String)Session["Username"] + "';";
            }
            catch (SqlException)
            {
                Session["MustLogIn"] = "You must log in to access that page.";
                Response.Redirect("/login/Login.aspx");
                throw;
            }
        }

        protected System.Void btnEdit_Click()
        {
            Response.Redirect("/profiles/EditStudentProfile");
        }
    }
}