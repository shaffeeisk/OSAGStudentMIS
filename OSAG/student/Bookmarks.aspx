<%--bookmarks page--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="Bookmarks.aspx.cs" Inherits="OSAG.student.Bookmarks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left:auto;margin-right:auto;text-align:center;">
    <h3>Bookmarked Jobs:</h3>
    <asp:GridView ID="grdvwJobs"
        runat="server"
        DataSourceID="sqlsrc"
        AllowSorting="true"
        AutoGenerateSelectButton="false"
        HorizontalAlign="Center"
        AutoGenerateColumns="false" DataKeyNames="JobID">
        <Columns>
            <asp:BoundField HeaderText="JobName" DataField="JobName" SortExpression="JobName" />
            <asp:BoundField HeaderText="CompanyName" DataField="CompanyName" SortExpression="CompanyName" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnView" runat="server" Text="View" OnClick="btnView_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
    <br />
    <br />
    <h3>Bookmarked Internships:</h3>
    <asp:GridView ID="grdvwInternships"
        runat="server"
        DataSourceID="sqlsrc2"
        AllowSorting="true"
        AutoGenerateSelectButton="false"
        HorizontalAlign="Center"
        AutoGenerateColumns="false" DataKeyNames="InternshipID">
        <Columns>
            <asp:BoundField HeaderText="InternshipName" DataField="InternshipName" SortExpression="InternshipName" />
            <asp:BoundField HeaderText="CompanyName" DataField="CompanyName" SortExpression="CompanyName" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnView2" runat="server" Text="View" OnClick="btnView2_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlsrc2" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
    <br />
    <br />
    <h3>Bookmarked Opportunities:</h3>
    <asp:GridView ID="grdvwOpportunities"
        runat="server"
        DataSourceID="sqlsrc3"
        AllowSorting="true"
        AutoGenerateSelectButton="false" 
        HorizontalAlign="Center"
        AutoGenerateColumns="false" DataKeyNames="OpportunityID">
        <Columns>
            <asp:BoundField HeaderText="Opportunity Name" DataField="OpportunityName" SortExpression="OpportunityName" />
            <asp:BoundField HeaderText="Description" DataField="OpportunityDescription" SortExpression="OpportunityDescription" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnView3" runat="server" Text="View" OnClick="btnView3_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlsrc3" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
        </div>
</asp:Content>
