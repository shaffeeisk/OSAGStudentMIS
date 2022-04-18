<%--View chat page--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewChat.aspx.cs" Inherits="OSAG.profiles.ViewChat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pt-5" style="margin-left: auto; margin-right: auto; text-align: center;">
        
        <div class="container col-lg-4 text-center pb-4">
            <h2>CHAT WITH <asp:Label ID="lblChatName" runat="server"></asp:Label></h2>
        </div>

        <asp:GridView ID="grdvChat"
            runat="server"
            DataSourceID="sqlsrc"
            AllowSorting="true"
            AutoGenerateSelectButton="false"
            HorizontalAlign="Center"
            AutoGenerateColumns="false"
            CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
            PagerStyle-CssClass="pager"
            HeaderStyle-CssClass="header"
            RowStyle-CssClass="rows"
            CellPadding="25"
            CellSpacing="7"
            font="Roboto"
            ForeColor="black">
            <Columns>
                <asp:BoundField HeaderText="DateCreated" DataField="DateCreated" SortExpression="DateCreated" DataFormatString="{0:M/d/yy a\t HH:mmtt}" />
                <asp:BoundField HeaderText="Sent By" DataField="SenderName" SortExpression="SenderName" />
                <asp:BoundField HeaderText="MessageText" DataField="MessageText" SortExpression="MessageText" />
                <asp:BoundField HeaderText="IsRead" DataField="IsRead" SortExpression="IsRead" />
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        <br />
        <asp:TextBox ID="txtChatBox" TextMode="MultiLine"
            Rows="5" Height="100" Width="200" runat="server"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator1"
            ControlToValidate="txtChatBox"
            Text="(Required)"
            runat="server" />
        <div class="row">
            <div class="col justify-content-center d-grid pt-2 mx-auto">
                <asp:Button ID="btn_Send" CssClass="btn btn-primary" runat="server" Text="SEND MESSAGE" OnClick="btn_Send_Click" />
            </div>
        </div>
        <div class="row">
            <div class="col justify-content-center d-grid pt-5 mx-auto">
                <asp:Button ID="btnReturn" runat="server" Text="RETURN" CssClass="btn btn-secondary" CausesValidation="false" PostBackUrl="~/profiles/StartChat.aspx" />
            </div>
        </div>
        <asp:SqlDataSource ID="sqlsrc" runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
    </div>
</asp:Content>
