<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Mentor.Master" AutoEventWireup="true" CodeBehind="CreateJob.aspx.cs" Inherits="OSAG.mentor.CreateJob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <asp:Label ID="lblJobName" runat="server" Text="Job Name: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtJobName" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Job Description: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtJobDescription" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Application Deadline: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtApplicationDeadline" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="StartDate: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Weekly Hours: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtWeeklyHours" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Payment: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtPayment" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label6" runat="server" Text="CompanyID: " Width="160px"></asp:Label>
        <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="177px"
            DataSourceID="sqlsrcListCompanys"
            DataTextField="CompanyName"
            DataValueField="CompanyID"
            AppendDataBoundItems="true">
            <asp:ListItem Selected="True" Text="(Select a company)" Value=""></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <br />
        <asp:Button ID="btnSaveJob" Text="Save ->" runat="server" OnClick="btnSaveJob_Click" />
        <br />
        <br />
        <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click" Font-Bold="true" BackColor="OrangeRed" />
    </div>
    <asp:SqlDataSource
        ID="sqlsrcListCompanys"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
</asp:Content>
