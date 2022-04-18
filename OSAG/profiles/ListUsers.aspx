<%--List Users Page--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ListUsers.aspx.cs" Inherits="OSAG.profiles.ListUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jobs</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <!-- CSS -->
    <link href="css/custom.css" rel="stylesheet" type="text/css" media="screen">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@500&family=Roboto:wght@300&display=swap" rel="stylesheet">

    <!-- Icons -->
    <script src="https://kit.fontawesome.com/b51d9e9335.js" crossorigin="anonymous"></script>
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <link href="bootstrap.min.css" rel="stylesheet" />
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
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
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
