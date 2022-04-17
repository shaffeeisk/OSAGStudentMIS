<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewAnnouncements.aspx.cs" Inherits="OSAG.profiles.ViewAnnouncements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblTest" runat="server" ></asp:Label>
    <asp:GridView ID="gv_Announcements" runat="server"
            DataSourceID="sqlsrcAnnouncements"
            AutoGenerateColumns="false"
            AllowPaging="true"
            DataKeyNames="AnnouncementID"
            HorizontalAlign="Center"
            ShowHeaderWhenEmpty="true">
            <Columns>
                <asp:BoundField ReadOnly="true" HeaderText="Sent" DataField="DateCreated" DataFormatString="{0:G}" />
                <asp:BoundField ReadOnly="true" HeaderText="Header" DataField="Header" />
                <asp:BoundField ReadOnly="true" HeaderText="Body" DataField="Body" />
                <asp:HyperLinkField  HeaderText="Link" DataNavigateUrlFields="Link" DataTextField="Link" />
            </Columns>
        </asp:GridView>
    <asp:SqlDataSource ID="sqlsrcAnnouncements" runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
</asp:Content>
