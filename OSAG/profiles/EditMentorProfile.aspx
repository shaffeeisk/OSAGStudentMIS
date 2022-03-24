<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Mentor.Master" AutoEventWireup="true" CodeBehind="EditMentorProfile.aspx.cs" Inherits="OSAG.profiles.EditMentorProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h2>Update Information: </h2>
    <br />
    <asp:Label ID="lblFirstName" runat="server" Text="First Name: "></asp:Label>
    <input ID="firstName" type="text" runat="server" />
    <br />
    <br />
    <asp:Label ID="lblLastName" runat="server" Text="Last Name: "></asp:Label>
    <input ID="lastName" type="text" runat="server" />
    <br />
    <br />
    <asp:Label ID="lblEmail" runat="server" Text="Email: "></asp:Label>
    <input id="email" type="email" runat="server" />
    <br />
    <br />
    <asp:Label ID="lblStAddress" runat="server" Text="Street Address: "></asp:Label>
    <input id="stAddress" type="text" runat="server" />
    <br />
    <br />
    <asp:Label ID="lblCity" runat="server" Text="City: "></asp:Label>
    <input id="city" type="text" runat="server" />
    <br />
    <br />
    <asp:Label ID="lblState" runat="server" Text="State: "></asp:Label>
    <input id="state" type="text" runat="server" />
    <br />
    <br />
    <asp:Label ID="lblZip" runat="server" Text="Zipcode: "></asp:Label>
    <input id="zip" type="text" maxlength="5" runat="server" />
    <br />
    <br />
    <asp:Label ID="lblUpdateStatus" runat="server" Text=""></asp:Label>
    <br />
    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
    <asp:Button ID="btnBack" runat="server" Text="Go Back" OnClick="btnBack_Click"  />
</asp:Content>
