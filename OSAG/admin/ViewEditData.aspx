<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewEditData.aspx.cs" Inherits="OSAG.admin.ViewEditData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div class="row pt-5 pb-5">
            <div class="col text-center">
                <h2>ADVANCED ADMIN VIEW/EDIT PAGE</h2>
            </div>
        </div>

    <div style="margin-left: auto; margin-right: auto; text-align: center">
        <asp:DropDownList ID="ddlSelectTable" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSelectTable_SelectedIndexChanged">
            <asp:ListItem Text="(Select Table)" Value=""></asp:ListItem>
            <asp:ListItem Text="Members" Value="Member"></asp:ListItem>
            <asp:ListItem Text="Companies" Value="Company"></asp:ListItem>
            <asp:ListItem Text="Opportunities" Value="Opportunity"></asp:ListItem>
            <asp:ListItem Text="Internships" Value="Internship"></asp:ListItem>
            <asp:ListItem Text="Jobs" Value="Job"></asp:ListItem>
            <asp:ListItem Text="Contacts" Value="Contact"></asp:ListItem>
            <asp:ListItem Text="Students" Value="Student"></asp:ListItem>
            <asp:ListItem Text="Mentorships" Value="Mentorship"></asp:ListItem>
            <asp:ListItem Text="Majors" Value="Major"></asp:ListItem>
            <asp:ListItem Text="Announcements" Value="Announcement"></asp:ListItem>
        </asp:DropDownList>
    </div>
    <br />
    <asp:GridView ID="grdvwData" runat="server"
        HorizontalAlign="Center"
        AutoGenerateEditButton="true"
        AutoGenerateColumns="true"
        AllowPaging="true"
        AllowSorting="true"
        DataSourceID="sqlsrcData"
        OnRowDataBound="grdvwData_RowDataBound"
        EditRowStyle-Wrap="true">
    </asp:GridView>

    <div class="row pt-4" id="MemberTypeKey" runat="server" visible="false">
        <table class="table" style="table-layout: fixed; width: 140px;" align="center">
            <colgroup>
                <col style="width: 50px">
                <col style="width: 90px">
            </colgroup>
            <thead>
                <tr>
                    <th colspan="2" style="text-align:center">MEMBER KEY</th>
                </tr>
            </thead>
            <tbody style="text-align:center;">
                <tr>
                    <td><b>1</b></td>
                    <td style="text-align:left">Admin</td>
                </tr>
                <tr>
                    <td><b>2</b></td>
                    <td style="text-align:left">Leadership</td>
                </tr>
                <tr>
                    <td><b>3</b></td>
                    <td style="text-align:left">Mentor</td>
                </tr>
                <tr>
                    <td><b>4</b></td>
                    <td style="text-align:left">Member</td>
                </tr>
            </tbody>
        </table>
    </div>

    <asp:SqlDataSource ID="sqlsrcData" runat="server" ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
</asp:Content>
