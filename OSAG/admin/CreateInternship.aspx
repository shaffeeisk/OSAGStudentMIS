<%--Page for creating internship--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateInternship.aspx.cs" Inherits="OSAG.member.CreateInternship" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Header starts-->
    <div class="container text-center px-5 pt-5 pb-5">
        <div class="row">
            <div class="col text-center pb-4">
                <h2>CREATE INTERNSHIPS</h2>
            </div>
        </div>
        <!--Header ends-->

        <!--Inputs starts-->
        <div class="row pt-4">
            <div class="createjobs col px-5 mb-3">
                <asp:Label ID="lblInternshipName" runat="server" Text="Internship Name: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtInternshipName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1"
                    ControlToValidate="txtInternshipName"
                    Text="(Required)"
                    runat="server" />
            </div>

            <div class="createjobs col px-5 mb-3">
                <asp:Label ID="Label1" runat="server" Text="Internship Description: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtInternshipDescription" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

            <div class="row">
                <div class="createjobs col px-5 mb-3">
                    <asp:Label ID="Label2" runat="server" Text="Application Deadline: " Width="160px" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtApplicationDeadline" TextMode="Date"  runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:CompareValidator
                        ID="CompareValidator2"
                        ControlToValidate="txtApplicationDeadline"
                        Text="Use Date Format"
                        Operator="DataTypeCheck"
                        Type="Date"
                        runat="server" />
                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator2"
                        ControlToValidate="txtApplicationDeadline"
                        Text="(Required)"
                        runat="server" />
                </div>

            <div class="createjobs col px-5 mb-3">
                <asp:Label ID="Label3" runat="server" Text="StartDate: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CompareValidator
                    ID="CompareValidator1"
                    ControlToValidate="txtStartDate"
                    Text="Use Date Format"
                    Operator="DataTypeCheck"
                    Type="Date"
                    runat="server" />
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator3"
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
                <asp:TextBox ID="txtPayment" TextMode="Number" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator4"
                    ControlToValidate="txtPayment"
                    Text="(Required)"
                    runat="server" />
                <asp:RegularExpressionValidator
                    ID="RegularExpressionValidator2"
                    runat="server"
                    ControlToValidate="txtPayment"
                    ValidationExpression="([0-9])[0-9]*[.]?[0-9]*"
                    ErrorMessage="Invalid Entry">
                </asp:RegularExpressionValidator>
            </div>
        </div>

        <div class="row">
            <div class="col justify-content-center d-grid pt-4 pb-2 mx-auto">
                <asp:Label ID="lblCompany" runat="server" Text="Company: " CssClass="form-label"></asp:Label>
                <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="400px"
                    DataSourceID="sqlsrcListCompanies"
                    DataTextField="CompanyName"
                    CssClass="form-control"
                    DataValueField="CompanyID"
                    AppendDataBoundItems="true">
                    <asp:ListItem Selected="True" Text="(Select a company)" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <!--Inputs ends-->

        <!--buttons start-->
        <div class="row">
            <div class="col justify-content-center d-grid pt-4 mx-auto">
                <asp:Label ID="lblSuccess" CssClass="form-label" Font-Bold="true" runat="server" />
                <asp:Button ID="btnSaveIntern" Text="SAVE" CssClass="btn btn-primary" runat="server" OnClick="btnSaveIntern_Click" />
            </div>
        </div>
        <div class="row">
            <div class="col justify-content-end d-grid pb-4 mx-auto">
                <asp:Button ID="btnOverride" Text="YES" runat="server" CssClass="btn btn-primary justify-content-center" Width="110px" OnClick="btnOverride_Click" Visible="false" />
            </div>
            <div class="col justify-content-lg-start d-grid pb-4 mx-auto">
                <asp:Button ID="btnCancel" Text="NO" runat="server" CssClass="btn btn-secondary" Width="110px" OnClick="btnCancel_Click" Visible="false" />
            </div>
        </div>
        <div class="row">
            <div class="col justify-content-center d-grid pb-4 mx-auto" style="width: auto">
                <asp:Button ID="btnClear" runat="server" Text="CLEAR ALL INPUTS" CssClass="btn btn-secondary btn-danger" Width="200px" OnClick="btnClear_Click" />
            </div>
        </div>
        <!--buttons end-->

        <asp:DataList ID="dlistInternships" runat="server" DataSourceID="sqlsrc"
            EnableViewState="False" HorizontalAlign="Center">
            <HeaderTemplate>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Internship Name</th>
                            <th scope="col">Company</th>
                            <th scope="col">Application Deadline</th>
                            <th scope="col">Start Date</th>
                            <th scope="col">Weekly Hours</th>
                            <th scope="col">Payment</th>
                            <th scope="col">Edit</th>
                        </tr>
                    </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <%try
                    { %>
                <%# Eval("InternshipName") %>
                <td><%# Eval("CompanyName") %></td>
                <td><%# String.Format("{0:M/d/yyyy}", Eval("ApplicationDeadline")) %> </td>
                <td><%# String.Format("{0:M/d/yyyy}", Eval("StartDate")) %></td>
                <td><%# Eval("WeeklyHours") %></td>
                <td><%# String.Format("{0:C}", Eval("Payment")) %></td>
                <td><a href="/internships/InternshipDetails.aspx?id=<%# Eval("InternshipID") %>">Edit</a></td>
                <%}
                    catch (Exception ex)
                    {
                        throw ex;
                    } %>
            </ItemTemplate>
        </asp:DataList>
    </div>

    <asp:SqlDataSource ID="sqlsrcListCompanies"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlsrc" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT InternshipID, InternshipName, CompanyName, ApplicationDeadline, StartDate, WeeklyHours, Payment FROM Internship i JOIN Company c ON i.CompanyID = c.CompanyID"
        UpdateCommand="UPDATE Internship SET InternshipName = @InternshipName, InternshipDescription = @InternshipDescription, ApplicationDeadline = @ApplicationDeadline, StartDate = @StartDate, WeeklyHours = @WeeklyHours, Payment = @Payment WHERE InternshipID=@InternshipID "
        DeleteCommand="Delete from InternshipMatch  Where InternshipID = @InternshipID Delete FROM Internship where InternshipID = @InternshipID"></asp:SqlDataSource>
</asp:Content>
