<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="NewChat.aspx.cs" Inherits="OSAG.profiles.NewChat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--Header starts-->
    <div class="container px-5 pt-5 pb-5">
        <div class="row">
            <div class="col text-center pb-4">
                <h2>START NEW CHAT</h2>
            </div>
        </div>
        <!--Header ends-->

        <!--student recipient -->
        <div class="row justify-content-center">
            <asp:DropDownList ID="ddl_StudentRecipient" runat="server" AutoPostBack="true"
                DataSourceID="sqlsrcStudents"
                DataTextField="Name"
                CssClass="form-control"
                style="width:200px; text-align: center"
                DataValueField="StudentID"
                AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_StudentRecipient_SelectedIndexChanged">
                <asp:ListItem Selected="True" Text="(Add Student Recipient)" Value=""></asp:ListItem>
            </asp:DropDownList>

            <div class="row justify-content-center pt-2">
                <asp:TextBox ID="txtStudents" Enabled="false" runat="server" Width="700" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="lblStudentMax" ForeColor="Red" runat="server" CssClass="form-label"></asp:Label>
            </div>
        </div>


        <!--member recipient-->
        <div class="row justify-content-center">
            <asp:DropDownList ID="ddl_MemberRecipient" runat="server" AutoPostBack="true" Width="177px"
                DataSourceID="sqlsrcMembers"
                DataTextField="Name"
                CssClass="form-control"
                style="width:200px; text-align: center"
                DataValueField="MemberID"
                AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_MemberRecipient_SelectedIndexChanged">
                <asp:ListItem Selected="True" Text="(Add Member Recipient)" Value=""></asp:ListItem>
            </asp:DropDownList>

            <div class="row justify-content-center pt-2">
                <asp:TextBox ID="txtMembers" Enabled="false" runat="server" Width="700" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="lblMemberMax" ForeColor="Red" runat="server" CssClass="form-label"></asp:Label>
            </div>
        </div>
        <!--chat box-->
        <div class="row justify-content-center pt-3">
            <asp:Label ID="Label1" runat="server" CssClass="form-label" style="text-align: center" Text="Message" ></asp:Label>
            <asp:TextBox ID="txtChatBox" TextMode="MultiLine"
                Rows="5" Height="100" Width="200" runat="server" CssClass="form-control" BorderColor="Black" ></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator1"
                ControlToValidate="txtChatBox"
                Text="(Required)"
                runat="server" 
                style="text-align: center" />
        </div>

        <!--send button-->
        <div class="row">
            <div class="col justify-content-center d-grid pt-3 mx-auto">
                <asp:Button ID="btn_Send" runat="server" Text="SEND MESSAGE" CssClass="btn btn-primary" OnClick="btn_Send_Click" />
            </div>
        </div>
        <div class="row">
            <div class="col justify-content-center d-grid pt-5 mx-auto">
                <asp:Button ID="btnReturn" runat="server" Text="RETURN" CssClass="btn btn-secondary" CausesValidation="false" PostBackUrl="~/profiles/StartChat.aspx" />
            </div>
        </div>
    </div>


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
