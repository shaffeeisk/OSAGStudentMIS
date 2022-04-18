<%--Page for creating job--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateJob.aspx.cs" Inherits="OSAG.member.CreateJob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Create Jobs">
        <meta name="author" content="Madison Solutions">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Jobs</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

        <!-- CSS -->
        <link href="/_css/custom.css" rel="stylesheet" type="text/css" media="screen">

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@500&family=Roboto:wght@300&display=swap" rel="stylesheet">

        <!-- Icons -->
        <script src="https://kit.fontawesome.com/b51d9e9335.js" crossorigin="anonymous"></script>

        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    </head>

    <body style="background-color: #FEFEFE;">
        <script language="Javascript">
            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
        </script>

        <!--Header starts-->
        <div class="container text-center px-5 pt-5 pb-5">
            <div class="row">
                <div class="col text-center pb-4">
                    <h2>CREATE JOBS</h2>
                </div>
            </div>
            <!--Header ends-->

            <!--Inputs start-->
            <div class="row pt-4">
                <div class="createjobs col px-5 mb-3">
                    <asp:Label ID="lblJobName" runat="server" Text="Job Name: " Width="160px" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtJobName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1"
                        ControlToValidate="txtJobName"
                        Text="(Required)"
                        runat="server" />
                </div>

                <div class="createjobs col px-5 mb-3">
                    <asp:Label ID="Label1" runat="server" Text="Job Description: " Width="160px" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtJobDescription" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator2"
                        ControlToValidate="txtJobDescription"
                        Text="(Required)"
                        runat="server" />
                </div>
            </div>


            <div class="row">
                <div class="createjobs col px-5 mb-3">
                    <asp:Label ID="Label2" runat="server" Text="Application Deadline: " Width="160px" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtApplicationDeadline" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:CompareValidator
                        ID="CompareValidator1"
                        ControlToValidate="txtApplicationDeadline"
                        Text="Use Date Format"
                        Operator="DataTypeCheck"
                        Type="Date"
                        runat="server" />
                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator3"
                        ControlToValidate="txtApplicationDeadline"
                        Text="(Required)"
                        runat="server" />
                </div>

                <div class="createjobs col px-5 mb-3">
                    <asp:Label ID="Label3" runat="server" Text="StartDate: " Width="160px" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:CompareValidator
                        ID="CompareValidator2"
                        ControlToValidate="txtStartDate"
                        Text="Use Date Format"
                        Operator="DataTypeCheck"
                        Type="Date"
                        runat="server" />
                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator4"
                        ControlToValidate="txtStartDate"
                        Text="(Required)"
                        runat="server" />
                </div>
            </div>


            <div class="row">
                <div class="createjobs col px-5 mb-3">
                    <asp:Label ID="Label4" runat="server" Text="Weekly Hours: " Width="160px" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtWeeklyHours" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator5"
                        ControlToValidate="txtWeeklyHours"
                        Text="(Required)"
                        runat="server" />
                    <asp:RegularExpressionValidator
                        ID="RegularExpressionValidator1"
                        runat="server"
                        ControlToValidate="txtWeeklyHours"
                        ValidationExpression="([0-9])[0-9]*[.]?[0-9]*"
                        ErrorMessage="Invalid Entry">
                    </asp:RegularExpressionValidator>
                </div>

                <div class="createjobs col px-5 mb-3">
                    <asp:Label ID="Label5" runat="server" Text="Payment: " Width="160px" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtPayment" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator6"
                        ControlToValidate="txtPayment"
                        Text="(Required)"
                        runat="server" />
                    <asp:RegularExpressionValidator
                        ID="RegularExpressionValidator6"
                        runat="server"
                        ControlToValidate="txtPayment"
                        ValidationExpression="([0-9])[0-9]*[.]?[0-9]*"
                        ErrorMessage="Invalid Entry">
                    </asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="row">
                <div class="col justify-content-center d-grid pt-4 pb-2 mx-auto">
                    <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="177px"
                        DataSourceID="sqlsrcListCompanys"
                        DataTextField="CompanyName"
                        CssClass="form-control"
                        DataValueField="CompanyID"
                        AppendDataBoundItems="true">
                        <asp:ListItem Selected="True" Text="(Select a company)" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <!--Inputs ends-->

            <!--butttons start-->
            <div class="row">
                <div class="col justify-content-center d-grid pt-4 pb-5 mx-auto">
                    <asp:Button ID="btnSaveJob" Text="SAVE" runat="server" CssClass="btn btn-primary" OnClick="btnSaveJob_Click" />
                    <br />
                    <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
                    <br />
                    <asp:Button ID="btnOverride" Text="YES" runat="server" CssClass="btn btn-primary" OnClick="btnOverride_Click" Visible="false" />
                    &nbsp
                <asp:Button ID="btnCancel" Text="NO" runat="server" CssClass="btn btn-primary" OnClick="btnCancel_Click" Visible="false" />
                    <br />
                </div>
            </div>
            <div class="row">
                <div class="col justify-content-center d-grid pt-2 pb-4 mx-auto">
                    <asp:Button ID="btnClear" runat="server" Text="CLEAR ALL USER INPUTS" CssClass="btn btn-primary" OnClick="btnClear_Click" Font-Bold="true" BackColor="Red" />
                </div>
            </div>
            <!--buttons end-->

            <br />
            <br />
            <asp:DataList ID="dlistJobs" runat="server" DataSourceID="sqlsrc"
                EnableViewState="False">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Job Name</th>
                                <th scope="col">Job Description</th>
                                <th scope="col">Application Deadline</th>
                                <th scope="col">Start Date</th>
                                <th scope="col">Weekly Hours</th>
                                <th scope="col">Payment</th>
                                <th scope="col">Edit</th>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <%# Eval("JobName") %>
                    <td><%# Eval("JobDescription") %></td>
                    <td><%# Eval("ApplicationDeadline") %></td>
                    <td><%# Eval("StartDate") %></td>
                    <td><%# Eval("WeeklyHours") %></td>
                    <td><%# Eval("Payment") %></td>
                    <td><a href="/login/LoginPage.aspx/?id=<%# Eval("JobID") %>">Edit</a></td>
                </ItemTemplate>
            </asp:DataList>
        </div>

    </body>

    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT JobID, JobName, JobDescription, ApplicationDeadline, StartDate, WeeklyHours, Payment FROM Job"
        UpdateCommand="UPDATE Job SET JobName = @JobName, JobDescription = @JobDescription, ApplicationDeadline = @ApplicationDeadline, StartDate = @StartDate, WeeklyHours = @WeeklyHours, Payment = @Payment WHERE JobID=@JobID "
        DeleteCommand="Delete from JobMatch  Where JobID = @JobID Delete FROM Job where JobID = @JobID"></asp:SqlDataSource>

    <asp:SqlDataSource
        ID="sqlsrcListCompanys"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
    </html>
</asp:Content>
