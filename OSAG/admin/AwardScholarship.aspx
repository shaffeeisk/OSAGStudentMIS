<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AwardScholarship.aspx.cs" Inherits="OSAG.admin.AwardScholarship" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                <h2>AWARD SCHOLARSHIP</h2>
            </div>
        </div>
        <!--Header ends-->

        <!--Inputs start-->
        <div class="row pt-4">
            <div class="createScholarships col px-5 mb-3">
                <asp:Label ID="lblAwardeeName" runat="server" Text="Awardee Name: " CssClass="form-label"></asp:Label>
                <asp:DropDownList ID="ddl_Student" runat="server" AutoPostBack="true" Width="530px"
                    DataSourceID="sqlsrcStudent"
                    DataTextField="Name"
                    CssClass="form-control"
                    DataValueField="StudentID"
                    AppendDataBoundItems="true">
                    <asp:ListItem Selected="True" Text="(Select a student)" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="createScholarships col px-5 mb-3">
                <asp:Label ID="lblYear" runat="server" Text="Year: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtYear" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator2"
                    ControlToValidate="txtYear"
                    Text="(Required)"
                    runat="server" />
                <asp:RegularExpressionValidator
                    ID="RegularExpressionValidator2"
                    runat="server"
                    ControlToValidate="txtYear"
                    ValidationExpression="([0-9])[0-9]*[.]?[0-9]*"
                    ErrorMessage="Invalid Entry">
                </asp:RegularExpressionValidator>
            </div>
        </div>


        <div class="row">
            <div class="createScholarships col px-5 mb-3">
                <asp:Label ID="lblAwardAmount" runat="server" Text="Award Amount: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtAwardAmount" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator3"
                    ControlToValidate="txtAwardAmount"
                    Text="(Required)"
                    runat="server" />
                <asp:RegularExpressionValidator
                    ID="RegularExpressionValidator1"
                    runat="server"
                    ControlToValidate="txtAwardAmount"
                    ValidationExpression="([0-9])[0-9]*[.]?[0-9]*"
                    ErrorMessage="Invalid Entry">
                </asp:RegularExpressionValidator>
            </div>

            <div class="createScholarships col px-5 mb-3">
                <asp:Label ID="lblDeadline" runat="server" Text="Application Deadline: " Width="160px" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtDeadline" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CompareValidator
                    ID="CompareValidator2"
                    ControlToValidate="txtDeadline"
                    Text="Use Date Format"
                    Operator="DataTypeCheck"
                    Type="Date"
                    runat="server" />
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator4"
                    ControlToValidate="txtDeadline"
                    Text="(Required)"
                    runat="server" />
            </div>
        </div>
        <!--Inputs ends-->

        <!--butttons start-->
        <div class="row">
            <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
                <asp:Label ID="lblSuccess" CssClass="form-label" Font-Bold="true" runat="server" />
                <asp:Button ID="btnSaveScholarship" Text="SAVE" CssClass="btn btn-primary" runat="server" OnClick="btnSaveScholarship_Click" />
            </div>
        </div>
        <div class="row">
            <div class="col justify-content-center d-grid pb-4 pt-3 mx-auto" style="width: auto">
                <asp:Button ID="btnClear" runat="server" Text="CLEAR ALL INPUTS" CausesValidation="false" CssClass="btn btn-secondary btn-danger" Width="200px" OnClick="btnClear_Click" />
            </div>
        </div>
        <!--buttons end-->

    </div>
     <asp:SqlDataSource
        ID="sqlsrcStudent"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT StudentID, FirstName + ' ' + LastName AS Name FROM Student;"></asp:SqlDataSource>
</asp:Content>
