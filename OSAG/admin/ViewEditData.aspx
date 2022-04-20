<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ViewEditData.aspx.cs" Inherits="OSAG.admin.ViewEditData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row pt-5 pb-5">
        <div class="col text-center">
            <h2>ADVANCED ADMIN VIEW/EDIT</h2>
        </div>
    </div>

    <div class="pb-3" style="margin-left: auto; margin-right: auto; text-align: center">
        <asp:DropDownList ID="ddlSelectTable" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSelectTable_SelectedIndexChanged">
            <asp:ListItem Text="(Select Table)" Value=""></asp:ListItem>
            <asp:ListItem Text="Members" Value="Member"></asp:ListItem>
            <asp:ListItem Text="Students" Value="Student"></asp:ListItem>
            <asp:ListItem Text="Companies" Value="Company"></asp:ListItem>
            <asp:ListItem Text="Contacts" Value="Contact"></asp:ListItem>
            <asp:ListItem Text="Majors" Value="Major"></asp:ListItem>
            <asp:ListItem Text="Announcements" Value="Announcement"></asp:ListItem>
        </asp:DropDownList>
    </div>

    <div class="row">
        <asp:GridView ID="grdvwData" runat="server"
            HorizontalAlign="Center"
            AutoGenerateColumns="true"
            AllowPaging="true"
            AllowSorting="true"
            DataSourceID="sqlsrcData"
            OnRowDataBound="grdvwData_RowDataBound"
            PageSize="10"
            SelectedRowStyle-BackColor="Yellow">
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="4" FirstPageText="<<" LastPageText=">>" />
            <PagerStyle HorizontalAlign="Center" Font-Names="Raleway" Font-Size="Large" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnSelect" runat="server" Text="SELECT" CssClass="btn btn-group btn-sm" CommandName="Select" />
                        <asp:Button ID="btnEdit" runat="server" Text="EDIT" CssClass="btn btn-secondary btn-sm" CommandName="Edit" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" Text="SAVE" CssClass="btn btn-primary btn-sm" CommandName="Update" />
                        <asp:Button ID="btnCancel" runat="server" Text="CANCEL" CssClass="btn btn-danger btn-sm" CommandName="Cancel" />
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <div class="row pt-3" style="text-align: center" id="DivDownloadButtons" runat="server" visible="false">
        <div class="px-3">
            <asp:Button ID="btnResume" runat="server" Text="RESUME" CssClass="btn btn-primary" OnClick="btnDownload_Click" />
            <asp:Button ID="btnTranscript" runat="server" Text="TRANSCRIPT" CssClass="btn btn-primary" OnClick="btnDownload_Click" />
            <asp:Button ID="btnEssay" runat="server" Text="ESSAY" CssClass="btn btn-primary" OnClick="btnDownload_Click" />
            <br />
            <asp:Label ID="lblError" runat="server" Font-Names="Roboto" ForeColor="Red" Font-Bold="true" Text=""></asp:Label>
        </div>
    </div>

    <div class="row pt-3" style="text-align: center" id="DivViewProfile" runat="server" visible="false">
        <div class="px-3">
            <asp:Button ID="btnViewProfile" runat="server" Text="VIEW PROFILE" CssClass="btn btn-primary" OnClick="btnViewProfile_Click" />
        </div>
    </div>

    <div class="row pt-4" id="MemberTypeKey" runat="server" visible="false">
        <table class="table" style="table-layout: fixed; width: 140px;" align="center">
            <colgroup>
                <col style="width: 50px">
                <col style="width: 90px">
            </colgroup>
            <thead>
                <tr>
                    <th colspan="2" style="text-align: center">MEMBER KEY</th>
                </tr>
            </thead>
            <tbody style="text-align: center;">
                <tr>
                    <td><b>1</b></td>
                    <td style="text-align: left">Admin</td>
                </tr>
                <tr>
                    <td><b>2</b></td>
                    <td style="text-align: left">Leadership</td>
                </tr>
                <tr>
                    <td><b>3</b></td>
                    <td style="text-align: left">Mentor</td>
                </tr>
                <tr>
                    <td><b>4</b></td>
                    <td style="text-align: left">Member</td>
                </tr>
            </tbody>
        </table>
    </div>
    <asp:SqlDataSource ID="sqlsrcData" runat="server" ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
</asp:Content>
