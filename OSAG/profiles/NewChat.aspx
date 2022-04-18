<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="NewChat.aspx.cs" Inherits="OSAG.profiles.NewChat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Jobs">
        <meta name="author" content="Madison Solutions">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jobs</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

        <!-- CSS -->
        <link href="css/custom.css" rel="stylesheet" type="text/css" media="screen">

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" >
        <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@500&family=Roboto:wght@300&display=swap" rel="stylesheet">

        <!-- Icons -->
        <script src="https://kit.fontawesome.com/b51d9e9335.js" crossorigin="anonymous"></script>
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    </head>
    <body
    <br />
    <asp:Label ID="lblAddStudentRecipient" runat="server" Text="Add Student Recipient"></asp:Label>
    <asp:DropDownList ID="ddl_StudentRecipient" runat="server" AutoPostBack="true" Width="177px"
            DataSourceID="sqlsrcStudents"
            DataTextField="Name"
            DataValueField="StudentID"
            AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_StudentRecipient_SelectedIndexChanged">
            <asp:ListItem Selected="True" Text="(Select Student to Add)" Value=""></asp:ListItem>
        </asp:DropDownList>
    <asp:TextBox ID="txtStudents" Enabled="false" runat="server" Width ="700"></asp:TextBox>
    <asp:Label ID="lblStudentMax" ForeColor ="Red" runat="server" ></asp:Label>
    <br />
    <asp:Label ID="lblAddMemberRecipient" runat="server" Text="Add Member Recipient"></asp:Label>
    <asp:DropDownList ID="ddl_MemberRecipient" runat="server" AutoPostBack="true" Width="177px"
            DataSourceID="sqlsrcMembers"
            DataTextField="Name"
            DataValueField="MemberID"
            AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_MemberRecipient_SelectedIndexChanged">
            <asp:ListItem Selected="True" Text="(Select Member to Add)" Value=""></asp:ListItem>
        </asp:DropDownList>
    <asp:TextBox ID="txtMembers" Enabled="false" runat="server" Width ="700"></asp:TextBox>
    <asp:Label ID="lblMemberMax" ForeColor ="Red" runat="server" ></asp:Label>
    <br />
    <asp:TextBox ID="txtChatBox" TextMode="MultiLine"
            Rows="5" Height="100" Width="200" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator
            ID="RequiredFieldValidator1"
            ControlToValidate="txtChatBox"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Button ID="btn_Send" runat="server" Text="Send Message" OnClick="btn_Send_Click"/>
    <asp:SqlDataSource
        ID="sqlsrcStudents"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand=";"></asp:SqlDataSource>
    <asp:SqlDataSource
        ID="sqlsrcMembers"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand=";"></asp:SqlDataSource>
</asp:Content>
