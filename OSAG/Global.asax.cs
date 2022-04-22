using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace OSAG
{
    public class Global : System.Web.HttpApplication
    {
        // Fired when the first instance of the HttpApplication class is created.
        // It allows you to create objects that are accessible by all HttpApplication instances.
        protected void Application_Start(object sender, EventArgs e)
        {

        }

        // Fired when a new user visits the application Web site.
        protected void Session_Start(object sender, EventArgs e)
        {

        }

        // Fired when an application request is received.
        // It's the first event fired for a request, which is often a page request (URL) that a user enters.
        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        // Fired when the security module has established the current user's identity as valid.
        // At this point, the user's credentials have been validated.
        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        // Fired when an unhandled exception is encountered within the application.
        protected void Application_Error(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.ToString().Contains("profiles/UserProfile.aspx") &&
        HttpContext.Current.Error.InnerException.Message.Contains("Maximum request length exceeded"))
            {
                HttpContext.Current.ClearError();
                HttpContext.Current.Response.Redirect(
                    string.Format("/profiles/UserProfile.aspx?Message={0}&viewstate=edit", "File size too large! Please limit uploads to 2 MB."));
            }
            else if (HttpContext.Current.Request.Url.ToString().Contains("UnapprovedUserProfile.aspx") &&
        HttpContext.Current.Error.InnerException.Message.Contains("Maximum request length exceeded"))
            {
                HttpContext.Current.ClearError();
                HttpContext.Current.Response.Redirect(
                    string.Format("/profiles/UnapprovedUserProfile.aspx?Message={0}&viewstate=edit", "File size too large! Please limit uploads to 2 MB."));
            }
            else if (HttpContext.Current.Request.Url.ToString().Contains("OleSchoolScholarship.aspx") &&
        HttpContext.Current.Error.InnerException.Message.Contains("Maximum request length exceeded"))
            {
                HttpContext.Current.ClearError();
                HttpContext.Current.Response.Redirect(
                    string.Format("/student/OleSchoolScholarship.aspx?Message={0}", "File size too large! Please limit uploads to 2 MB."));
            }
        }

        // Fired when a user's session times out, ends, or they leave the application Web site.
        protected void Session_End(object sender, EventArgs e)
        {

        }

        // Fired when the last instance of an HttpApplication class is destroyed.
        // It's fired only once during an application's lifetime.
        protected void Application_End(object sender, EventArgs e)
        {

        }

        /* OTHER Global.asax METHODS:
         
         - Application_Init:
         - Fired when an application initializes or is first called.
         - It's invoked for all HttpApplication object instances.
         
         - Application_Disposed:
         - Fired just before an application is destroyed.
         - This is the ideal location for cleaning up previously used resources.
         
         - Application_EndRequest:
         - The last event fired for an application request.
         
         - Application_PreRequestHandlerExecute:
         - Fired before the ASP.NET page framework begins executing an event handler like a page or Web service.
         
         - Application_PostRequestHandlerExecute:
         - Fired when the ASP.NET page framework is finished executing an event handler.
         
         - Applcation_PreSendRequestHeaders:
         - Fired before the ASP.NET page framework sends HTTP headers to a requesting client (browser).
         
         - Application_PreSendContent:
         - Fired before the ASP.NET page framework sends content to a requesting client (browser).
         
         - Application_AcquireRequestState:
         - Fired when the ASP.NET page framework gets the current state (Session state) related to the current request.
         
         - Application_ReleaseRequestState:
         - Fired when the ASP.NET page framework completes execution of all event handlers.
         - This results in all state modules to save their current state data.

         - Application_ResolveRequestCache:
         - Fired when the ASP.NET page framework completes an authorization request.
         - It allows caching modules to serve the request from the cache, thus bypassing handler execution.
         
         - Application_UpdateRequestCache:
         - Fired when the ASP.NET page framework completes handler execution to allow 
         - caching modules to store responses to be used to handle subsequent requests.
         
         - Application_AuthorizeRequest:
         - Fired when the security module has verified that a user can access resources. */
    }
}