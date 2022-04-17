<%--Page for creating job--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateJob.aspx.cs" Inherits="OSAG.member.CreateJob" %>

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
    <div class="container text-center px-5 pt-5 pb-5">
        <asp:Label ID="lblJobName" runat="server" Text="Job Name: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtJobName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator1"
            ControlToValidate="txtJobName"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Job Description: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtJobDescription" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator2"
            ControlToValidate="txtJobDescription"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Application Deadline: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtApplicationDeadline" runat="server"></asp:TextBox>
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
        <br />
        <asp:Label ID="Label3" runat="server" Text="StartDate: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
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
        <br />
        <asp:Label ID="Label4" runat="server" Text="Weekly Hours: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtWeeklyHours" runat="server"></asp:TextBox>
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
        <br />
        <asp:Label ID="Label5" runat="server" Text="Payment: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtPayment" runat="server"></asp:TextBox>
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
        <br />
        <asp:Label ID="Label6" runat="server" Text="CompanyID: " Width="160px"></asp:Label>
        <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="177px"
            DataSourceID="sqlsrcListCompanys"
            DataTextField="CompanyName"
            DataValueField="CompanyID"
            AppendDataBoundItems="true">
            <asp:ListItem Selected="True" Text="(Select a company)" Value=""></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <br />
        <asp:Button ID="btnSaveJob" Text="Save ->" runat="server" OnClick="btnSaveJob_Click" />
        <br />
        <br />
        <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnOverride" Text="Yes" runat="server" OnClick="btnOverride_Click" Visible="false" />
        &nbsp
         <asp:Button ID="btnCancel" Text="No" runat="server" OnClick="btnCancel_Click" Visible="false" />
        <br />
        <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click" Font-Bold="true" BackColor="OrangeRed" />
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

        <asp:SqlDataSource ID="sqlsrc" runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"
            SelectCommand="SELECT JobID, JobName, JobDescription, ApplicationDeadline, StartDate, WeeklyHours, Payment FROM Job"
            UpdateCommand="UPDATE Job SET JobName = @JobName, JobDescription = @JobDescription, ApplicationDeadline = @ApplicationDeadline, StartDate = @StartDate, WeeklyHours = @WeeklyHours, Payment = @Payment WHERE JobID=@JobID "
            DeleteCommand="Delete from JobMatch  Where JobID = @JobID Delete FROM Job where JobID = @JobID"></asp:SqlDataSource>
    </div>
    <asp:SqlDataSource
        ID="sqlsrcListCompanys"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT CompanyName, CompanyID FROM Company;"></asp:SqlDataSource>
</asp:Content>
