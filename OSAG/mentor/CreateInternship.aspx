<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateInternship.aspx.cs" Inherits="OSAG.mentor.CreateInternship" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <asp:Label ID="lblInternshipName" runat="server" Text="Internship Name: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtInternshipName" runat="server"></asp:TextBox>
         <asp:RequiredFieldValidator
        ID="RequiredFieldValidator1"
        ControlToValidate="txtInternshipName"
        Text="(Required)"
        runat="server" />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Internship Description: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtInternshipDescription" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Application Deadline: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtApplicationDeadline" runat="server"></asp:TextBox>
         <asp:CompareValidator
                id="CompareValidator2"
                ControlToValidate="txtApplicationDeadline"
                Text="Use Date Format"
                Operator="DataTypeCheck"
                Type="Date"
                Runat="server" />
        <br />
        <asp:Label ID="Label3" runat="server" Text="StartDate: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
         <asp:CompareValidator
                id="CompareValidator1"
                ControlToValidate="txtStartDate"
                Text="Use Date Format"
                Operator="DataTypeCheck"
                Type="Date"
                Runat="server" />
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
        <asp:Button ID="btnSaveIntern" Text="Save ->" runat="server" OnClick="btnSaveIntern_Click"  />
        <br />
        <br />
        <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click"  Font-Bold="true" BackColor="OrangeRed" />
         <asp:SqlDataSource
        ID="sqlsrcListCompanys"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
    </div>
</asp:Content>
