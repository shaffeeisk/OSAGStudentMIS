<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewMentorships.aspx.cs" Inherits="OSAG.member.ViewMentorships" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="row pt-5 pb-5">
        <div class="col text-center">
            <h2>MY MENTORSHIPS</h2>
        </div>
    </div>
    
    <asp:GridView ID="grdvwMentorships"
        runat="server"
        HorizontalAlign="Center"
        CellPadding="10"
        DataSourceID="sqlsrcMentorships"
        DataKeyNames="StudentID"
        AutoGenerateColumns="false"
        AllowPaging="true"
        AllowSorting="true"
        PageSize="10"
        SelectedRowStyle-BackColor="#eddef5" RowStyle-BorderWidth="1">
        <PagerSettings Mode="NumericFirstLast" PageButtonCount="4" FirstPageText="<<" LastPageText=">>" />
        <PagerStyle HorizontalAlign="Center" Font-Names="Roboto" Font-Size="Large" Font-Bold="true" ForeColor="#73637F" />
        <HeaderStyle Font-Names="Roboto" ForeColor="#320075" BorderWidth="2" BorderColor="DarkGray" HorizontalAlign="Center" />
        <RowStyle Font-Names="Roboto" HorizontalAlign="Center" />
        <Columns>
            <asp:BoundField HeaderText="Student Name" DataField="FullName" />
            <asp:BoundField HeaderText="GPA" DataField="Gpa" />
            <asp:BoundField HeaderText="Graduation Date" DataField="GradDate" DataFormatString="{0:MMMM, yyyy}" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlsrcMentorships" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
</asp:Content>
