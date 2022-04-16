<%--View profile page--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewProfile.aspx.cs" Inherits="OSAG.profiles.ViewProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <br />
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <asp:Image ID="imgProfile" runat="server" Height="100px" Width="100px" CssClass="img-thumbnail" />
        <br />
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
        <asp:Label ID="Label6" runat="server" Text="Majors"></asp:Label>
        <asp:TextBox ID="txtMajor" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Minors"></asp:Label>
        <asp:TextBox ID="txtMinor" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label13" runat="server" Text="Phone"></asp:Label>
        <asp:TextBox ID="txtPhone" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label14" runat="server" Text="Class"></asp:Label>
        <asp:TextBox ID="txtClass" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label15" runat="server" Text="GPA"></asp:Label>
        <asp:TextBox ID="txtGPA" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label16" runat="server" Text="Bio"></asp:Label>
        <asp:TextBox ID="txtBio" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnDownloadResume" runat="server" Text="View Resume" OnClick="btnDownloadResume_Click" />
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
        <br />
        <asp:Label ID="Label7" runat="server" Text="Majors"></asp:Label>
        <asp:TextBox ID="txtMemberMajors" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label8" runat="server" Text="Minors"></asp:Label>
        <asp:TextBox ID="txtMemberMinors" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label9" runat="server" Text="Phone"></asp:Label>
        <asp:TextBox ID="txtMemberPhone" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label10" runat="server" Text="Graduation Date"></asp:Label>
        <asp:TextBox ID="txtMemberGradDate" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label11" runat="server" Text="Position Title"></asp:Label>
        <asp:TextBox ID="txtPositionTitle" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Label ID="Label12" runat="server" Text="Bio"></asp:Label>
        <asp:TextBox ID="txtMemberBio" runat="server" Enabled="false"></asp:TextBox>
        <br />
        <asp:Button ID="btnRequest" runat="server" Text="Request Mentor" Visible="false" OnClick="btnRequest_Click" />
        <asp:Label ID="lblRequestStatus" Text="" runat="server" />

        <% } %>
        <br />
        <br />
        <asp:Button ID="btnReturn" runat="server" Text="Return to User List" OnClick="btnReturn_Click" />
    </div>
</asp:Content>
