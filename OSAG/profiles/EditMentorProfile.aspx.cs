using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.profiles
{
    public partial class EditMentorProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                    populatePage();
            }
            catch (SqlException)
            {
                Session["MustLogIn"] = "You must log in to access that page.";
                Response.Redirect("/login/Login.aspx");
                throw;
            }
        }

        protected System.Void btnUpdate_Click()
        {
            String sqlQuery = "UPDATE Member SET " +
               "FirstName = @FN, " +
               "LastName = @LN, " +
               "Email = @Email, " +
               "StAddress = @Addr, " +
               "City = @City, " +
               "M_State = @State, " +
               "ZipCode = @Zip " +
               "WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", (String)Session["Username"]);
            sqlCommand.Parameters.AddWithValue("@FN", validate(firstName.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@LN", validate(lastName.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@Email", validate(email.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@Addr", validate(stAddress.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@City", validate(city.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@State", validate(state.Value.ToString()));
            sqlCommand.Parameters.AddWithValue("@Zip", validate(zip.Value.ToString()));
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            lblUpdateStatus.Text = "Profile successfully updated.";
        }

        protected System.Void btnBack_Click()
        {
            Response.Redirect("/profiles/MentorProfile.aspx");
        }

        protected void populatePage()
        {
            String sqlQuery = "SELECT FirstName, LastName, Email, StAddress, City, M_State, ZipCode FROM Mentor WHERE Username = @Username;";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlCommand.Parameters.AddWithValue("@Username", (String)Session["Username"]);
            sqlConnect.Open();
            SqlDataReader queryResults = sqlCommand.ExecuteReader();
            queryResults.Read();
            firstName.Value = queryResults["FirstName"].ToString();
            lastName.Value = queryResults["LastName"].ToString();
            email.Value = queryResults["Email"].ToString();
            stAddress.Value = queryResults["StAddress"].ToString();
            city.Value = queryResults["City"].ToString();
            state.Value = queryResults["M_State"].ToString();
            zip.Value = queryResults["ZipCode"].ToString();
            queryResults.Close();
            sqlConnect.Close();
        }

        // helper method to validate data. trims input string of leading/trailing white space.
        // then returns null if user input is empty. otherwise, returns the trimmed string.
        // allows data integrity to allow querying null input (also saves disk space :D)
        // (e.g. display students who don't have graduation dates so mentor can help them figure out when they should graduate)
        private object validate(String s)
        {
            s = s.Trim();
            if (s == "")
                return (object)DBNull.Value;
            return s;
        }
    }
}