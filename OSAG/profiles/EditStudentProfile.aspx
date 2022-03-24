<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Student.Master" AutoEventWireup="true" CodeBehind="EditStudentProfile.aspx.cs" Inherits="OSAG.profiles.EditStudentProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div style="width: 101%;">
        <div style="float: left; width: 41%; margin-left: auto; margin-right: auto; text-align: right">
            <h2>Update Information:</h2>
            <br />
            <asp:Label ID="lblFirstName" runat="server" Text="First Name: "></asp:Label>
            <input id="firstName" type="text" runat="server" />
            <br />
            <br />
            <asp:Label ID="lblLastName" runat="server" Text="Last Name: "></asp:Label>
            <input id="lastName" type="text" runat="server" />
            <br />
            <br />
            <asp:Label ID="lblEmail" runat="server" Text="Email: "></asp:Label>
            <input id="email" type="text" runat="server" />
            <br />
            <br />
            <asp:Label ID="lblGradDate" runat="server" Text="Graduation Date: "></asp:Label>
            <input id="gradDate" type="date" runat="server" />
            <br />
            <br />
            <asp:Label ID="lblEmployers" runat="server" Text="Employer: (Leave Blank if unemployed)"></asp:Label>
            <asp:DropDownList ID="ddlEmployers" runat="server" AppendDataBoundItems="true"
                DataSourceID="sqlsrcEmpList"
                DataTextField="EmpName"
                DataValueField="EmployerID">
                <asp:ListItem Text=" " Value="0" />
            </asp:DropDownList>
            <asp:SqlDataSource ID="sqlsrcEmpList" runat="server"
                ConnectionString="<%$ ConnectionStrings:OSAG %>"
                SelectCommand="SELECT EmployerID, EmpName FROM Employer;"></asp:SqlDataSource>
        </div>
        <div id="help" style="float: left; width: 45%; margin-left: 100px; text-align: left;">
            <h2>Resume Preview:</h2>
            <asp:Label ID="lblStatus" runat="server" Text="Upload a new resume: "></asp:Label>
            <asp:FileUpload ID="fileResume" runat="server" />
            &nbsp<asp:Button ID="btnUpload" runat="server" Text="Update Resume File" OnClick="btnUpload_Click"   />
            <br />
            <br />
            <iframe id="embedResume" runat="server"
                width="550" height="300"
                type="application/pdf" />
        </div>
    </div>
    <div style="float: left; width: 100%; text-align: center;">
        <br />
        <asp:Label ID="lblUpdateStatus" runat="server" Text=""></asp:Label>
        <br />
        <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" OnClick="btnUpdate_Click"  />
        <br />
        <br />
        <asp:Button ID="btnReturn" runat="server" Text="Go Back" OnClick="btnReturn_Click"  />
        <br />
        <br />
    </div>
</asp:Content>
