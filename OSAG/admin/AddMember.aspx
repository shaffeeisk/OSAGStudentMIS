<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AddMember.aspx.cs" Inherits="OSAG.admin.AddMember" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <strong>Create Member Account</strong>
    <br />
    <br />
    Access Level:&nbsp
            <asp:DropDownList ID="ddlMemberType" runat="server">
                <asp:ListItem Text="Member" Value="4" />
                <asp:ListItem Text="Mentor" Value="3" />
                <asp:ListItem Text="Leadership" Value="2" />
                <asp:ListItem Text="Admin" Value="1" />
            </asp:DropDownList>
    <br />
    <br />
    First Name:&nbsp
            <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
    <br />
    <br />
    Last Name:&nbsp
            <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
    <br />
    <br />
    Email:&nbsp
            <asp:TextBox ID="txtEmail" TextMode="Email" runat="server"></asp:TextBox>
    <br />
    <br />
    Phone Number (Optional):&nbsp
            <asp:TextBox ID="txtPhone" TextMode="Phone" runat="server"></asp:TextBox>
    <br />
    <br />
    City:&nbsp
            <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
    <br />
    <br />
    State:&nbsp
            <asp:TextBox ID="txtState" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="btnCreate" runat="server" Text="Create Member Account" OnClick="btnCreate_Click" />
    <br />
    <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
</asp:Content>
