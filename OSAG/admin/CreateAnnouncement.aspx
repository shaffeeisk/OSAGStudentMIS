<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateAnnouncement.aspx.cs" Inherits="OSAG.admin.CreateAnnouncement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <h3>Select recipients of your announcement</h3>
        <br />
        <asp:Label ID="lblUserType" runat="server" Text="User Type:"></asp:Label>
        <asp:DropDownList ID="ddl_UserType" runat="server" AutoPostBack="true" Width="177px"
            AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_UserType_SelectedIndexChanged">
            <asp:ListItem Selected="True" Text="All" Value="0"></asp:ListItem>
            <asp:ListItem Selected="False" Text="Student" Value="1"></asp:ListItem>
            <asp:ListItem Selected="False" Text="Member" Value="2"></asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="lblMemberType" Visible="false" runat="server" Text="Member Type:"></asp:Label>
        <asp:DropDownList ID="ddl_MemberType" Visible="false" runat="server" AutoPostBack="true" Width="177px"
            AppendDataBoundItems="true">
            <asp:ListItem Selected="True" Text="All" Value="4"></asp:ListItem>
            <asp:ListItem Selected="False" Text="Mentors" Value="3"></asp:ListItem>
            <asp:ListItem Selected="False" Text="Leadership" Value="2"></asp:ListItem>
            <asp:ListItem Selected="False" Text="Admin" Value="1"></asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="lblMajor" runat="server" Text="Major:"></asp:Label>
        <asp:DropDownList ID="ddl_Major" runat="server" AutoPostBack="true" Width="177px"
            DataSourceID="sqlsrcMajor"
            DataTextField="MajorName"
            DataValueField="MajorID"
            AppendDataBoundItems="true">
            <asp:ListItem Selected="True" Text="All" Value="0"></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="lblHeader" runat="server" Text="Header"></asp:Label>
        <asp:TextBox ID="txtHeader" runat="server" TextMode="MultiLine"
            Rows="5" Height="100" Width="800"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator1"
            ControlToValidate="txtHeader"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="lblBody" runat="server" Text="Body"></asp:Label>
        <asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine"
            Rows="10" Height="400" Width="800"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator2"
            ControlToValidate="txtBody"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="lblLink" runat="server" Text="Link (if you have one)"></asp:Label>
        <asp:TextBox ID="txtLink" runat="server" Width="800"></asp:TextBox>
        <br />
        <asp:Button ID="btn_Send" runat="server" Text="Send" OnClick="btn_Send_Click" />
        <asp:Label ID="lblSent" runat="server"></asp:Label>
    </div>
    <asp:SqlDataSource
        ID="sqlsrcMajor"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="Select MajorID, MajorName FROM Major WHERE IsMinorOnly IS NULL OR IsMinorOnly = 0;"></asp:SqlDataSource>
</asp:Content>
