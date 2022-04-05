<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewChat.aspx.cs" Inherits="OSAG.profiles.ViewChat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="grdvChat"
        runat="server"
        DataSourceID="sqlsrc"
        AllowSorting="true"
        AutoGenerateSelectButton="false"
        AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField HeaderText="DateCreated" DataField="DateCreated" SortExpression="DateCreated" />
            <asp:BoundField HeaderText="Sent By" DataField="SenderName" SortExpression="SenderName" />
            <asp:BoundField HeaderText="MessageText" DataField="MessageText" SortExpression="MessageText" />
            <asp:TemplateField>
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:TextBox ID="txtChatBox" TextMode="MultiLine"
        Rows="5" Height="100" Width="200" runat="server"></asp:TextBox>
    <asp:Button ID="btn_Send" runat="server" Text="Send Message" OnClick="btn_Send_Click" />
    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
</asp:Content>
