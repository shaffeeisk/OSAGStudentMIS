<%--Start chat page--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="StartChat.aspx.cs" Inherits="OSAG.profiles.StartChat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Jobs">
        <meta name="author" content="Madison Solutions">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jobs</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

        <!-- CSS -->
        <link href="css/custom.css" rel="stylesheet" type="text/css" media="screen">

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" >
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

    </head>
        <body style="background-color:#FEFEFE;">
            <div style="margin-left: auto; margin-right: auto; text-align: center;">
                <h3>Select a User to Chat With</h3>
                <br />
                <h4>Current Chats With Students:</h4>
                <asp:GridView ID="grdvStudent"
                    runat="server"
                    DataSourceID="sqlsrcStudent"
                    AllowSorting="true"
                    AutoGenerateSelectButton="false"
                    HorizontalAlign="Center"
                    AutoGenerateColumns="false" DataKeyNames="StudentID"
                    CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
                    PagerStyle-CssClass="pager"
                    HeaderStyle-CssClass="header"
                    RowStyle-CssClass="rows"
                    CellPadding="25"
                    CellSpacing="7"
                    font="Roboto"
                    ForeColor="black">
                    <Columns>
                        <asp:BoundField HeaderText="FirstName" DataField="FirstName" SortExpression="FirstName" />
                        <asp:BoundField HeaderText="LastName" DataField="LastName" SortExpression="LastName" />
                        <asp:BoundField HeaderText="IsRead" DataField="IsRead" SortExpression="IsRead" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btn_studentChat" runat="server" Text="Chat" OnClick="btn_studentChat_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sqlsrcStudent" runat="server"
                    ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>

                <br />
                <h4>Current Chats With Members:</h4>
                <asp:GridView ID="grdvMember"
                    runat="server"
                    DataSourceID="sqlsrcMember"
                    AllowSorting="true"
                    AutoGenerateSelectButton="false"
                    HorizontalAlign="Center"
                    AutoGenerateColumns="false" DataKeyNames="MemberID"
                    CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
                    PagerStyle-CssClass="pager"
                    HeaderStyle-CssClass="header"
                    RowStyle-CssClass="rows"
                    CellPadding="25"
                    CellSpacing="7"
                    font="Roboto"
                    ForeColor="black">
                    <Columns>
                        <asp:BoundField HeaderText="FirstName" DataField="FirstName" SortExpression="FirstName" />
                        <asp:BoundField HeaderText="LastName" DataField="LastName" SortExpression="LastName" />
                        <asp:BoundField HeaderText="IsRead" DataField="IsRead" SortExpression="IsRead" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btn_memberChat" runat="server" Text="Chat" OnClick="btn_memberChat_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sqlsrcMember" runat="server"
                    ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>

                <br />
                <br />
                <div class="row">
                     <div class="col justify-content-center d-grid pt-2 pb-5">
                             <asp:Button ID="btn_newChat" class="btn btn-primary mx-auto" runat="server" Text="Start a new chat" OnClick="btn_newChat_Click" />
                     </div>
                </div>
            </div>
        </body>
    </html>
</asp:Content>
