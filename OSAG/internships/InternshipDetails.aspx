<%--Displays details of selected internship--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="InternshipDetails.aspx.cs" Inherits="OSAG.internships.InternshipDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container px-5 pt-5 pb-5">
        <!--Header starts-->

        <div class="row pb-3">
            <a href="Internships.aspx" class="previous">&laquo; Back</a>

        </div>

        <div class="row">
            <div class="col-lg-6 offset-lg-3 pb-3">
                <h5>Internship</h5>
                <h1>COB CISE Fair</h1>

            </div>
        </div>

        <div class="row">
            <div class="col-lg-6 offset-lg-3 pt-4">
                <h3>EVENT DETAILS</h3>

                <h5>Date: October 12, 2022</h5>
                <h5>Time: 1:00pm</h5>


            </div>


        </div>

        <div class="row">
            <div class="col-lg-7 offset-lg-3 pt-4 pb-3">
                <h3>EVENT DESCRIPTION</h3>
                <h5>Hosted by the JMU University Career Center and The College of Integrated Science and Engineering (CISE), the CISE Career and Internship Fair is open to all CISE majors and related majors in the College of Business (CoB).
                    <br>
                    <br>
                    In this career fair, many employers and organizations are specifically looking to hire JMU Biotechnology, Computer Science, Engineering, Geography, Integrated Science and Technology, Intelligence Analysis, and Computer Information Systems (CoB).</h5>
            </div>



            <div class="row">
                <!--Save button-->
                <div class="col justify-content-center d-grid pt-4 pb-5 mx-auto">
                    <button type="button" class="btn btn-primary">REMOVE BOOKMARK</button>
                </div>
            </div>

            <div class="row">
                <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
                    <asp:Button ID="btnBack" class="btn btn-primary mx-auto" runat="server" OnClick="btnBack_Click" Text="Back to Internships" />
                </div>
            </div>
            <div class="col-lg-8">
                <div class="row">
                    <div style="text-align: left">
                        <div class="col-lg-6 offset-lg-3 pb-3">
                            <h1>
                                <asp:Label ID="lblDetails" runat="server" Text=""></asp:Label></h1>
                            <h3>
                                <asp:Label ID="lblDetails1" runat="server" Text=""></asp:Label></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="col-lg-8">
        <div class="row">
            <div style="text-align: left">
                <div class="col-lg-6 offset-lg-3 pt-4">
                    <h3>JOB DETAILS</h3>
                    <h5>
                        <asp:Label ID="lblDetails2" runat="server" Text=""></asp:Label></h5>
                    <h5>
                        <asp:Label ID="lblDetails3" runat="server" Text=""></asp:Label></h5>
                    <h5>
                        <asp:Label ID="lblDetails4" runat="server" Text=""></asp:Label>
                    </h5>
                    <h5>
                        <asp:Label ID="lblDetails5" runat="server" Text=""></asp:Label></h5>
                    <h5>
                        <asp:Label ID="lblDetails6" runat="server" Text=""></asp:Label></h5>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
            <asp:LinkButton ID="lnkbtnApply" class="btn btn-primary mx-auto" runat="server" Visible="false" OnClick="lnkbtnApply_Click">Apply Here</asp:LinkButton>
        </div>
    </div>
    <br />
    <asp:Label ID="lblStatus" Text="Did you complete your application?" runat="server" Visible="false" />
    <br />
    <div class="row">
        <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
            <asp:Button ID="btnApplied" class="btn btn-primary mx-auto" Text="Yes!" runat="server" Visible="false" OnClick="btnApplied_Click" />
        </div>
    </div>

    <div class="row">
        <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
            &nbsp
             <asp:Button ID="btnDidNotApply" class="btn btn-primary mx-auto" Text="No!" runat="server" Visible="false" OnClick="btnDidNotApply_Click" />
        </div>
    </div>


    <%if (Session["UserType"].ToString() == "student")
        { %>

    <div class="col-lg-8">
        <div class="mb-3">
            <div class="row">
                <div style="text-align: center;">
                    <div class="col-lg-6 offset-lg-3 pt-4">
                        <h5>Set Interest Level</h5>
                        <asp:RadioButton ID="rdoLow" Text="Low" runat="server" GroupName="InterestLevel"
                            AutoPostBack="true" OnCheckedChanged="rdoLow_CheckedChanged" />
                        <asp:RadioButton ID="rdoMed" Text="Medium" runat="server" GroupName="InterestLevel"
                            AutoPostBack="true" OnCheckedChanged="rdoMed_CheckedChanged" />
                        <asp:RadioButton ID="rdoHi" Text="High" runat="server" GroupName="InterestLevel"
                            AutoPostBack="true" OnCheckedChanged="rdoHi_CheckedChanged" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div class="row">
        <div style="text-align: center">
            <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
                <asp:Button ID="btnBookmark" class="btn btn-primary mx-auto" runat="server" Text="Add Bookmark" OnClick="btnBookmark_Click" />
            </div>
        </div>
    </div>
    <%} %>
    <script type="text/javascript" language="javascript">
        function Navigate(s) {
            javascript: window.open(s)
        }
    </script>
</asp:Content>
