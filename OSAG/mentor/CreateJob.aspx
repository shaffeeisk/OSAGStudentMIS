<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Mentor.Master" AutoEventWireup="true" CodeBehind="CreateJob.aspx.cs" Inherits="OSAG.mentor.CreateJob" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <asp:Label ID="lblJobName" runat="server" Text="Position: " Width="160px"></asp:Label>
        <input id="enterJobName" type="text" maxlength="50" runat="server" />
        <br />
        <br />
        <asp:Label ID="lblSalary" runat="server" Text="Salary: " Width="160px"></asp:Label>
        <input id="enterSalary" type="number" max="100000000" runat="server" />
        <br />
        <br />
        <asp:Label ID="lblTme" runat="server" Text="Full or Part-Time: "></asp:Label>
        <asp:DropDownList ID="ddlTime" runat="server">
            <asp:ListItem Selected="True" Text=" " Value="0"></asp:ListItem>
            <asp:ListItem Text="Full-Time"></asp:ListItem>
            <asp:ListItem Text="Part-Time"></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="lblCompany" runat="server" Text="Choose Company:"></asp:Label>
        <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="177px"
        DataSourceID="sqlsrcListCompanys"
        DataTextField="CompanyName"
        DataValueField="CompanyID"
        AppendDataBoundItems="true">
        <asp:ListItem Selected="True" Text="(Select a company)" Value=""></asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
        <asp:Button ID="btnSaveJob" Text="Save ->" runat="server" OnClick="btnSaveJob_Click" />
        <br />
        <br />
        <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click"  Font-Bold="true" BackColor="OrangeRed" />
    </div>
 <asp:SqlDataSource
        ID="sqlsrcListCompanys"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
</asp:Content>
