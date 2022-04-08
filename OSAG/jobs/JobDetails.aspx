<%--Displays details of selected job--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Details.Master" AutoEventWireup="true" CodeBehind="JobDetails.aspx.cs" Inherits="OSAG.jobs.JobDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="btnBack" runat="server" Text="<--Back" OnClick="btnBack_Click" />
    <br />
    <br />
    <asp:Label ID="lblDetails" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails1" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails2" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails3" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails4" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails5" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails6" runat="server" Text=""></asp:Label>

</asp:Content>
