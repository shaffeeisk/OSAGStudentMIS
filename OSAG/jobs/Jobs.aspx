<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Jobs.Master" AutoEventWireup="true" CodeBehind="Jobs.aspx.cs" Inherits="OSAG.jobs.Jobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="grdvwJobs" 
                runat="server" 
                DataSourceID="sqlsrc" 
                AllowSorting="true" 
                AutoGenerateSelectButton ="false"
                 AutoGenerateColumns="false" DataKeyNames="JobName">
                <Columns>
                    <asp:BoundField HeaderText="JobName" DataField="JobName" SortExpression="JobName" />
                    <asp:BoundField HeaderText="CompanyName" DataField="CompanyName" SortExpression="CompanyName" />
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
            SelectCommand="SELECT j.JobName, c.CompanyName FROM Job j LEFT JOIN Company c on j.CompanyID = c.CompanyID"></asp:SqlDataSource>  
</asp:Content>
