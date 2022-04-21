<%--Displays details of selected internship--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="InternshipDetails.aspx.cs" Inherits="OSAG.internships.InternshipDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="View" runat="server" class="container px-5 pt-5 pb-5">
        <!--Header starts-->
        <div class="row pb-3">
            <a href="Internships.aspx" class="previous">&laquo; Back</a>

        </div>

        <div class="row">
            <div class="col-lg-6 offset-lg-3 pb-3">
                <h5>Internship</h5>
                <h1>
                    <asp:Label ID="lblName" runat="server" Text=""></asp:Label></h1>
                <h3>
                    <asp:Label ID="lblCompany" runat="server" Text=""></asp:Label></h3>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6 offset-lg-3 pt-4">
                <h3>Internship DETAILS</h3>

                <h5>DEADLINE:
                    <asp:Label ID="lblDeadline" runat="server" Text=""></asp:Label></h5>
                <h5>START DATE:
                    <asp:Label ID="lblStart" runat="server" Text=""></asp:Label></h5>
                <h5>WEEKLY HOURS:
                    <asp:Label ID="lblHours" runat="server" Text=""></asp:Label></h5>
                <h5>HOURLY WAGE:
                    <asp:Label ID="lblPayment" runat="server" Text=""></asp:Label></h5>

            </div>


        </div>

        <div class="row">
            <div class="col-lg-7 offset-lg-3 pt-4 pb-3">
                <h3>Internship DESCRIPTION</h3>
                <h5>

                    <asp:Label ID="lblDescription" runat="server" Text=""></asp:Label></h5>
            </div>
        </div>

        <div class="row" id="divApplyButton" runat="server" visible="false">
            <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
                <asp:LinkButton ID="lnkbtnApply" class="btn btn-primary mx-auto" runat="server" CausesValidation="false" OnClick="lnkbtnApply_Click">APPLY HERE</asp:LinkButton>
            </div>
        </div>
        <div id="divDidYouApply" runat="server" visible="false">
            <div class="row">
                <div class="col justify-content-center pt-4 d-grid mx-auto">
                    <asp:Label ID="lblStatus" Text="Did you complete your application?" runat="server" />
                </div>
            </div>
            <div class="row">
                <div class="col justify-content-end d-grid pt-4 pb-3 mx-auto">
                    <asp:Button ID="btnApplied" class="btn btn-primary mx-auto" Text="YES" runat="server" CausesValidation="false" OnClick="btnApplied_Click" />
                </div>
                <div class="col justify-content-start d-grid pt-4 pb-3 mx-auto">
                    <asp:Button ID="btnDidNotApply" class="btn btn-primary mx-auto" Text="NO" runat="server" CausesValidation="false" OnClick="btnDidNotApply_Click" />
                </div>
            </div>
        </div>

        <% if (Session["UserType"].ToString() == "student")
            { %>
        <div class="row">
            <div class="col-lg-7 align-content-center pt-4 pb-3" style="text-align: center; margin-left: auto; margin-right: auto">
                <h4>Set Interest Level</h4>
                <h5>
                    <asp:RadioButton ID="rdoLow" Text="Low" runat="server" GroupName="InterestLevel"
                        AutoPostBack="true" OnCheckedChanged="rdoLow_CheckedChanged" />
                    <asp:RadioButton ID="rdoMed" Text="Medium" runat="server" GroupName="InterestLevel"
                        AutoPostBack="true" OnCheckedChanged="rdoMed_CheckedChanged" />
                    <asp:RadioButton ID="rdoHi" Text="High" runat="server" GroupName="InterestLevel"
                        AutoPostBack="true" OnCheckedChanged="rdoHi_CheckedChanged" /></h5>
            </div>
        </div>
        <div class="row">
            <!--Save button-->
            <div class="col justify-content-center d-grid pt-4 pb-5 mx-auto">
                <asp:Button ID="btnBookmark" class="btn btn-secondary mx-auto" runat="server" CausesValidation="false" Text="BOOKMARK" OnClick="btnBookmark_Click" />
            </div>
        </div>
        <% } %>

        <!--Only mentors or above-->
        <% if (Session["UserType"].ToString() == "member" && Int32.Parse(Session["MemberType"].ToString()) <= 3)
            { %>
        <div class="col justify-content-center d-grid pt-4 pb-5 mx-auto">
            <asp:Button ID="btnEdit" class="btn btn-secondary mx-auto" runat="server" Text="EDIT" CausesValidation="false" OnClick="btnEdit_Click" />
        </div>
        <% } %>
    </div>

    <div id="Edit" style="display: none" runat="server" class="container px-5 pt-5 pb-5">

        <br />
        <br />
        <div class="col-lg-6 offset-lg-3 pt-4">
            <h3>Internship DETAILS</h3>

            <h5>Internship Name:
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Width="400px"></asp:TextBox></h5>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator1"
                ControlToValidate="txtName"
                Text="(Required)"
                runat="server" />
            <h5>Company:
                <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="400px"
                    DataSourceID="sqlsrcListCompanies"
                    DataTextField="CompanyName"
                    CssClass="form-control"
                    DataValueField="CompanyID"
                    AppendDataBoundItems="true">
                    <asp:ListItem Selected="True" Text="(Select a company)" Value="0"></asp:ListItem>
                </asp:DropDownList></h5>
            <h5>Deadline:
                <asp:TextBox ID="txtDeadline" TextMode="Date" runat="server"></asp:TextBox>
                <asp:CompareValidator
                    ID="CompareValidator1"
                    ControlToValidate="txtDeadline"
                    Text="Use Date Format"
                    Operator="DataTypeCheck"
                    Type="Date"
                    runat="server" />
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator3"
                    ControlToValidate="txtDeadline"
                    Text="(Required)"
                    runat="server" />
            </h5>
            <h5>Start Date:
                <asp:TextBox ID="txtStart" TextMode="Date" runat="server"></asp:TextBox></h5>
            <asp:CompareValidator
                ID="CompareValidator2"
                ControlToValidate="txtStart"
                Text="Use Date Format"
                Operator="DataTypeCheck"
                Type="Date"
                runat="server" />
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator4"
                ControlToValidate="txtStart"
                Text="(Required)"
                runat="server" />
            <h5>Weekly Hours:
                <asp:TextBox ID="txtHours" runat="server"></asp:TextBox></h5>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator5"
                ControlToValidate="txtHours"
                Text="(Required)"
                runat="server" />
            <asp:RegularExpressionValidator
                ID="RegularExpressionValidator1"
                runat="server"
                ControlToValidate="txtHours"
                ValidationExpression="([0-9])[0-9]*[.]?[0-9]*"
                ErrorMessage="Invalid Entry">
            </asp:RegularExpressionValidator>
            <h5>Hourly Payment:
                <asp:TextBox ID="txtPayment" runat="server"></asp:TextBox></h5>
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
            <h5>Description:
                <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></h5>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator2"
                ControlToValidate="txtDescription"
                Text="(Required)"
                runat="server" />
        </div>

        <div class="col justify-content-center d-grid pt-4 mx-auto">
            <asp:Button ID="btnUpdate" class="btn btn-primary mx-auto" runat="server" Text="UPDATE" OnClick="btnUpdate_Click" />
        </div>

        <div class="col justify-content-center d-grid pt-4 pb-5 mx-auto">
            <asp:Button ID="btnReturn" class="btn btn-secondary mx-auto" runat="server" CausesValidation="false" Text="RETURN" OnClick="btnReturn_Click" />
        </div>
    </div>

    <script type="text/javascript" language="javascript">
        function Navigate(s) {
            javascript: window.open(s)
        }
    </script>
    <asp:SqlDataSource
        ID="sqlsrcListCompanies"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
</asp:Content>
