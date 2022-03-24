<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Mentor.Master" AutoEventWireup="true" CodeBehind="CreateScholarship.aspx.cs" Inherits="OSAG.mentor.CreateScholarship" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblScholName" runat="server" Text="Scholarship Name: " Width="160px"></asp:Label>
    <input id="enterScholName" type="text" maxlength="50" runat="server" />
    <br />
    <br />
    <asp:Label ID="lblAmount" runat="server" Text="Dollar Amount: " Width="160px"></asp:Label>
    <input id="enterAmount" type="number" max="2147483647" runat="server" />
    <br />
    <br />
    <asp:Button ID="btnSaveSchol" Text="Save ->" runat="server" OnClick="btnSaveSchol_Click"     />
    <br />
    <br />
    <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
    <br />
    <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click" Font-Bold="true" BackColor="OrangeRed" />
</asp:Content>
