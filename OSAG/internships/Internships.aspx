<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="Internships.aspx.cs" Inherits="OSAG.internships.Internships" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="grdvwInternships"
        runat="server"
        DataSourceID="sqlsrc"
        AllowSorting="true"
        AutoGenerateSelectButton="false" 
        HorizontalAlign="Center"
        AutoGenerateColumns="false"
        DataKeyNames="InternshipID">
        <Columns>
            <asp:BoundField HeaderText="InternshipName" DataField="InternshipName" SortExpression="InternshipName" />
            <asp:BoundField HeaderText="CompanyName" DataField="CompanyName" SortExpression="CompanyName" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnView" runat="server" Text="View" OnClick="btnView_Click" />
                    <asp:Button ID="btnBookmark" runat="server" Text="Bookmark" OnClick="btnBookmark_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT InternshipID, j.InternshipName, c.CompanyName FROM Internship j LEFT JOIN Company c on j.CompanyID = c.CompanyID"></asp:SqlDataSource>
</asp:Content>
