<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ListUsers.aspx.cs" Inherits="OSAG.profiles.ListUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left:auto;margin-right:auto;text-align:center;">
        <h2>Click "Select" on a User to view their profile.</h2>
        <br />
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
        <h4>Members:</h4>
        <input id="searchBar2" type="text" runat="server" />
        <asp:Button ID="btnSearchMent" runat="server" Text="Search" OnClick="btnSearchMent_Click" />
        <br />
        <br />
        <asp:GridView ID="grdvMember" runat="server"
            DataSourceID="sqlsrcMemberQuery"
            AutoGenerateSelectButton="true"
            AutoGenerateColumns="false"
            AllowPaging="true"
            DataKeyNames="Username"
            OnRowDataBound="grdvUser_RowDataBound"
            OnSelectedIndexChanged="grdvMember_SelectedIndexChanged"
            HorizontalAlign="Center"
            ShowHeaderWhenEmpty="true">
            <Columns>
                <asp:BoundField ReadOnly="true" HeaderText="Username" DataField="Username" />
                <asp:BoundField ReadOnly="true" HeaderText="First Name" DataField="FirstName" />
                <asp:BoundField ReadOnly="true" HeaderText="Last Name" DataField="LastName" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sqlsrcMemberQuery" runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"
            SelectCommand="SELECT Username, FirstName, LastName FROM Member WHERE FirstName + ' ' + LastName LIKE '%%';"></asp:SqlDataSource>
    </div>
</asp:Content>
