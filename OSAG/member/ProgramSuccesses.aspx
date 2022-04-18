<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ProgramSuccesses.aspx.cs" Inherits="OSAG.member.ProgramSuccesses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col text-center pb-4">
        <h2>Total Amount in Scholarships Given: </h2>
        <asp:Label Font-Size="XX-Large" ID="lblScholarship" runat="server" Text="100"></asp:Label>
        <br />
        <br />
        <h2>Total Members: </h2>
        <asp:Label Font-Size="XX-Large" ID="lblMembers" runat="server" Text="100"></asp:Label>
        <br />
        <br />
        <h2>Total Students: </h2>
        <asp:Label Font-Size="XX-Large" ID="lblStudents" runat="server" Text="100"></asp:Label>
        <br />
        <br />
        <h2>Job Opportunities Facilitated: </h2>
        <asp:Label Font-Size="XX-Large" ID="lblJobs" runat="server" Text="100"></asp:Label>
        <br />
        <br />
        <h2>Internship Opportunities Facilitated: </h2>
        <asp:Label Font-Size="XX-Large" ID="lblInternship" runat="server" Text="100"></asp:Label>
        <br />
        <br />
        <h2>Total Mentors: </h2>
        <asp:Label Font-Size="XX-Large" ID="lblMentors" runat="server" Text="100"></asp:Label>
        <br />
        <br />
        <h2>Companies Partnered With: </h2>
        <asp:Label Font-Size="XX-Large" ID="lblCompanies" runat="server" Text="100"></asp:Label>
    </div>

</asp:Content>
