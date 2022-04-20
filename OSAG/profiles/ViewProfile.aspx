<%--View profile page--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewProfile.aspx.cs" Inherits="OSAG.profiles.ViewProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <!-- VIEW MODE STARTS -->
        <div id="divModeView" runat="server" class="container">
            <div class="main-body pt-4 px-5">
                <div class="row pb-4">
                    <div class="col-1">
                        <asp:Button ID="btnReturn" runat="server" CssClass="btn btn-primary" Text="< RETURN TO USERS" OnClick="btnReturn_Click" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 px-3 pb-2">
                        <%if (Session["ViewProfileUserType"].ToString() == "student")
                            {%>
                        <h2>STUDENT PROFILE</h2>
                        <%} %>
                        <%else
                            {%>
                        <h2>MEMBER PROFILE</h2>
                        <% } %>
                    </div>
                </div>
                <div class="row gutters-sm">
                    <div class="col-lg-4 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center pt-3">
                                    <asp:Image ID="imgProfile" runat="server" Height="100px" Width="100px" CssClass="img-thumbnail" />
                                    <div class="mt-3">
                                        <h4 class="studentname">
                                            <asp:Label ID="lblViewName" runat="server"></asp:Label>
                                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="35" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16">
                                                <path id="isApproved" runat="server" d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z" />
                                            </svg>
                                        </h4>
                                        <p class="text-secondary mb-4 px-3">
                                            <asp:Label ID="lblViewDesc" runat="server"></asp:Label>
                                        </p>
                                        <%if (Session["ViewProfileUserType"].ToString() == "student")
                                            {%>
                                        <asp:Button ID="btnDownloadResume" class="btn btn-primary mb-3" runat="server" Text="VIEW RESUME" OnClick="btnDownloadResume_Click" />
                                        <%} %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card mt-3">
                            <ul class="list-group list-group-flush">
                                
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0">Email</h6>
                                    <span class="text-secondary">
                                        <asp:Label ID="lblViewEmail" runat="server"></asp:Label>
                                    </span>
                                </li>

                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0">Phone</h6>
                                    <span class="text-secondary">
                                        <asp:Label ID="lblViewPhone" runat="server"></asp:Label>
                                    </span>
                                </li>

                                <%if (Session["ViewProfileUserType"].ToString() == "student")
                                    {%>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0">GPA</h6>
                                    <span class="text-secondary">
                                        <asp:Label ID="lblViewGpa" runat="server"></asp:Label>
                                    </span>
                                </li>
                                <%} %>
                            </ul>
                        </div>
                    </div>

                    <div class="col-lg-8">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="row">
                                    <h4>Class</h4>
                                </div>
                                <hr>
                                <%if (Session["ViewProfileUserType"].ToString() == "student")
                                    {%>
                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">Class</h6>
                                    </div>
                                    <div class="col-lg-9 text-secondary">
                                        <asp:Label ID="lblViewClass" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>
                                <%} %>

                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">Graduation Date</h6>
                                    </div>
                                    <div class="col-lg-9 text-secondary">
                                        <asp:Label ID="lblViewGradDate" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>

                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">Major(s)</h6>
                                    </div>
                                    <div class="col-lg-9 text-secondary">
                                        <asp:Label ID="lblViewMajor" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>

                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">Minor(s)</h6>
                                    </div>
                                    <div class="col-lg-9 text-secondary">
                                        <asp:Label ID="lblViewMinor" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>

                                <% if (Session["ViewProfileUserType"].ToString() == "member")
                                    { %>
                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">City</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <asp:Label ID="lblViewCity" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">State</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <asp:Label ID="lblViewState" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>
                                <% } %>
                            </div>
                        </div>

                        <div class="row gutters-sm">
                            <div class="col-lg-12 mb-3">
                                <div class="card h-90">
                                    <div class="card-body">
                                        <div class="row">
                                            <h4>Biography</h4>
                                            <hr>
                                            <p>
                                                <asp:Label ID="lblViewBio" runat="server"></asp:Label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- VIEW MODE ENDS -->

        <% if (Session["ViewProfileUserType"].ToString() == "member")
            { %>
        <asp:Button ID="btnRequest" runat="server" CssClass="btn btn-primary" Text="REQUEST MENTOR" Visible="false" OnClick="btnRequest_Click" />
        <asp:Label ID="lblRequestStatus" Text="" runat="server" />
        <% } %>
        <br />
    </div>
</asp:Content>
