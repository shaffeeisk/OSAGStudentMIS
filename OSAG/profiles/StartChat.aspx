<%--Start chat page--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="StartChat.aspx.cs" Inherits="OSAG.profiles.StartChat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
</asp:Content>
