<%--Displays the details of the opportunity selected--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Details.Master" AutoEventWireup="true" CodeBehind="OpportunityDetails.aspx.cs" Inherits="OSAG.opportunities.OpportunityDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="btnBack" runat="server" Text="<--Back" OnClick="btnBack_Click" />
    <br />
    <br />
    <asp:Label ID="lblDetails1" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails2" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails3" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails4" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails5" runat="server" Text=""></asp:Label>
    <br />
    <asp:Label ID="lblDetails6" runat="server" Text=""></asp:Label>
    <br />
    <asp:LinkButton ID="lnkbtnApply" runat="server" Visible="false" OnClick="lnkbtnApply_Click">Apply Here</asp:LinkButton>
    <br />
    <asp:Label ID="lblStatus" Text="Did you complete your application?" runat="server" Visible="false" />
    <br />
    <asp:Button ID="btnApplied" Text="Yes!" runat="server" Visible="false" OnClick="btnApplied_Click" />
    &nbsp
    <asp:Button ID="btnDidNotApply" Text="No!" runat="server" Visible="false" OnClick="btnDidNotApply_Click" />
    <script type="text/javascript" language="javascript">
        function Navigate(s) {
            javascript: window.open(s)
        }
    </script>
</asp:Content>
