using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.profiles
{
    public partial class EditStudentProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // so data does not replace itself when clicking button to commit changes
            {                // i forgot button clicks cause postback.
                try
                {
                    populatePage();
                }
                catch (SqlException)
                {
                    Session["MustLogIn"] = "You must log in to access that page.";
                    Response.Redirect("/login/Login.aspx");
                    throw;
                }
            }
        }

        protected System.Void btnUpload_Click()
        {

        }

        protected System.Void btnUpdate_Click()
        {

        }

        protected System.Void btnReturn_Click()
        {

        }
    }
}