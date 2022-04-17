<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewMentorships.aspx.cs" Inherits="OSAG.member.ViewMentorships" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="grdvwMentorships"
            runat="server"
            HorizontalAlign="Center"
            CellPadding="10"
            DataSourceID="sqlsrcMentorships"
            DataKeyNames="StudentID"
            AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Student Name" DataField="FullName" />
                <asp:BoundField HeaderText="GPA" DataField="Gpa" />
                <asp:BoundField HeaderText="Graduation Date" DataField="GradDate" DataFormatString="{0:MMMM, yyyy}"/>
            </Columns>
        </asp:GridView>
    <asp:SqlDataSource ID="sqlsrcMentorships" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
</asp:Content>
