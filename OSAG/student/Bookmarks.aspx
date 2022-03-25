<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Bookmark.Master" AutoEventWireup="true" CodeBehind="Bookmarks.aspx.cs" Inherits="OSAG.student.Bookmarks" %>
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
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView> 
        <asp:SqlDataSource ID="sqlsrc" runat="server"  
            ConnectionString="<%$ ConnectionStrings:OSAG %>"  ></asp:SqlDataSource> 
    <asp:GridView ID="grdvwInternships" 
                runat="server" 
                DataSourceID="sqlsrc2" 
                AllowSorting="true" 
                AutoGenerateSelectButton ="false"
                 AutoGenerateColumns="false" DataKeyNames="InternshipName">
                <Columns>
                    <asp:BoundField HeaderText="InternshipName" DataField="InternshipName" SortExpression="InternshipName" />
                    <asp:BoundField HeaderText="CompanyName" DataField="CompanyName" SortExpression="CompanyName" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnView2" runat="server" Text="View" OnClick="btnView2_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView> 
        <asp:SqlDataSource ID="sqlsrc2" runat="server"  
            ConnectionString="<%$ ConnectionStrings:OSAG %>" ></asp:SqlDataSource> 
    <asp:GridView ID="grdvwOpportunities" 
                runat="server" 
                DataSourceID="sqlsrc3" 
                AllowSorting="true" 
                AutoGenerateSelectButton ="false"
                 AutoGenerateColumns="false" DataKeyNames="AwardName">
                <Columns>
                    <asp:BoundField HeaderText="AwardName" DataField="AwardName" SortExpression="AwardName" />
                    <asp:BoundField HeaderText="AwardAmount" DataField="AwardAmount" SortExpression="AwardAmount" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnView3" runat="server" Text="View" OnClick="btnView3_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView> 
        <asp:SqlDataSource ID="sqlsrc3" runat="server"  
            ConnectionString="<%$ ConnectionStrings:OSAG %>"  
            ></asp:SqlDataSource> 
</asp:Content>
