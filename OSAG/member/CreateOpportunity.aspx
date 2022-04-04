<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateOpportunity.aspx.cs" Inherits="OSAG.member.CreateOpportunity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblAwardName" runat="server" Text="Award Name: " Width="160px"></asp:Label>
    <asp:TextBox ID="txtAwardName" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="lblAmount" runat="server" Text="Award Amount: " Width="160px"></asp:Label>
    <asp:TextBox ID="txtAmount" TextMode="Number" runat="server"></asp:TextBox>
    
    <br />
    <asp:Label ID="Label1" runat="server" Text="Award Description: " Width="160px"></asp:Label>
    <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="btnSaveOpportunity" Text="Save ->" runat="server" OnClick="btnSaveOpportunity_Click" />
    <br />
    <br />
    <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
    <br />
    <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click" Font-Bold="true" BackColor="OrangeRed" />
</asp:Content>
