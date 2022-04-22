<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AssignMentor.aspx.cs" Inherits="OSAG.admin.AssignMentor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="row">
            <div class="col text-center pt-5 pb-1">
                <h2>MENTORSHIP ASSIGNMENTS</h2>
            </div>
        </div>
    
    <!--Toggle requests button-->
    <div class="row">
        <div class="col justify-content-center d-grid pt-3 mx-auto">
            <asp:Button ID="btnToggleRequests" CssClass="btn btn-primary" runat="server" Text="VIEW REQUESTS" OnClick="btnToggleRequests_Click" />
        </div>
    </div>

    <div class="row">
        <div class="col justify-content-center d-grid pt-4 mx-auto">
            <h3><asp:Label ID="lblMentorshipRequests" runat="server" Text="APPROVE REQUESTS" Visible="false"></asp:Label></h3>
        </div>
    </div>
    <div class="row pb-4">
        <asp:GridView ID="grdvMentorshipRequests"
            runat="server"
            Visible="false"
            CellPadding="10"
            HorizontalAlign="Center"
            DataSourceID="sqlsrcMentorshipRequests"
            DataKeyNames="MemberID, StudentID"
            AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true"
            CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
            PagerStyle-CssClass="pager"
            HeaderStyle-CssClass="header"
            RowStyle-CssClass="rows"
            CellSpacing="7"
            font="Roboto"
            ForeColor="black"
            EmptyDataRowStyle-HorizontalAlign="Center"
            EmptyDataText="No new requests! :)">
            <Columns>
                <asp:BoundField HeaderText="Student" DataField="StudentName" />
                <asp:BoundField HeaderText="Mentor" DataField="MemberName" />
                <asp:TemplateField HeaderText="Approve Mentorship">
                    <ItemTemplate>
                        <asp:Button ID="btnApprove" runat="server" Text="Approve" OnClick="btnApprove_Click" />
                        <asp:Button ID="btnDeny" runat="server" Text="Deny" OnClick="btnDeny_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>


    <asp:SqlDataSource ID="sqlsrcMentorshipRequests" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT s.FirstName + ' ' + s.LastName AS StudentName, s.StudentID, m.FirstName + ' ' + m.LastName AS MemberName, m.MemberID 
            FROM Mentorship ms JOIN Student s ON s.StudentID = ms.StudentID JOIN Member m ON m.MemberID = ms.MemberID WHERE IsRequest = 1;"></asp:SqlDataSource>


    <div class="container text-center px-5 pb-5">
        <div class="row">
            <div class="col text-center pb-2">
                <h3>VIEW/EDIT CURRENT MENTORSHIPS</h3>
            </div>
        </div>
        <br />
        <div class="row justify-content-center">
            <asp:ListBox ID="lstStudents" runat="server" AutoPostBack="true" Width="177px"
                DataSourceID="sqlsrcStudentList"
                DataTextField="StudentName"
                DataValueField="StudentID"
                CssClass="form-control"
                OnSelectedIndexChanged="lstStudents_SelectedIndexChanged"></asp:ListBox>
        </div>
        <br />
        <div class="row justify-content-center pb-2" style="margin-left: auto; margin-right: auto; text-align: center; width: 400px">
            <asp:Label ID="lblMember" runat="server" Text="Member: " Width="177px"></asp:Label>
            <asp:DropDownList ID="ddlMember" runat="server"
                DataSourceID="sqlsrcMemberList"
                DataTextField="MemberName"
                DataValueField="MemberID"
                CssClass="form-control">
            </asp:DropDownList>
        </div>

        <div class="row">
            <!--Assign student button-->
            <div class="col justify-content-center d-grid pt-4 pb-2 mx-auto">
                <asp:Button ID="btnUpdate" class="btn btn-primary" runat="server" Text="ASSIGN TO STUDENT" OnClick="btnUpdate_Click" />
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col justify-content-center d-grid pt-3 mx-auto">
                <asp:Label ID="lblUpdateStatus" Text="" runat="server" />
            </div>
        </div>

        <asp:GridView ID="grdvwMentorships"
            runat="server"
            DataSourceID="sqlsrcMentorships"
            HorizontalAlign="Center"
            DataKeyNames="MemberID"
            OnRowDataBound="grdvwMentorships_RowDataBound"
            AutoGenerateColumns="false"
            CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
            PagerStyle-CssClass="pager"
            HeaderStyle-CssClass="header"
            RowStyle-CssClass="rows"
            CellPadding="10"
            font="Roboto"
            ForeColor="black"
            ShowHeaderWhenEmpty="true"
            EmptyDataText="No Mentorship History">
            <Columns>
                <asp:BoundField HeaderText="Mentor Name" DataField="FullName" />
                <asp:BoundField HeaderText="Mentorship Status" DataField="EndDate" />
                <asp:TemplateField HeaderText="Change Status">
                    <ItemTemplate>
                        <asp:Button ID="btnEndMentorship" runat="server" CssClass="btn-group" OnClick="btnEndMentorship_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="sqlsrcMemberList" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="(SELECT MemberID, FirstName AS MemberName FROM Member WHERE LastName IS NULL)
        UNION (SELECT MemberID, LastName AS MemberName FROM Member WHERE FirstName IS NULL)
        UNION (SELECT MemberID, FirstName + ' ' + LastName AS MemberName FROM Member WHERE FirstName + LastName IS NOT NULL);"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsrcStudentList" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"
        SelectCommand="SELECT FirstName + ' ' + LastName AS StudentName, StudentID FROM Student;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsrcMentorships" runat="server"
        ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>
</asp:Content>
