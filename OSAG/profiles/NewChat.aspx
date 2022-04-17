<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="NewChat.aspx.cs" Inherits="OSAG.profiles.NewChat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
