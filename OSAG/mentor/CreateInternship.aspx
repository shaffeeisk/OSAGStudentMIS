<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Mentor.Master" AutoEventWireup="true" CodeBehind="CreateInternship.aspx.cs" Inherits="OSAG.mentor.CreateInternship" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <asp:Label ID="lblInternshipName" runat="server" Text="Internship Name: " Width="160px"></asp:Label>
        <input id="enterInternshipName" type="text" maxlength="50" runat="server" />
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
        <asp:Label ID="lblPay" runat="server" Text="Paid? "></asp:Label>
        <asp:DropDownList ID="ddlPay" runat="server">
            <asp:ListItem Selected = "True" Text = "" Value = ""></asp:ListItem>
            <asp:ListItem Text = "Yes" ></asp:ListItem>
            <asp:ListItem Text = "No" ></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Button ID="btnSaveIntern" Text="Save ->" runat="server" OnClick="btnSaveIntern_Click"  />
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
