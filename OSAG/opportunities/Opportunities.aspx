<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="Opportunities.aspx.cs" Inherits="OSAG.opportunities.Opportunities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="grdvwOpportunities" 
                runat="server" 
                DataSourceID="sqlsrc" 
                AllowSorting="true" 
                AutoGenerateSelectButton ="false"
                 AutoGenerateColumns="false" DataKeyNames="AwardName">
                <Columns>
                    <asp:BoundField HeaderText="AwardName" DataField="AwardName" SortExpression="AwardName" />
                    <asp:BoundField HeaderText="AwardAmount" DataField="AwardAmount" SortExpression="AwardAmount" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnView" runat="server" Text="View" OnClick="btnView_Click"/>
                            <asp:Button ID="btnBookmark" runat="server" Text="Bookmark" OnClick="btnBookmark_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView> 
        <asp:SqlDataSource ID="sqlsrc" runat="server"  
            ConnectionString="<%$ ConnectionStrings:OSAG %>"  
            SelectCommand="SELECT AwardName, AwardAmount FROM Opportunity"></asp:SqlDataSource>  
</asp:Content>
