<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="OSAG.homepages.HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <asp:Label ID="lblTitle" runat="server" Text="Wecome to DukeGroup!" Font-Size="X-Large" BorderStyle="None"></asp:Label>
        <br />
        <asp:Label ID="lblMotto" runat="server" Text="Relate - Elevate - Celebrate!" BorderStyle="None"></asp:Label>
    </div>
    <br />
    <asp:Label ID="lblStatus" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
    <br />
    <h3><b>New Users:</b></h3>
    <asp:Button ID="btnMemberRegistration" runat="server" Text="Member Registration ->" OnClick="btnMemberRegistration_Click" Font-Size="Medium" />
    <br />
    <br />
    <asp:Button ID="btnStudentRegistration" runat="server" Text="Student Registration ->" OnClick="btnStudentRegistration_Click" Font-Size="Medium" />
    <br />
    <br />
    <h3><b>Existing Users:</b></h3>
    <asp:Button ID="btnLogIn" runat="server" Text="Log In ->" OnClick="btnLogIn_Click" Font-Size="Medium" />
</asp:Content>
