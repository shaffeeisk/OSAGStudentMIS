<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Mentor.Master" AutoEventWireup="true" CodeBehind="ApproveRegistration.aspx.cs" Inherits="OSAG.admin.ApproveRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ListBox ID="lstSelectNewUser" runat="server" AutoPostBack="true" Height="200px" Width="200px"
        DataSourceID="sqlsrcNewUsers"
        DataTextField="Username"
        DataValueField="Username"></asp:ListBox>
    <br />
    <br />
    <asp:Label ID="lblStatus" runat="server" Text="" Font-Bold="true"></asp:Label>
    <asp:Button ID="btnApprove" runat="server" Text="Approve Selected User ->" OnClick="btnApprove_Click" />
    <asp:SqlDataSource
        ID="sqlsrcNewUsers"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT Username FROM Student WHERE IsApproved = 0
         UNION SELECT Username FROM Mentor WHERE IsApproved = 0;"></asp:SqlDataSource>
</asp:Content>
