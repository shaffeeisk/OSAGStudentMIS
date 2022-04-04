<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CompleteRegistration.aspx.cs" Inherits="OSAG.login.CompleteRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Username:
            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
    <br />
    <br />
    Password:
            <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
    <br />
    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
    <br />
    <br />
    <asp:Button ID="btnContinue" runat="server" Text="Continue to profile" Visible="false" OnClick="btnContinue_Click" />
</asp:Content>
