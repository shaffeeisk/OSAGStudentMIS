<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Student.Master" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="OSAG.profiles.StudentProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div style="overflow: auto; width: auto">
        <asp:Table Style="margin: 0 auto" ID="tblInstanceStudents" runat="server" GridLines="Both" CellPadding="4" CellSpacing="3">
            <asp:TableHeaderRow>
                <asp:TableHeaderCell Text="Name"></asp:TableHeaderCell>
                <asp:TableHeaderCell Text="Student Email"></asp:TableHeaderCell>
                <asp:TableHeaderCell Text="Graduation Date"></asp:TableHeaderCell>
                <asp:TableHeaderCell Text="Mentor"></asp:TableHeaderCell>
                <asp:TableHeaderCell Text="Mentor Email"></asp:TableHeaderCell>
                <asp:TableHeaderCell Text="Employer"></asp:TableHeaderCell>
            </asp:TableHeaderRow>
        </asp:Table>
        <br />
        <br />
        <asp:Button ID="btnEdit" runat="server" Text="Edit Profile" OnClick="btnEdit_Click"   />
    </div>
    <asp:SqlDataSource ID="sqlsrcStudentQuery" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand=""></asp:SqlDataSource>
</asp:Content>
