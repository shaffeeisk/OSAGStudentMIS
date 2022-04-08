<%--Displays available opportunities--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="Opportunities.aspx.cs" Inherits="OSAG.opportunities.Opportunities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="grdvwOpportunities"
        runat="server"
        DataSourceID="sqlsrc"
        AllowSorting="true"
        AutoGenerateSelectButton="false"
        AutoGenerateColumns="false"
        HorizontalAlign="Center"
        DataKeyNames="OpportunityID">
        <Columns>
            <asp:BoundField HeaderText="Opportunity Name" DataField="OpportunityName" SortExpression="OpportunityName" />
            <asp:BoundField HeaderText="Description" DataField="OpportunityDescription" SortExpression="OpportunityDescription" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnView" runat="server" Text="View" OnClick="btnView_Click" />
                    <%if (Session["UserType"].ToString() == "student")
                        {%>
                    <asp:Button ID="btnBookmark" runat="server" Text="Bookmark" OnClick="btnBookmark_Click" />
                    <%} %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT OpportunityID, OpportunityName, OpportunityDescription FROM Opportunity"></asp:SqlDataSource>
</asp:Content>
