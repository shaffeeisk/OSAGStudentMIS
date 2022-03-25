<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="OSAG.profiles.UserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <% if (Session["UserType"].ToString() == "student")
        { %>
    <asp:Label ID="Label1" runat="server" Text="FirstName"></asp:Label>
    <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="reqField"
        ControlToValidate="txtFirstName"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Label ID="Label2" runat="server" Text="LastName"></asp:Label>
    <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator1"
        ControlToValidate="txtLastName"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Label ID="Label3" runat="server" Text="Email"></asp:Label>
    <asp:TextBox ID="txtEmail" runat="server" AutoCompleteType="Email"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator2"
        ControlToValidate="txtEmail"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Label ID="Label4" runat="server" Text="GradDate"></asp:Label>
    <asp:TextBox ID="txtGradDate" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator3"
        ControlToValidate="txtGradDate"
        Text="(Required)"
        runat="server" />
    <asp:CompareValidator
        ID="CompareValidator1"
        ControlToValidate="txtGradDate"
        Text="Use Date Format"
        Operator="DataTypeCheck"
        Type="Date"
        runat="server" />
    <br />
    <asp:Label ID="Label6" runat="server" Text="Major"></asp:Label>
    <asp:TextBox ID="txtMajor" runat="server" ></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator10"
        ControlToValidate="txtMajor"
        Text="(Required)"
        runat="server" />
    <br />
    <br />
    <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CausesValidation="false" OnClick="btnUpdate_Click" />
    <br />
    <br />
    <asp:Label ID="Label5" runat="server" Text="Upload your Resume"></asp:Label>
    <asp:FileUpload ID="fileUploadText" runat="server" />
    <asp:Button ID="btnUpload" type="submit" Text="Upload" runat="server" CausesValidation="false" OnClick="btnUpload_Click"></asp:Button>
    <br />
    <asp:Literal ID="ltEmbed" runat="server" />
    <% } %>

    <% if (Session["UserType"].ToString() == "mentor")
        { %>
    <asp:Label ID="lblFirstName" runat="server" Text="FirstName"></asp:Label>
    <asp:TextBox ID="mtxtFirstName" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator4"
        ControlToValidate="txtFirstName"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Label ID="lblLastName" runat="server" Text="   LastName"></asp:Label>
    <asp:TextBox ID="mtxtLastName" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator5"
        ControlToValidate="txtLastName"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Label ID="lblMentorEmail" runat="server" Text="MentorEmail"></asp:Label>
    <asp:TextBox ID="txtMentorEmail" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator6"
        ControlToValidate="txtMentorEmail"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Label ID="lblState" runat="server" Text="MentorState"></asp:Label>
    <asp:TextBox ID="txtState" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator7"
        ControlToValidate="txtState"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Label ID="lblCity" runat="server" Text="MentorCity"></asp:Label>
    <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator8"
        ControlToValidate="txtCity"
        Text="(Required)"
        runat="server" />
    <br />
    <asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label>
    <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="RequiredFieldValidator9"
        ControlToValidate="txtAddress"
        Text="(Required)"
        runat="server" />
    <% } %>
</asp:Content>
