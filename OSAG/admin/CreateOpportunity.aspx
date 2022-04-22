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
                    runat="server" ForeColor="Red" />
            </div>

            <div class="createopps col px-5 mb-3">
                <asp:Label ID="lblDescription" runat="server" Text="Description: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator4"
                    ControlToValidate="txtDescription"
                    Text="(Required)"
                    runat="server" ForeColor="Red" />
            </div>
        </div>

        <div class="row">
            <div class="createopps col px-5 mb-3">
                <asp:Label ID="lblEventDate" runat="server" Text="Event Date: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtEventDate" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator2"
                    ControlToValidate="txtEventDate"
                    Text="(Required)"
                    runat="server" ForeColor="Red" />
            </div>

            <div class="createjobs col px-5 mb-3">
                <asp:Label ID="lblAppDeadline" runat="server" Text="Application Deadline: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtDeadline" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1"
                    ControlToValidate="txtDeadline"
                    Text="(Required)"
                    runat="server" ForeColor="Red" />
            </div>
        </div>

        <div class="row">
            <div class="col justify-content-center d-grid pt-4 pb-2 mx-auto">
                <asp:Label ID="lblCompany" runat="server" Text="Company: " CssClass="form-label"></asp:Label>
                <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="400px"
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

        <!--butttons start-->
        <div class="row">
            <div class="col justify-content-center d-grid pt-4 mx-auto">
                <asp:Label ID="lblSuccess" CssClass="form-label" Font-Bold="true" runat="server" />
            </div>
        </div>
        
        <div class="row">
            <div class="col justify-content-center d-grid pt-1 mx-auto">
                <asp:Button ID="btnSaveOpportunity" Text="SAVE" CssClass="btn btn-primary" runat="server" OnClick="btnSaveOpportunity_Click" />
            </div>
        </div>

        <div class="row">
            <div class="col justify-content-end d-grid pb-4 mx-auto">
                <asp:Button ID="btnOverride" Text="YES" runat="server" CssClass="btn btn-primary justify-content-center" Width="110px" OnClick="btnOverride_Click" Visible="false" />
            </div>
            <div class="col justify-content-lg-start d-grid pb-4 mx-auto">
                <asp:Button ID="btnCancel" Text="NO" runat="server" CssClass="btn btn-secondary" Width="110px" OnClick="btnCancel_Click" Visible="false" />
            </div>
        </div>
        <div class="row">
            <div class="col justify-content-center d-grid pb-4 mx-auto" style="width: auto">
                <asp:Button ID="btnClear" runat="server" Text="CLEAR ALL INPUTS" CssClass="btn btn-secondary btn-danger" Width="200px" OnClick="btnClear_Click" />
            </div>
        </div>
        <!--buttons end-->

        <asp:DataList ID="dlistOpportunities" runat="server" DataSourceID="sqlsrc"
            EnableViewState="False" HorizontalAlign="Center">
            <HeaderTemplate>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Opportunity Name</th>
                            <th scope="col">Company</th>
                            <th scope="col">Event Date</th>
                            <th scope="col">Application Deadline</th>
                        </tr>
                    </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <%try
                    { %>
                <%# Eval("OpportunityName") %>
                <td><%# (Eval("CompanyName").ToString() == "" ? "N/A" : Eval("CompanyName")) %></td>
                <td><%# Eval("EventDate").ToString() == "" ? "N/A" : String.Format("{0:M/d/yyyy}", Eval("EventDate")) %></td>
                <td><%# Eval("ApplicationDeadline").ToString() == "" ? "N/A" : String.Format("{0:M/d/yyyy}", Eval("ApplicationDeadline")) %></td>
                <td><a href="/opportunities/OpportunityDetails.aspx?id=<%# Eval("OpportunityID") %>">Edit</a></td>
                <%}
                    catch (Exception ex)
                    {
                        throw ex;
                    } %>
            </ItemTemplate>
        </asp:DataList>
    </div>


    <asp:SqlDataSource ID="sqlsrcListCompanies"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT OpportunityID, OpportunityName, OpportunityDescription, EventDate, ApplicationDeadline, CompanyName FROM Opportunity o LEFT JOIN Company c ON o.CompanyID = c.CompanyID;"
        UpdateCommand="UPDATE Opportunity SET OpportunityName = @OpportunityName, OpportunityDescription = @OpportunityDescription, , EventDate = @EventDate, ApplicationDeadline = @ApplicationDeadline, WHERE OpportunityID= @OpportunityID "
        DeleteCommand="DELETE from OpportunityMatch WHERE OpportunityID = @OpportunityID DELETE FROM Opportunity where OpportunityID = @OpportunityID"></asp:SqlDataSource>

</asp:Content>
