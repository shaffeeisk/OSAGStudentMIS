<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Mentor.Master" AutoEventWireup="true" CodeBehind="MentorProfile.aspx.cs" Inherits="OSAG.profiles.MentorProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <asp:GridView ID="grdvMentor" runat="server"
            DataSourceID="sqlsrcMentorQuery"
            AutoGenerateColumns="false"
            AllowPaging="true"
            DataKeyNames="Username"
            HorizontalAlign="Center">
            <Columns>
                <asp:BoundField ReadOnly="true" HeaderText="Username" DataField="Username" />
                <asp:BoundField ReadOnly="true" HeaderText="First Name" DataField="FirstName" />
                <asp:BoundField ReadOnly="true" HeaderText="Last Name" DataField="LastName" />
                <asp:BoundField ReadOnly="true" HeaderText="Email" DataField="Email" />
                <asp:BoundField ReadOnly="true" HeaderText="Street Address" DataField="StAddress" />
                <asp:BoundField ReadOnly="true" HeaderText="City" DataField="City" />
                <asp:BoundField ReadOnly="true" HeaderText="State" DataField="M_State" />
                <asp:BoundField ReadOnly="true" HeaderText="Zipcode" DataField="ZipCode" />
            </Columns>
        </asp:GridView>
        <br />
        <br />
        <asp:Button ID="btnEdit" runat="server" Text="Edit my profile" OnClick="btnEdit_Click"  />
    </div>
    <asp:SqlDataSource ID="sqlsrcMentorQuery" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand=""></asp:SqlDataSource>
</asp:Content>
