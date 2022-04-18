<%--List Users Page--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ListUsers.aspx.cs" Inherits="OSAG.profiles.ListUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Ole School User Search</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        body {
            width: 100%;
            margin: 5px;
        }

        .table-condensed tr th {
            border: 0px solid #6e7bd9;
            color: white;
            background-color: #6e7bd9;
        }

        .table-condensed, .table-condensed tr td {
            border: 0px solid #000;
        }

        tr:nth-child(even) {
            background: #f8f7ff
        }

        tr:nth-child(odd) {
            background: #fff;
        }
    </style>
    <div class="pt-5" style="margin-left: auto; margin-right: auto; text-align: center;">
        <h2>VIEW USER PROFILES</h2>
        <br />
        <div class="container">
            <div class="row">
                <div class="col-xs-6 col-sm-6 col-md-6">
                    <h4>STUDENTS:</h4>
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
                        ShowHeaderWhenEmpty="true"
                        CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
                        PagerStyle-CssClass="pager"
                        HeaderStyle-CssClass="header"
                        RowStyle-CssClass="rows"
                        CellPadding="25"
                        CellSpacing="7"
                        font="Roboto"
                        ForeColor="black">
                        <Columns>
                            <asp:BoundField ReadOnly="true" HeaderText="Username" DataField="Username" />
                            <asp:BoundField ReadOnly="true" HeaderText="First Name" DataField="FirstName" />
                            <asp:BoundField ReadOnly="true" HeaderText="Last Name" DataField="LastName" />
                        </Columns>
                    </asp:GridView>

                </div>
                <div class="col-xs-6 col-sm-6 col-md-6">
                    <h4>MEMBERS:</h4>
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
                        ShowHeaderWhenEmpty="true"
                        CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
                        PagerStyle-CssClass="pager"
                        HeaderStyle-CssClass="header"
                        RowStyle-CssClass="rows"
                        CellPadding="25"
                        CellSpacing="7"
                        font="Roboto"
                        ForeColor="black">
                        <Columns>
                            <asp:BoundField ReadOnly="true" HeaderText="Username" DataField="Username" />
                            <asp:BoundField ReadOnly="true" HeaderText="First Name" DataField="FirstName" />
                            <asp:BoundField ReadOnly="true" HeaderText="Last Name" DataField="LastName" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="sqlsrcStudentQuery" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT Username, FirstName, LastName FROM Student WHERE IsApproved = '1' AND FirstName + ' ' + LastName LIKE '%%';"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlsrcMemberQuery" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT Username, FirstName, LastName FROM Member WHERE IsApproved = '1' AND FirstName + ' ' + LastName LIKE '%%';"></asp:SqlDataSource>

</asp:Content>
