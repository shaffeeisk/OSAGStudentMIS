<%--Displays available opportunities--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="Opportunities.aspx.cs" Inherits="OSAG.opportunities.Opportunities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!--Banner starts-->
        <div style="text-align: center">
            <asp:Image ID="Image1" runat="server" ImageUrl="/_images/banners/opportunitybanner.png" Height="400px" />
            <br />
        </div>
        <!--Banner ends-->

        <div class="container col-lg-4 text-center pt-5 ">
            <h2>UPCOMING OPPORTUNITES</h2>
        </div>

        <div class="container col-lg-9 px-4">
            <!--Search bar starts-->
            <div class="pt-5 pb-5 px-4">
                <div class="input-group">
                    <div class="input-group-text">
                        <div class="icon icon-lg">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search">
                                <circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                    </div>
                    <input id="searchBar" runat="server" type="text" class="form-control form-control-lg ps-3" placeholder="Search opportunities" aria-label="Search opportunities">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </div>
            </div>
            <!--Search bar ends-->

            <asp:GridView ID="grdvwOpportunities"
                runat="server"
                DataSourceID="sqlsrc"
                AllowSorting="true"
                AutoGenerateSelectButton="false"
                AutoGenerateColumns="false"
                HorizontalAlign="Center"
                DataKeyNames="OpportunityID"
                CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded bg-body rounded shadow--on-hover"
                PagerStyle-CssClass="pager"
                HeaderStyle-CssClass="header"
                RowStyle-CssClass="rows"
                CellPadding="25"
                CellSpacing="7"
                font="Roboto"
                ForeColor="black">
                <Columns>
                    <asp:BoundField HeaderText="Opportunity Name" DataField="OpportunityName" SortExpression="OpportunityName" />
                    <asp:BoundField HeaderText="Company" DataField="CompanyName" SortExpression="CompanyName" NullDisplayText="N/A" />
                    <asp:BoundField HeaderText="Event Date" DataField="EventDate" DataFormatString="{0:MMMM dd, yyyy}" SortExpression="EventDate" NullDisplayText="N/A" />
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
        </div>

    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT OpportunityID, OpportunityName, EventDate, CompanyName FROM Opportunity o LEFT JOIN Company c on o.CompanyID = c.CompanyID"></asp:SqlDataSource>
</asp:Content>
