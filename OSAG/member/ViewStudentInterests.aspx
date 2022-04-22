<%--Page for viewing student interests--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewStudentInterests.aspx.cs" Inherits="OSAG.member.ViewStudentInterests" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row pt-5 pb-5">
        <div class="col text-center">
            <h2>STUDENT INTERESTS</h2>
        </div>
    </div>

    <div class="row">
        <div class="col justify-content-center d-grid pb-4" style="margin-left: auto; margin-right: auto; text-align: center">
            <asp:DropDownList ID="ddlSelectStudent" runat="server" 
                CssClass="form-control" Width="200px" AutoPostBack="true" 
                OnSelectedIndexChanged="ddlSelectStudent_SelectedIndexChanged"
                DataSourceID="sqlsrcListStu" 
                DataTextField="Name" DataValueField="StudentID"
                AppendDataBoundItems="true">
                <asp:ListItem Text="(Select Student)" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <asp:SqlDataSource ID="sqlsrcListStu" runat="server" ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>

    <div class="row">
        <div class="col justify-content-center d-grid pb-4" style="margin-left: auto; margin-right: auto; text-align: center">
            <asp:DropDownList ID="ddlSelectTable" runat="server" CssClass="form-control" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="ddlSelectTable_SelectedIndexChanged">
                <asp:ListItem Text="(Select Table)" Value=""></asp:ListItem>
                <asp:ListItem Text="Internships" Value="Internship"></asp:ListItem>
                <asp:ListItem Text="Opportunities" Value="Opportunity"></asp:ListItem>
                <asp:ListItem Text="Jobs" Value="Job"></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>

    <div class="row">
        <asp:GridView ID="grdvwData" runat="server"
            HorizontalAlign="Center"
            AutoGenerateColumns="false"
            AllowPaging="true"
            AllowSorting="true"
            PageSize="10"
            CellPadding="5"
            SelectedRowStyle-BackColor="#eddef5" RowStyle-BorderWidth="1"
            DataSourceID="sqlsrcViewInterests" OnRowDataBound="grdvwData_RowDataBound"
            ShowHeaderWhenEmpty="true"
            EmptyDataText="Nothing to see here!" EmptyDataRowStyle-HorizontalAlign="Center">
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="4" FirstPageText="<<" LastPageText=">>" />
            <PagerStyle HorizontalAlign="Center" Font-Names="Roboto" Font-Size="Large" Font-Bold="true" ForeColor="#73637F" />
            <HeaderStyle Font-Names="Roboto" ForeColor="#320075" BorderWidth="2" BorderColor="DarkGray" HorizontalAlign="Center" />
            <RowStyle Font-Names="Roboto" HorizontalAlign="Center" />
            <Columns>
                <asp:BoundField HeaderText="Position" DataField="Name" SortExpression="Name" />
                <asp:BoundField HeaderText="Deadline" DataField="Deadline" SortExpression="Deadline" NullDisplayText="N/A" />
                <asp:BoundField HeaderText="Interest Level" DataField="IsInterest" SortExpression="IsInterest" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sqlsrcViewInterests" runat="server" ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
    </div>
</asp:Content>
