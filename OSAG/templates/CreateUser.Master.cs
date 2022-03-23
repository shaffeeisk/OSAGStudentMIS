using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// SQL imports
using System.Data;
using System.Data.SqlClient;
// web.config imports
using System.Web.Configuration;

namespace OSAG
{
    public partial class CreateUuser : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReturnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("homePage.aspx");
        }
    }
}