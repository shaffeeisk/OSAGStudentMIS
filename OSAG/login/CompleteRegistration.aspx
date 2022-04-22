<%--Where member is directed to complete registration after temp log in--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Unapproved.Master" AutoEventWireup="true" CodeBehind="CompleteRegistration.aspx.cs" Inherits="OSAG.login.CompleteRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row pt-5 pb-5">
        <div class="col text-center">
            <h2>COMPLETE REGISTRATION</h2>
        </div>
    </div>

    <div class="row">
        <div class="col justify-content-center pb-3 d-grid mx-auto">
            <h4 style="text-align: center">New Username</h4>
            <asp:TextBox ID="txtUsername" runat="server" class="form-control pb-1" placeholder="Username" aria-label="Username"></asp:TextBox>
        </div>
    </div>

    <div class="row; align-content-center">
        <div class="col justify-content-center pt-3 pb-2 d-grid mx-auto">
            <h4 style="text-align: center">New Password</h4>
            <asp:TextBox ID="txtPassword" class="form-control pb-1" placeholder="Password" aria-label="Password" runat="server"></asp:TextBox>
        </div>
    </div>

    <div class="row; align-content-center">
        <div class="col justify-content-center pt-4 d-grid mx-auto">
            <asp:Label ID="lblStatus" runat="server" Font-Names="Roboto" Font-Bold="true" Text=""></asp:Label>
        </div>
    </div>

    <div class="row; align-content-center">
        <div class="col justify-content-center pt-3 pb-2 d-grid mx-auto">
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="SUBMIT" CssClass="btn btn-primary" />
            <asp:Button ID="btnContinue" runat="server" Text="CONTINUE TO PROFILE" Visible="false" CssClass="btn btn-primary" OnClick="btnContinue_Click" />
        </div>
    </div>
    
</asp:Content>
