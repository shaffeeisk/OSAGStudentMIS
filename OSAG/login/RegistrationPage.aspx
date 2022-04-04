<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationPage.aspx.cs" Inherits="OSAG.login.RegistrationPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
            <asp:LinkButton ID="lnkLogin" runat="server" OnClick="lnkLogin_Click" >Login</asp:LinkButton>
            <br />
            <br />
            <strong>Create Account</strong><br />
            First Name:&nbsp;
            <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
            <br />
            <br />
            Last Name:
            <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
            <br />
            <br />
            Username:
            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
            <br />
            <br />
            Password:
            <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
            <br />
            <br />
            Email:
            <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
            <br />
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnClear" runat="server" Text="Clear Text Fields" OnClick="btnClear_Click" />
            <br />
            <br />
            <asp:Button ID="btnReturn" runat="server" Text="Return to Home Page" OnClick="btnReturn_Click"/>
        </div>
    </form>
</body>
</html>
