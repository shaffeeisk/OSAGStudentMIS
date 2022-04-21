<%--Start chat page--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="StartChat.aspx.cs" Inherits="OSAG.profiles.StartChat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pt-5" style="margin-left: auto; margin-right: auto; text-align: center;">
        <h3>SELECT USER TO CHAT WITH</h3>
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
                <asp:BoundField HeaderText="Status" DataField="Status" SortExpression="Status" />
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
                <asp:BoundField HeaderText="Status" DataField="Status" SortExpression="Status" />
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
            <div class="col justify-content-center d-grid pt-3 pb-5 mx-auto">
                <asp:Button ID="btn_newChat" class="btn btn-primary mx-auto" runat="server" Text="START A NEW CHAT" OnClick="btn_newChat_Click" />
            </div>
        </div>
    </div>
</asp:Content>
