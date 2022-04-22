using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OSAG.student
{
    public partial class OleSchoolScholarship : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (rdoYes.Checked)
                    divApply.Visible = true;
                else
                    divApply.Visible = false;
            }
            if (Request.QueryString["Message"] != null) // Request.QueryString["key"] is the .../page.aspx?Message=message%and%etc
            {
                string errorMsg = Request.QueryString["Message"]; // text of querystring
                Response.Write("<script>alert('" + errorMsg + "');</script>");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (fileTranscript.HasFile && fileEssay.HasFile)
            {
                // transcript file validation
                if (fileTranscript.PostedFile.ContentLength > 2097152) // file is too large (>2mb)
                {
                    lblTStatus.Text = "File cannot be larger than 2MB.";
                    return;
                }
                if (fileTranscript.PostedFile.ContentType != "application/pdf") // make sure file is pdf
                {
                    lblTStatus.Text = "File must be in PDF format.";
                    return;
                }
                // essay file validation
                if (fileEssay.PostedFile.ContentLength > 2097152) // file is too large (>2mb)
                {
                    lblEStatus.Text = "File cannot be larger than 2MB.";
                    return;
                }
                if (fileTranscript.PostedFile.ContentType != "application/pdf") // file is not pdf
                {

                    lblEStatus.Text = "File must be in PDF format.";
                    return;
                }

                // define filestream and create binary reader
                Stream fsT = fileTranscript.PostedFile.InputStream;
                Stream fsE = fileEssay.PostedFile.InputStream;
                BinaryReader brT = new BinaryReader(fsT);
                BinaryReader brE = new BinaryReader(fsE);

                // then insert file into Student table
                string sqlQuery = "UPDATE Student SET TranscriptFile = @TranscriptFile, EssayFile = @EssayFile, AppliedToScholarship = 1 WHERE Username = @Username;";
                SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["OSAG"].ConnectionString);
                SqlCommand sqlCommand = new SqlCommand(sqlQuery);
                sqlCommand.Connection = sqlConnect;
                sqlCommand.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                sqlCommand.Parameters.AddWithValue("@TranscriptFile", brT.ReadBytes((Int32)fsT.Length)); // BinaryReader converts file to byte[]
                sqlCommand.Parameters.AddWithValue("@EssayFile", brE.ReadBytes((Int32)fsE.Length));
                sqlConnect.Open();
                sqlCommand.ExecuteNonQuery();
                sqlConnect.Close();
            }
            else
            {
                lblTStatus.Text = "An unknown error has occured.";
            }
        }
    }
}