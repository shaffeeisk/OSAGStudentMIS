<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateAnnouncement.aspx.cs" Inherits="OSAG.admin.CreateAnnouncement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--Header starts-->
    <div class="container text-center px-5 pt-5 pb-5">
        <div class="row">
            <div class="col text-center pb-4">
                <h2>Select recipients of your announcement:</h2>
            </div>
        </div>
        <!--Header ends-->
        <div class="col justify-content-center pt-1 d-grid">
            <asp:Label ID="lblUserType" runat="server" Text="User Type:" CssClass="form-label"></asp:Label>
            <div class="col justify-content-center pt-1 d-grid">
                <asp:DropDownList ID="ddl_UserType" runat="server" AutoPostBack="true" Width="177px" CssClass="form-control"
                    AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_UserType_SelectedIndexChanged">
                    <asp:ListItem Selected="True" Text="All" Value="0"></asp:ListItem>
                    <asp:ListItem Selected="False" Text="Student" Value="1"></asp:ListItem>
                    <asp:ListItem Selected="False" Text="Member" Value="2"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Label ID="lblMemberType" Visible="false" runat="server" Text="Member Type:" CssClass="form-label"></asp:Label>
            <div class="col justify-content-center pt-1 d-grid">
                <asp:DropDownList ID="ddl_MemberType" Visible="false" runat="server" AutoPostBack="true" Width="177px" CssClass="form-control"
                    AppendDataBoundItems="true">
                    <asp:ListItem Selected="True" Text="All" Value="4"></asp:ListItem>
                    <asp:ListItem Selected="False" Text="Mentors" Value="3"></asp:ListItem>
                    <asp:ListItem Selected="False" Text="Leadership" Value="2"></asp:ListItem>
                    <asp:ListItem Selected="False" Text="Admin" Value="1"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Label ID="lblMajor" runat="server" Text="Major:" CssClass="form-label"></asp:Label>
            <div class="col justify-content-center pt-1 d-grid">
                <asp:DropDownList ID="ddl_Major" runat="server" AutoPostBack="true" Width="177px"
                    DataSourceID="sqlsrcMajor"
                    DataTextField="MajorName"
                    CssClass="form-control"
                    DataValueField="MajorID"
                    AppendDataBoundItems="true">
                    <asp:ListItem Selected="True" Text="All" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <br />
            <asp:Label ID="lblHeader" runat="server" Text="Header" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtHeader" runat="server" TextMode="MultiLine"
                Rows="3" Height="50" Width="800" CssClass="form-control" BorderColor="Black"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator1"
                ControlToValidate="txtHeader"
                Text="(Required)"
                runat="server" />

            <asp:Label ID="lblBody" runat="server" Text="Body" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" CssClass="form-control" BorderColor="Black"
                Rows="10" Height="400" Width="800"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator2"
                ControlToValidate="txtBody"
                Text="(Required)"
                runat="server" />
            <br />

            <asp:Label ID="lblLink" runat="server" Text="Link (optional)" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtLink" runat="server" Width="800" CssClass="form-control" BorderColor="Black"></asp:TextBox>
            <br />
        </div>

        <asp:Button ID="btn_Send" runat="server" Text="Send" OnClick="btn_Send_Click" CssClass="btn btn-primary" />
        <asp:Label ID="lblSent" runat="server" CssClass="form-label"></asp:Label>
    </div>


    <asp:SqlDataSource
        ID="sqlsrcMajor"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="Select MajorID, MajorName FROM Major WHERE IsMinorOnly IS NULL OR IsMinorOnly = 0;"></asp:SqlDataSource>
</asp:Content>
