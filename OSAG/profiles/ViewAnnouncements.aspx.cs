using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
//Connection Strings in web.config
using System.Web.Configuration;
using System.Drawing;
using System.IO;
using System.Data;

namespace OSAG.profiles
{
    public partial class ViewAnnouncements : System.Web.UI.Page
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
            
            int UserType;
            if (majors == "")
                majors = "0";
            if (Session["UserType"].ToString() == "member")
            {
                UserType = 2;
                sqlsrcAnnouncements.SelectCommand = "Select * From Announcement WHERE (MajorID in (" + majors + ") OR MajorID is NULL) AND (UserType = 0 OR UserType = '" + UserType + "')" +
                    "AND (MemberType >= " + Session["MemberType"] + ")";
            }
            else
            {
                UserType = 1;
                sqlsrcAnnouncements.SelectCommand = "Select * From Announcement WHERE (MajorID in (" + majors + ") OR MajorID is NULL) AND (UserType = 0 or UserType = '" + UserType + "')";
            }

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