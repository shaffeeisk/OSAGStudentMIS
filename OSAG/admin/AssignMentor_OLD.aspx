<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AssignMentor_OLD.aspx.cs" Inherits="OSAG.admin.AssignMentor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <h2>Edit Student Data:</h2>
    <br />
    <asp:Label ID="lblFirstName" runat="server" Text="First Name: "></asp:Label>
    <asp:Label ID="lblFN" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblLastName" runat="server" Text="Last Name: "></asp:Label>
    <asp:Label ID="lblLN" runat="server" Text=""></asp:Label>
    <br />
    <br />
    <asp:Label ID="lblMentor" runat="server" Text="Mentor: "></asp:Label>
    <asp:DropDownList ID="ddlMentor" runat="server" AppendDataBoundItems="true"
        DataSourceID="sqlsrcMentorList"
        DataTextField="MentorName"
        DataValueField="MentorID">
        <asp:ListItem Text=" " Value="0" />
    </asp:DropDownList>
    <br />
    <br />
    <asp:Label ID="lblUpdateStatus" Text="" runat="server" />
    <br />
    <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" OnClick="btnUpdate_Click" />
    <br />
    <br />
    <asp:Button ID="btnReturn" runat="server" Text="Go Back" OnClick="btnBack_Click" />
    <asp:SqlDataSource ID="sqlsrcMentorList" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="(SELECT MentorID, FirstName AS MentorName FROM Mentor WHERE LastName IS NULL)
        UNION (SELECT MentorID, LastName AS MentorName FROM Mentor WHERE FirstName IS NULL)
        UNION (SELECT MentorID, FirstName + ' ' + LastName AS MentorName FROM Mentor WHERE FirstName + LastName IS NOT NULL);" ></asp:SqlDataSource>
</asp:Content>
