<%--Page to add new members--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AddMember.aspx.cs" Inherits="OSAG.admin.AddMember" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--Header starts-->
    <div class="container text-center px-5 pt-5 pb-5">
        <div class="row">
            <div class="col text-center pb-4">
                <h2>CREATE MEMBER ACCOUNT</h2>
            </div>
        </div>
        <!--Header ends-->

        <!--Inputs start-->
        <div class="row pt-4">
            <div class="col justify-content-center d-grid pt-4 pb-2 mx-auto">
                Access Level:&nbsp
                <asp:DropDownList ID="ddlMemberType" runat="server" CssClass="form-control" Width="200">
                    <asp:ListItem Selected="True" Text="(Select a role)" Value=""></asp:ListItem>
                    <asp:ListItem Text="Member" Value="4" />
                    <asp:ListItem Text="Mentor" Value="3" />
                    <asp:ListItem Text="Leadership" Value="2" />
                    <asp:ListItem Text="Admin" Value="1" />
                </asp:DropDownList>
            </div>
        </div>

        <div class="row pt-4">
            <div class="createjobs col px-5 mb-3">
                First Name:&nbsp
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="createjobs col px-5 mb-3">
                Last Name:&nbsp
            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <div class="row pt-4">
            <div class="createjobs col px-5 mb-3">
                Email:&nbsp
            <asp:TextBox ID="txtEmail" TextMode="Email" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="createjobs col px-5 mb-3">
                Phone Number (Optional):&nbsp
            <asp:TextBox ID="txtPhone" TextMode="Phone" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <div class="row pt-4">
            <div class="createjobs col px-5 mb-3">
                City:&nbsp
            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="createjobs col px-5 mb-3">
                State:&nbsp
            <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>


        <div class="row pt-4">
            <div class="createjobs col px-5 mb-3">
                (Temp) Username:&nbsp
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1"
                    ControlToValidate="txtUsername"
                    Text="(Required)"
                    runat="server" />
                <br />
                <asp:Button ID="btnGenerateUser" runat="server" Text="AUTO-GENERATE USERNAME" OnClick="btnGenerateUser_Click" CssClass="btn btn-secondary" CausesValidation="false" />
            </div>

            <div class="createjobs col px-5 mb-3">
                (Temp) Password:&nbsp 
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator2"
                    ControlToValidate="txtPassword"
                    Text="(Required)"
                    runat="server" />
                <br />
                <asp:Button ID="btnGeneratePass" runat="server" Text="AUTO-GENERATE PASSWORD" OnClick="btnGeneratePass_Click" CssClass="btn btn-secondary" CausesValidation="false" />
            </div>
        </div>
        <div style="text-align: center">
            <br />
            <asp:Button ID="btnCreate" runat="server" Text="CREATE MEMBER ACCOUNT" CssClass="btn btn-primary" OnClick="btnCreate_Click" />
            <br />
            <asp:Label ID="lblStatus" runat="server" CssClass="form-label" Text=""></asp:Label>
        </div>
    </div>

</asp:Content>
