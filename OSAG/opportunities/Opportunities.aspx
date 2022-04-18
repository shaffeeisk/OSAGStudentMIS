<%--Displays available opportunities--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="Opportunities.aspx.cs" Inherits="OSAG.opportunities.Opportunities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Opportunities">
        <meta name="author" content="Madison Solutions">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Opportunities</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

        <!-- CSS -->
        <link href="/_css/custom.css" rel="stylesheet" type="text/css" media="screen">

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" >
        <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@500&family=Roboto:wght@300&display=swap" rel="stylesheet">

        <!-- Icons -->
        <script src="https://kit.fontawesome.com/b51d9e9335.js" crossorigin="anonymous"></script>

        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    </head>

    <body style="background-color: #FEFEFE;">

        <!--Banner starts-->
        <div style="text-align: center">
            <asp:Image ID="Image1" runat="server" ImageUrl="/_images/banners/jobbanner.png" Height="400px" />
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
                    <input type="text" class="form-control form-control-lg ps-3" placeholder="Search opportunities" aria-label="Search opportunities">
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

    </body>


    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT OpportunityID, OpportunityName, EventDate, CompanyName FROM Opportunity o LEFT JOIN Company c on o.CompanyID = c.CompanyID"></asp:SqlDataSource>
    </html>
</asp:Content>
