/*code behind for Default home page*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.homepages
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccessDenied"] != null)
                lblStatus.Text = Session["AccessDenied"].ToString();
        }
        protected void btnRegistration_Click(object sender, EventArgs e)
        {
            Response.Redirect("/login/RegistrationPage.aspx");
        }

        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            Response.Redirect("/login/LoginPage.aspx");
        }
    }
}