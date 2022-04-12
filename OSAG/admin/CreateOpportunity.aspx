<%--Create opportunity page--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateOpportunity.aspx.cs" Inherits="OSAG.member.CreateOpportunity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <asp:Label ID="lblOpportunityName" runat="server" Text="Opportunity Name: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtOpportunityName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator3"
            ControlToValidate="txtOpportunityName"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="lblDescription" runat="server" Text="Description: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator4"
            ControlToValidate="txtDescription"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="lblEventDate" runat="server" Text="Event Date: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtEventDate" TextMode="Date" runat="server"></asp:TextBox>
        <asp:CompareValidator
            ID="CompareValidator2"
            ControlToValidate="txtEventDate"
            Text="Use Date Format"
            Operator="DataTypeCheck"
            Type="Date"
            runat="server" />
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator2"
            ControlToValidate="txtEventDate"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="lblAppDeadline" runat="server" Text="Application Deadline: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtDeadline" TextMode="Date" runat="server"></asp:TextBox>
        <asp:CompareValidator
            ID="CompareValidator1"
            ControlToValidate="txtDeadline"
            Text="Use Date Format"
            Operator="DataTypeCheck"
            Type="Date"
            runat="server" />
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator1"
            ControlToValidate="txtDeadline"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:CheckBox ID="ckbxIsScholarship" runat="server" Text="This is a Scholarship" />
        <br />
        <asp:Label ID="lblAward" runat="server" Text="Opportunity Award: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtAward" TextMode="Number" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label6" runat="server" Text="CompanyID: " Width="160px"></asp:Label>
        <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="177px"
            DataSourceID="sqlsrcListCompanies"
            DataTextField="CompanyName"
            DataValueField="CompanyID"
            AppendDataBoundItems="true">
            <asp:ListItem Selected="True" Text="(No Company)" Value=""></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Button ID="btnSaveOpportunity" Text="Save ->" runat="server" OnClick="btnSaveOpportunity_Click" />
        <br />
        <br />
        <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnOverride" Text="Yes" runat="server" OnClick="btnOverride_Click" Visible="false" />
        &nbsp
         <asp:Button ID="btnCancel" Text="No" runat="server" OnClick="btnCancel_Click" Visible="false" />
        <br />
        <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click" Font-Bold="true" BackColor="OrangeRed" />
        <br />
        <br />
        <asp:GridView ID="grdvwOpportunities"
            runat="server"
            DataSourceID="sqlsrc"
            AllowSorting="true"
            AutoGenerateSelectButton="false"
            AutoGenerateColumns="false"
            HorizontalAlign="Center"
            DataKeyNames="OpportunityID">
            <Columns>
                <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" CausesValidation="False" />
                <asp:BoundField HeaderText="OpportunityName" DataField="OpportunityName" SortExpression="OpportunityName" />
                <asp:BoundField HeaderText="OpportunityDescription" DataField="OpportunityDescription" SortExpression="OpportunityDescription" />
                <asp:BoundField HeaderText="EventDate" DataField="EventDate" SortExpression="EventDate" />
                <asp:BoundField HeaderText="ApplicationDeadline" DataField="ApplicationDeadline" SortExpression="ApplicationDeadline" />
                <asp:BoundField HeaderText="IsScholarship" DataField="IsScholarship" SortExpression="IsScholarship" />
                <asp:BoundField HeaderText="OpportunityAward" DataField="OpportunityAward" SortExpression="OpportunityAward" />
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sqlsrcListCompanies"
            runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"
            SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlsrc" runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"
            SelectCommand="SELECT OpportunityID, OpportunityName, OpportunityDescription, EventDate, ApplicationDeadline, IsScholarship, OpportunityAward FROM Opportunity"
            UpdateCommand="UPDATE Opportunity SET OpportunityName = @OpportunityName, OpportunityDescription = @OpportunityDescription, , EventDate = @EventDate, ApplicationDeadline = @ApplicationDeadline, IsScholarship = @IsScholarship, OpportunityAward = @OpportunityAward WHERE OpportunityID= @OpportunityID "
            DeleteCommand="DELETE from OpportunityMatch WHERE OpportunityID = @OpportunityID DELETE FROM Opportunity where OpportunityID = @OpportunityID"></asp:SqlDataSource>
    </div>
</asp:Content>
