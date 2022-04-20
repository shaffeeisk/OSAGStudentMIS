<%--Page for approving registration--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ApproveRegistration.aspx.cs" Inherits="OSAG.admin.ApproveRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col text-center pt-5 pb-4">
            <h2>APPROVE REGISTRATIONS</h2>
        </div>
    </div>
    <div class="row pb-5">
        <div style="margin-left: auto; margin-right: auto; text-align: center; width: fit-content">
            <asp:ListBox ID="lstSelectNewUser" font="" runat="server" AutoPostBack="true" Height="200px" Width="200px"
                DataSourceID="sqlsrcNewUsers"
                DataTextField="Username"
                DataValueField="Username"
                CssClass="form-control"></asp:ListBox>
        </div>
    </div>

    <div class="row">
        <div class="col justify-content-center d-grid pt-2 pb-5">
            <asp:Button ID="btnViewProfile" class="btn btn-primary mx-auto" runat="server" Text="VIEW PROFILE" OnClick="btnViewProfile_Click" />
        </div>
    </div>

    <div class="row">
        <div class="col justify-content-center d-grid pt-2 pb-5">
            <asp:Label ID="lblStatus" runat="server" Text="" Font-Bold="true"></asp:Label>
            <asp:Button ID="btnApprove" class="btn btn-primary mx-auto" runat="server" Text="APPROVE SELECTED USER" OnClick="btnApprove_Click" />
        </div>
    </div>

    <asp:SqlDataSource
        ID="sqlsrcNewUsers"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT Username FROM Student WHERE IsApproved = 0 OR IsApproved IS NULL
         UNION SELECT Username FROM Member WHERE IsApproved = 0 OR IsAPproved IS NULL;"></asp:SqlDataSource>
</asp:Content>
