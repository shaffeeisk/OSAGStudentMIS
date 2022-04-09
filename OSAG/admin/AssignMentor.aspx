<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AssignMentor.aspx.cs" Inherits="OSAG.admin.AssignMentor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <h2>Edit Student Data:</h2>
    <br />
    <asp:ListBox ID="lstStudents" runat="server" AutoPostBack="true" 
        DataSourceID="sqlsrcStudentList" 
        DataTextField="StudentName"
        DataValueField="StudentID"
        OnSelectedIndexChanged="lstStudents_SelectedIndexChanged" ></asp:ListBox>
    <br />
    <br />
    <asp:Label ID="lblMember" runat="server" Text="Member: "></asp:Label>
    <asp:DropDownList ID="ddlMember" runat="server" AppendDataBoundItems="true"
        DataSourceID="sqlsrcMemberList"
        DataTextField="MemberName"
        DataValueField="MemberID">
        <asp:ListItem Text=" " Value="0" />
    </asp:DropDownList>
    <br />
    <br />
    <asp:Label ID="lblUpdateStatus" Text="" runat="server" />
    <br />
    <asp:Button ID="btnUpdate" runat="server" Text="Update Student" OnClick="btnUpdate_Click" />
    <asp:SqlDataSource ID="sqlsrcMemberList" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="(SELECT MemberID, FirstName AS MemberName FROM Member WHERE LastName IS NULL)
        UNION (SELECT MemberID, LastName AS MemberName FROM Member WHERE FirstName IS NULL)
        UNION (SELECT MemberID, FirstName + ' ' + LastName AS MemberName FROM Member WHERE FirstName + LastName IS NOT NULL);" ></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsrcStudentList" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT FirstName + ' ' + LastName AS StudentName, StudentID FROM Student;" ></asp:SqlDataSource>

</asp:Content>
