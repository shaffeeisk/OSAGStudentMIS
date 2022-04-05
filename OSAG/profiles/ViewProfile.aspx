<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewProfile.aspx.cs" Inherits="OSAG.profiles.ViewProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <br />
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <% if (Session["ViewProfileUserType"].ToString() == "student")
            { %>
        <asp:Label ID="Label1" runat="server" Text="FirstName"></asp:Label>
        <asp:TextBox ID="txtFirstName" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="LastName"></asp:Label>
        <asp:TextBox ID="txtLastName" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Email"></asp:Label>
        <asp:TextBox ID="txtEmail" runat="server" Enabled="false" AutoCompleteType="Email"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="GradDate"></asp:Label>
        <asp:TextBox ID="txtGradDate" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label6" runat="server" Text="Major"></asp:Label>
        <asp:TextBox ID="txtMajor" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <br />
        <asp:Literal ID="ltEmbed" runat="server" />
        <% } %>

        <% if (Session["ViewProfileUserType"].ToString() == "member")
            { %>
        <asp:Label ID="lblFirstName" runat="server" Text="FirstName"></asp:Label>
        <asp:TextBox ID="mtxtFirstName" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="lblLastName" runat="server" Text="   LastName"></asp:Label>
        <asp:TextBox ID="mtxtLastName" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="lblMemberEmail" runat="server" Text="MemberEmail"></asp:Label>
        <asp:TextBox ID="txtMemberEmail" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="lblState" runat="server" Text="MemberState"></asp:Label>
        <asp:TextBox ID="txtState" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="lblCity" runat="server" Text="MemberCity"></asp:Label>
        <asp:TextBox ID="txtCity" runat="server" Enabled="false"></asp:TextBox>

        <% } %>
        <br />
        <br />
        <asp:Button ID="btnReturn" runat="server" Text="Return to User List" OnClick="btnReturn_Click" />
    </div>
</asp:Content>
