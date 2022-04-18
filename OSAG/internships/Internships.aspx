<%--Page for displaying available internships--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="Internships.aspx.cs" Inherits="OSAG.internships.Internships" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        body {
            width: 100%;
            margin: 5px;
        }

        .table-condensed tr th {
            border: 0px solid #6e7bd9;
            color: white;
            background-color: #6e7bd9;
        }

        .table-condensed, .table-condensed tr td {
            border: 0px solid #000;
        }

        tr:nth-child(even) {
            background: #f8f7ff
        }

        tr:nth-child(odd) {
            background: #fff;
        }
    </style>

    <!--Banner starts-->
    <div style="text-align: center">
        <asp:Image ID="Image1" runat="server" ImageUrl="/_images/banners/internshipbanner.png" Height="400px" />
        <br />
    </div>
    <!--Banner ends-->

    <div class="container col-lg-4 text-center pt-5 ">
        <!--Internship header starts-->
        <h2>FIND INTERNSHIPS</h2>
    </div>
    <!--Internship header ends-->


    <div class="container col-lg-9 px-4">
        <!--Search bar starts-->
        <div class="pt-5 pb-5 px-4">
            <div class="input-group" style="margin-left: auto; margin-right: auto; text-align: center; padding-right: unset">
                <div class="input-group-text">
                    <div class="icon icon-lg" >
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search">
                            <circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                <input id="searchBar" runat="server" type="text" class="form-control form-control-lg ps-3" placeholder="Search internships" aria-label="Search internships">
                <asp:Button ID="btnSearch" runat="server" CssClass="input-group-text" Text="Search" OnClick="btnSearch_Click" />
            </div>

        </div>
    </div>
    <!--Search bar ends-->

    <!--Internships list starts-->

    <asp:GridView ID="grdvwInternships"
        runat="server"
        DataSourceID="sqlsrc"
        AllowSorting="true"
        AutoGenerateSelectButton="false"
        HorizontalAlign="Center"
        AutoGenerateColumns="false"
        DataKeyNames="InternshipID"
        CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded bg-body rounded shadow--on-hover"
        PagerStyle-CssClass="pager"
        HeaderStyle-CssClass="header"
        RowStyle-CssClass="rows"
        CellPadding="25"
        CellSpacing="7"
        font="Roboto"
        ForeColor="black">
        <Columns>
            <asp:BoundField HeaderText="Internship Name" DataField="InternshipName" SortExpression="InternshipName" />
            <asp:BoundField HeaderText="Company Name" DataField="CompanyName" SortExpression="CompanyName" />
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
        SelectCommand="SELECT InternshipID, j.InternshipName, c.CompanyName FROM Internship j LEFT JOIN Company c on j.CompanyID = c.CompanyID"></asp:SqlDataSource>
</asp:Content>
