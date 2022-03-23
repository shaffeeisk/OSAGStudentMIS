<%@ Page Title="" Language="C#" MasterPageFile="~/memberTemplate.Master" AutoEventWireup="true" CodeBehind="memberHome.aspx.cs" Inherits="Lab2.memberHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:Label ID="lblAccessDenied" runat="server" Text=""></asp:Label>
    <br />
    <br />
    <asp:Button ID="btnViewMember" runat="server" Text="View my profile"
        OnClick="btnViewMember_Click" />
    <br />
    <br />
    <asp:Button ID="btnViewStudents" runat="server" Text="View Student Profiles"
        OnClick="btnViewStudents_Click" />
    <br />
    <br />
    <asp:Button ID="btnViewScholarships" runat="server" Text="View Available Scholarships"
        OnClick="btnViewScholarships_Click" />
    <br />
    <br />
    <asp:Button ID="btnViewInternships" runat="server" Text="View Available Internships"
        OnClick="btnViewInternships_Click" />
    <br />
    <br />
    <asp:Button ID="btnViewJobs" runat="server" Text="View Available Jobs" OnClick="btnViewJobs_Click" />
    <br />
    <br />
    <asp:Button ID="btnApproveRegistration" runat="server" Text="Approve New User Registration"
        OnClick="btnApproveRegistration_Click" Enabled="false" />
</asp:Content>
