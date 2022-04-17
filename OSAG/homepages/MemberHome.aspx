<%--Member Home Page--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="MemberHome.aspx.cs" Inherits="OSAG.homepages.MemberHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Banner starts-->
    <div class="container col-lg-8 px-2 py-3">
        <div class="row flex-lg-row-reverse align-items-center g-4 py-5">
            <div class="col-10 col-sm-8 col-lg-6">
                <img src="/_images/banners/homepage.png" class="d-block mx-lg-auto img-fluid" alt="Header" width="2000" height="1500">
            </div>

            <div class="col-lg-6">
                <h1 class="header fw-bold lh-1 pt-3 pb-4">Find Your Future.</h1>
                <p class="headertext">
                    A grass roots, non-profit organization envisioned by three African American James Madison University (JMU) alumni that graduated in the 1980’s.
              
              <p class="headertext">The Ole School Alumni Group offers a professional network and recruitment liaison for underrepresented students. </p>

                <div class="d-grid gap-2 d-lg-flex justify-content-lg-start pt-4">
                    <asp:Button ID="btnInternships" runat="server" Text="Internships" CssClass="btn btn-outline-secondary btn-lg px-4" OnClick="btnInternships_Click"/>
                    <asp:Button ID="btnJobs" runat="server" Text="Jobs" CssClass="btn btn-outline-secondary btn-lg px-4" OnClick="btnJobs_Click"/>
                </div>

            </div>
        </div>
    </div>
    <!--Banner ends-->
</asp:Content>
