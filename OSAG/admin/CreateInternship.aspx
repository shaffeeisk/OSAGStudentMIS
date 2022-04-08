<%--Page for creating internship--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateInternship.aspx.cs" Inherits="OSAG.member.CreateInternship" %>

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
            ID="CompareValidator2"
            ControlToValidate="txtApplicationDeadline"
            Text="Use Date Format"
            Operator="DataTypeCheck"
            Type="Date"
            runat="server" />
        <br />
        <asp:Label ID="Label3" runat="server" Text="StartDate: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
        <asp:CompareValidator
            ID="CompareValidator1"
            ControlToValidate="txtStartDate"
            Text="Use Date Format"
            Operator="DataTypeCheck"
            Type="Date"
            runat="server" />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Weekly Hours: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtWeeklyHours" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Payment: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtPayment" TextMode="Number" runat="server"></asp:TextBox>
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
        <asp:Button ID="btnSaveIntern" Text="Save ->" runat="server" OnClick="btnSaveIntern_Click" />
        <br />
        <br />
        <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnOverride" Text="Yes" runat="server" OnClick="btnOverride_Click" Visible="false" />
        &nbsp
         <asp:Button ID="btnCancel" Text="No" runat="server" OnClick="btnCancel_Click" Visible="false" />
        <br />
        <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click" Font-Bold="true" BackColor="OrangeRed" />
        <asp:SqlDataSource ID="sqlsrcListCompanys"
            runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"
            SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
        <br />
        <br />
        <asp:GridView ID="grdvwInternships"
            runat="server"
            DataSourceID="sqlsrc"
            AllowSorting="true"
            AutoGenerateSelectButton="false"
            AutoGenerateColumns="false"
            DataKeyNames="InternshipID">
            <Columns>
                <asp:CommandField  ShowEditButton="true" ShowDeleteButton="true" CausesValidation="False"/>
                <asp:BoundField HeaderText="InternshipName" DataField="InternshipName" SortExpression="InternshipName" />
                <asp:BoundField HeaderText="InternshipDescription" DataField="InternshipDescription" SortExpression="InternshipDescription" />
                <asp:BoundField HeaderText="ApplicationDeadline" DataField="ApplicationDeadline" SortExpression="ApplicationDeadline" />
                <asp:BoundField HeaderText="StartDate" DataField="StartDate" SortExpression="StartDate" />
                <asp:BoundField HeaderText="WeeklyHours" DataField="WeeklyHours" SortExpression="WeeklyHours" />
                <asp:BoundField HeaderText="Payment" DataField="Payment" SortExpression="Payment" />
                <asp:TemplateField>
                    <ItemTemplate>
                        
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sqlsrc" runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"
            SelectCommand="SELECT InternshipID, InternshipName, InternshipDescription, ApplicationDeadline, StartDate, WeeklyHours, Payment FROM Internship" 
            UpdateCommand="UPDATE Internship SET InternshipName = @InternshipName, InternshipDescription = @InternshipDescription, ApplicationDeadline = @ApplicationDeadline, StartDate = @StartDate, WeeklyHours = @WeeklyHours, Payment = @Payment WHERE InternshipID=@InternshipID "
            DeleteCommand="Delete from InternshipMatch  Where InternshipID = @InternshipID Delete FROM Internship where InternshipID = @InternshipID"></asp:SqlDataSource>
    </div>
</asp:Content>
