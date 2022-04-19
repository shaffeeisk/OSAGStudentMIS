<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewAnnouncements.aspx.cs" Inherits="OSAG.profiles.ViewAnnouncements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-lg-4 text-center pb-4 pt-5">
        <h2>ANNOUNCEMENTS</h2>
    </div>

    <asp:GridView ID="gv_Announcements" runat="server"
        DataSourceID="sqlsrcAnnouncements"
        AutoGenerateColumns="false"
        AllowPaging="true"
        CellPadding="25"
        DataKeyNames="AnnouncementID"
        HorizontalAlign="Center"
        ShowHeaderWhenEmpty="true"
        CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
        PagerStyle-CssClass="pager"
        HeaderStyle-CssClass="header"
        RowStyle-CssClass="rows"
        CellSpacing="7"
        font="Roboto"
        ForeColor="black">
        <Columns>
            <asp:BoundField ReadOnly="true" HeaderText="Sent" DataField="DateCreated" DataFormatString="{0:MM/dd/yyyy HH:mm tt}" ItemStyle-Wrap="true" ItemStyle-Width="110" />
            <asp:BoundField ReadOnly="true" HeaderText="Subject" DataField="Header" ItemStyle-Font-Bold="true" />
            <asp:BoundField ReadOnly="true" HeaderText="Details" DataField="Body" />
            <asp:HyperLinkField HeaderText="Link" DataNavigateUrlFields="Link" DataTextField="Link" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlsrcAnnouncements" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
</asp:Content>
