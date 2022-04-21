using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.homepages
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }
            int UserID = UsernameToID(Session["Username"].ToString());
            String majors = UserIDToMajorIDs(UserID);

            if (majors == "")
                majors = "0";
            if (Session["UserType"].ToString() == "member")
            {
                sqlsrcAnnouncements.SelectCommand = "SELECT TOP 3 * FROM Announcement WHERE " +
                    "(MajorID IN (" + majors + ") OR MajorID IS NULL) AND " +
                    "(UserType = 0 OR UserType = '" + 2 + "') AND " +
                    "(MemberType >= " + Session["MemberType"] + ") ORDER BY DateCreated DESC";
            }
            else
            {
                sqlsrcAnnouncements.SelectCommand = "SELECT * FROM Announcement WHERE " +
                    "(MajorID IN (" + majors + ") OR MajorID IS NULL) AND " +
                    "(UserType = 0 OR UserType = '" + 1 + "') ORDER BY DateCreated DESC";
            }
            lblName.Text = UserToFirstName().ToUpper();
            if (lblName.Text.Trim() == "")
                lblName.Text = "UNKNOWN";
        }

        protected String UserToFirstName()
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("SELECT FirstName FROM " + Session["UserType"].ToString() + " WHERE Username = @Username", sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", Session["Username"].ToString());
            sqlConnect.Open();
            return sqlCommand.ExecuteScalar().ToString();
        }

        protected int UsernameToID(string username)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("dbo.OSAG_UsernameToID", sqlConnect);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@Username", username);
            sqlConnect.Open();
            return (int)sqlCommand.ExecuteScalar();
        }

        protected String UserIDToMajorIDs(int UserID)
        {
            String majors = "";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            SqlCommand sqlCommand;
            sqlQuery = "Select MajorID From HasMajor WHERE " + Session["UserType"].ToString() + "ID = '" + UserID + "'";
            sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();

            // read data onto page
            SqlDataReader reader = sqlCommand.ExecuteReader();
            while (reader.Read())
            {
                majors += reader["MajorID"].ToString() + ", ";
            }
            majors = majors.Trim().TrimEnd(',');
            sqlConnect.Close();
            return majors;
        }
    }
}