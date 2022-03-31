<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ListUsers.aspx.cs" Inherits="OSAG.profiles.ListUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Click "Select" on a User to view their profile.</h2>
    <h4>Students:</h4>
    <input id="searchBar" type="text" runat="server" />
    <asp:Button ID="btnSearchStu" runat="server" Text="Search" OnClick="btnSearchStu_Click" />
    <br />
    <br />
    <asp:GridView ID="grdvStudent" runat="server"
        DataSourceID="sqlsrcStudentQuery"
        AutoGenerateSelectButton="true"
        AutoGenerateColumns="false"
        AllowPaging="true"
        DataKeyNames="Username"
        OnRowDataBound="grdvUser_RowDataBound"
        OnSelectedIndexChanged="grdvStudent_SelectedIndexChanged"
        HorizontalAlign="Center"
        ShowHeaderWhenEmpty="true">
        <Columns>
            <asp:BoundField ReadOnly="true" HeaderText="Username" DataField="Username" />
            <asp:BoundField ReadOnly="true" HeaderText="First Name" DataField="FirstName" />
            <asp:BoundField ReadOnly="true" HeaderText="Last Name" DataField="LastName" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlsrcStudentQuery" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT Username, FirstName, LastName FROM Student WHERE FirstName + ' ' + LastName LIKE '%%';"></asp:SqlDataSource>
    <br />
    <br />
    <h4>Mentors:</h4>
    <input id="searchBar2" type="text" runat="server" />
    <asp:Button ID="btnSearchMent" runat="server" Text="Search" OnClick="btnSearchMent_Click" />
    <br />
    <br />
    <asp:GridView ID="grdvMentor" runat="server"
        DataSourceID="sqlsrcMentorQuery"
        AutoGenerateSelectButton="true"
        AutoGenerateColumns="false"
        AllowPaging="true"
        DataKeyNames="Username"
        OnRowDataBound="grdvUser_RowDataBound"
        OnSelectedIndexChanged="grdvMentor_SelectedIndexChanged"
        HorizontalAlign="Center"
        ShowHeaderWhenEmpty="true">
        <Columns>
            <asp:BoundField ReadOnly="true" HeaderText="Username" DataField="Username" />
            <asp:BoundField ReadOnly="true" HeaderText="First Name" DataField="FirstName" />
            <asp:BoundField ReadOnly="true" HeaderText="Last Name" DataField="LastName" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlsrcMentorQuery" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT Username, FirstName, LastName FROM Mentor WHERE FirstName + ' ' + LastName LIKE '%%';"></asp:SqlDataSource>
</asp:Content>
