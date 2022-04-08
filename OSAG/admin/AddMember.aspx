<%--Page to add new members--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AddMember.aspx.cs" Inherits="OSAG.admin.AddMember" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
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
    (Temp) Username:&nbsp
            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator 
        ID="RequiredFieldValidator1"
        ControlToValidate="txtUsername"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Button ID="btnGenerateUser" runat="server" Text="Auto-Generate Username" OnClick="btnGenerateUser_Click" CausesValidation="false" />
    <br />
    <br />
    (Temp) Password:&nbsp 
            <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator 
        ID="RequiredFieldValidator2"
        ControlToValidate="txtPassword"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Button ID="btnGeneratePass" runat="server" Text="Auto-Generate Password" OnClick="btnGeneratePass_Click" CausesValidation="false" />
    <br />
    <br />
    <asp:Button ID="btnCreate" runat="server" Text="Create Member Account" OnClick="btnCreate_Click" />
    <br />
    <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
</asp:Content>
