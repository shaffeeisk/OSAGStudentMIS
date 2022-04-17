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

namespace OSAG.admin
{
    public partial class CreateAnnouncement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Session["MustLogin"] = "You must log in to access that page.";
                Response.Redirect("/login/LoginPage.aspx");
            }
        }

        protected void btn_Send_Click(object sender, EventArgs e)
        {
            if (txtHeader.Text == "" || txtBody.Text == "")
                return;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString.ToString());
            String sqlQuery;
            sqlQuery = "INSERT INTO Announcement(Header, Body, Link, MajorID, MemberType, UserType) VALUES(@Header, @Body, @Link, @MajorID, @MemberType, @UserType)";
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Header", txtHeader.Text);
            sqlCommand.Parameters.AddWithValue("@Body", txtBody.Text);
            sqlCommand.Parameters.AddWithValue("@Link", txtLink.Text);
            if (ddl_Major.SelectedValue == "0")
                sqlCommand.Parameters.AddWithValue("@MajorID", DBNull.Value);
            else
                sqlCommand.Parameters.AddWithValue("@MajorID", ddl_Major.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@MemberType", ddl_MemberType.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@UserType", ddl_UserType.SelectedValue);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            // if already on ViewChat page u *can* instead use GridView.Databind()
            txtBody.Text = "";
            txtHeader.Text = "";
            txtLink.Text = "";
            lblSent.Text = "Successfully sent!";
        }

        protected void ddl_UserType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl_UserType.SelectedValue == "2")
            {
                lblMemberType.Visible = true;
                ddl_MemberType.Visible = true;
            }
            else
            {
                lblMemberType.Visible = false;
                ddl_MemberType.Visible = false;
            }
        }
    }
}