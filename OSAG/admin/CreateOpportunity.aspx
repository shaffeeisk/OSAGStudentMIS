<%--Create opportunity page--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateOpportunity.aspx.cs" Inherits="OSAG.member.CreateOpportunity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Header starts-->
    <div class="container text-center px-5 pt-5 pb-5">
        <div class="row">
            <div class="col text-center pb-4">
                <h2>CREATE OPPORTUNITIES</h2>
            </div>
        </div>
        <!--Header ends-->

        <!--Inputs starts-->
        <div class="row pt-4">
            <div class="createopps col px-5 mb-3">
                <asp:Label ID="lblOpportunityName" runat="server" Text="Opportunity Name: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtOpportunityName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator3"
                    ControlToValidate="txtOpportunityName"
                    Text="(Required)"
                    runat="server" />
            </div>

            <div class="createopps col px-5 mb-3">
                <asp:Label ID="lblDescription" runat="server" Text="Description: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator4"
                    ControlToValidate="txtDescription"
                    Text="(Required)"
                    runat="server" />
            </div>
        </div>

        <div class="row">
            <div class="createopps col px-5 mb-3">
                <asp:Label ID="lblEventDate" runat="server" Text="Event Date: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtEventDate" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox>
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
            </div>

            <div class="createjobs col px-5 mb-3">
                <asp:Label ID="lblAppDeadline" runat="server" Text="Application Deadline: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtDeadline" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox>
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
            </div>
        </div>

        <div class="row">
            <div class="col justify-content-center d-grid pt-4 pb-2 mx-auto">
                <asp:Label ID="Label6" runat="server" Text="CompanyID: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="177px"
                    DataSourceID="sqlsrcListCompanies"
                    DataTextField="CompanyName"
                    CssClass="form-control"
                    DataValueField="CompanyID"
                    AppendDataBoundItems="true">
                    <asp:ListItem Selected="True" Text="(No Company)" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <!--Inputs ends-->

        <!--buttons start-->
        <div class="row">
            <div class="col justify-content-center d-grid pt-4 pb-5 mx-auto">
                <asp:Button ID="btnSaveOpportunity" Text="SAVE" runat="server" OnClick="btnSaveOpportunity_Click" />
                <br />
                <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
                <br />
                <asp:Button ID="btnOverride" Text="YES" runat="server" OnClick="btnOverride_Click" Visible="false" />
                &nbsp
                    <asp:Button ID="btnCancel" Text="NO" runat="server" OnClick="btnCancel_Click" Visible="false" />
            </div>
        </div>
        <div>
            <asp:Button ID="btnClear" runat="server" Text="CLEAR ALL USER INPUTS" OnClick="btnClear_Click" Font-Bold="true" BackColor="OrangeRed" />
        </div>
        <!--buttons end-->

        <asp:DataList ID="dlistOpportunities" runat="server" DataSourceID="sqlsrc"
            EnableViewState="False">
            <HeaderTemplate>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Opportunity Name</th>
                            <th scope="col">Opportunity Description</th>
                            <th scope="col">Event Date</th>
                            <th scope="col">Application Deadline</th>
                        </tr>
                    </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <%# Eval("OpportunityName") %>
                <td><%# Eval("OpportunityDescription") %></td>
                <td><%# Eval("EventDate") %></td>
                <td><%# Eval("ApplicationDeadline") %></td>
                <td><a href="/login/LoginPage.aspx/?id=<%# Eval("OpportunityID") %>">Edit</a></td>
            </ItemTemplate>
        </asp:DataList>
    </div>


    <asp:SqlDataSource ID="sqlsrcListCompanies"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT OpportunityID, OpportunityName, OpportunityDescription, EventDate, ApplicationDeadline FROM Opportunity"
        UpdateCommand="UPDATE Opportunity SET OpportunityName = @OpportunityName, OpportunityDescription = @OpportunityDescription, , EventDate = @EventDate, ApplicationDeadline = @ApplicationDeadline, WHERE OpportunityID= @OpportunityID "
        DeleteCommand="DELETE from OpportunityMatch WHERE OpportunityID = @OpportunityID DELETE FROM Opportunity where OpportunityID = @OpportunityID"></asp:SqlDataSource>

</asp:Content>
