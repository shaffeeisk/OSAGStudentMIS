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
                <h5>INTERNSHIP</h5>
                <h1>
                    <asp:Label ID="lblName" runat="server" Text=""></asp:Label></h1>
                <h3>
                    <asp:Label ID="lblCompany" runat="server" Text=""></asp:Label></h3>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6 offset-lg-3 pt-4">
                <h3>INTERNSHIP DETAILS</h3>

                <h5>
                    <asp:Label ID="lblDeadline" runat="server" Text=""></asp:Label></h5>
                <h5>
                    <asp:Label ID="lblStart" runat="server" Text=""></asp:Label></h5>
                <h5>
                    <asp:Label ID="lblHours" runat="server" Text=""></asp:Label></h5>
                <h5>
                    <asp:Label ID="lblPayment" runat="server" Text=""></asp:Label></h5>

            </div>


        </div>

        <div class="row">
            <div class="col-lg-7 offset-lg-3 pt-4 pb-3">
                <h3>INTERNSHIP DESCRIPTION</h3>
                <h5>

                    <asp:Label ID="lblDescription" runat="server" Text=""></asp:Label></h5>
            </div>

            <h5>Set Interest Level</h5>
            <asp:RadioButton ID="rdoLow" Text="Low" runat="server" GroupName="InterestLevel"
                AutoPostBack="true" OnCheckedChanged="rdoLow_CheckedChanged" />
            <asp:RadioButton ID="rdoMed" Text="Medium" runat="server" GroupName="InterestLevel"
                AutoPostBack="true" OnCheckedChanged="rdoMed_CheckedChanged" />
            <asp:RadioButton ID="rdoHi" Text="High" runat="server" GroupName="InterestLevel"
                AutoPostBack="true" OnCheckedChanged="rdoHi_CheckedChanged" />

            <div class="row">
                <!--Save button-->
                <div class="col justify-content-center d-grid pt-4 pb-5 mx-auto">
                    <asp:Button ID="btnBookmark" class="btn btn-primary mx-auto" runat="server" Text="Add Bookmark" OnClick="btnBookmark_Click" />
                </div>
            </div>
            <div class="col-lg-8">
                <div class="row">
                    <div style="text-align: left">
                        <div class="col-lg-6 offset-lg-3 pb-3">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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

    <script type="text/javascript" language="javascript">
        function Navigate(s) {
            javascript: window.open(s)
        }
    </script>
</asp:Content>
