<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateScholarship.aspx.cs" Inherits="OSAG.member.CreateScholarship" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblAwardName" runat="server" Text="Award Name: " Width="160px"></asp:Label>
    <asp:TextBox ID="txtAwardName" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="lblAmount" runat="server" Text="Award Amount: " Width="160px"></asp:Label>
    <asp:TextBox ID="txtAmount" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="Label1" runat="server" Text="Award Description: " Width="160px"></asp:Label>
    <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="btnSaveSchol" Text="Save ->" runat="server" OnClick="btnSaveSchol_Click" />
    <br />
    <br />
    <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
    <br />
    <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click" Font-Bold="true" BackColor="OrangeRed" />
</asp:Content>
