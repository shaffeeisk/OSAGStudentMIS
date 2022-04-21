using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.homepages
{
    public partial class HomePage2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                string sqlQuery =
                    "SELECT(SELECT COUNT(*) FROM JobMatch WHERE AppStatus IS NOT NULL) + (SELECT COUNT(*) FROM JobMatch WHERE AppStatus IS NOT NULL) AS 'a'; " +
                    "SELECT COUNT(*) AS 'b' FROM Member;" +
                    "SELECT COUNT(*) AS 'c' FROM Company;" +
                    "SELECT FORMAT(SUM(AwardAmount),'C') AS 'd' FROM Scholarship;";
                SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
                sqlConnect.Open();
                SqlDataReader reader = sqlCommand.ExecuteReader();
                reader.Read();
                lblJandI.Text = reader["a"].ToString();
                reader.NextResult();
                reader.Read();
                lblMembers.Text = reader["b"].ToString();
                reader.NextResult();
                reader.Read();
                lblCompanies.Text = reader["c"].ToString();
                reader.NextResult();
                reader.Read();
                lblScholarship.Text = reader["d"].ToString();
            }
        }
    }
}