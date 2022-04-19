<%--Displays details of selected job--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Details.Master" AutoEventWireup="true" CodeBehind="JobDetails.aspx.cs" Inherits="OSAG.jobs.JobDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container px-5 pt-5 pb-5">
        <!--Header starts-->
        <div class="row pb-3">
            <a href="Jobs.aspx" class="previous">&laquo; Back</a>

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
        </div>

        <div class="row" id="divApplyButton" runat="server" visible="false">
            <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
                <asp:LinkButton ID="lnkbtnApply" class="btn btn-primary mx-auto" runat="server" OnClick="lnkbtnApply_Click">APPLY HERE</asp:LinkButton>
            </div>
        </div>
        <div id="divDidYouApply" runat="server" visible="false">
            <div class="row">
                <div class="col justify-content-center pt-4 d-grid mx-auto">
                    <asp:Label ID="lblStatus" Text="Did you complete your application?" runat="server" />
                </div>
            </div>
            <div class="row">
                <div class="col justify-content-end d-grid pt-4 pb-3 mx-auto">
                    <asp:Button ID="btnApplied" class="btn btn-primary mx-auto" Text="YES" runat="server" OnClick="btnApplied_Click" />
                </div>
                <div class="col justify-content-start d-grid pt-4 pb-3 mx-auto">
                    <asp:Button ID="btnDidNotApply" class="btn btn-primary mx-auto" Text="NO" runat="server" OnClick="btnDidNotApply_Click" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-7 align-content-center pt-4 pb-3" style="text-align: center; margin-left: auto; margin-right: auto">
                <h4>Set Interest Level</h4>
                <h5>
                    <asp:RadioButton ID="rdoLow" Text="Low" runat="server" GroupName="InterestLevel"
                        AutoPostBack="true" OnCheckedChanged="rdoLow_CheckedChanged" />
                    <asp:RadioButton ID="rdoMed" Text="Medium" runat="server" GroupName="InterestLevel"
                        AutoPostBack="true" OnCheckedChanged="rdoMed_CheckedChanged" />
                    <asp:RadioButton ID="rdoHi" Text="High" runat="server" GroupName="InterestLevel"
                        AutoPostBack="true" OnCheckedChanged="rdoHi_CheckedChanged" /></h5>
            </div>
        </div>

        <div class="row">
            <!--Save button-->
            <div class="col justify-content-center d-grid pt-4 pb-5 mx-auto">
                <asp:Button ID="btnBookmark" class="btn btn-secondary mx-auto" runat="server" Text="BOOKMARK" OnClick="btnBookmark_Click" />
            </div>
        </div>
    </div>
    <script type="text/javascript" language="javascript">
        function Navigate(s) {
            javascript: window.open(s)
        }
    </script>
</asp:Content>
