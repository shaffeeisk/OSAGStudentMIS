<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AssignMentor.aspx.cs" Inherits="OSAG.admin.AssignMentor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: auto; margin-right: auto; text-align: center; width: fit-content">

        <asp:Button ID="btnToggleRequests" runat="server" Text="Toggle Requests" OnClick="btnToggleRequests_Click" />
        <br />
        <asp:Label ID="lblMentorshipRequests" runat="server" Text="Mentorship Requests" CssClass="h2" Font-Names="Raleway" Visible="false"></asp:Label>
        <br />
        <asp:GridView ID="grdvMentorshipRequests"
            runat="server"
            Visible="false"
            CellPadding="10"
            HorizontalAlign="Center"
            DataSourceID="sqlsrcMentorshipRequests"
            DataKeyNames="MemberID, StudentID"
            AutoGenerateColumns="false">
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
        <asp:SqlDataSource ID="sqlsrcMentorshipRequests" runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"
            SelectCommand="SELECT s.FirstName + ' ' + s.LastName AS StudentName, s.StudentID, m.FirstName + ' ' + m.LastName AS MemberName, m.MemberID 
            FROM Mentorship ms JOIN Student s ON s.StudentID = ms.StudentID JOIN Member m ON m.MemberID = ms.MemberID WHERE IsRequest = 1;">
        </asp:SqlDataSource>

        <h2>View Student's Mentorships:</h2>
        <br />
        <asp:ListBox ID="lstStudents" runat="server" AutoPostBack="true"
            DataSourceID="sqlsrcStudentList"
            DataTextField="StudentName"
            DataValueField="StudentID"
            OnSelectedIndexChanged="lstStudents_SelectedIndexChanged"></asp:ListBox>
        <br />
        <br />
        <br />
        <asp:Label ID="lblMember" runat="server" Text="Member: "></asp:Label>
        <asp:DropDownList ID="ddlMember" runat="server"
            DataSourceID="sqlsrcMemberList"
            DataTextField="MemberName"
            DataValueField="MemberID">
        </asp:DropDownList>
        <asp:Button ID="btnUpdate" runat="server" Text="Assign to Student" OnClick="btnUpdate_Click" />
        <br />
        <asp:Label ID="lblUpdateStatus" Text="" runat="server" />
        <br />
        <br />
        <asp:GridView ID="grdvwMentorships"
            runat="server"
            DataSourceID="sqlsrcMentorships"
            DataKeyNames="MemberID"
            OnRowDataBound="grdvwMentorships_RowDataBound"
            AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Mentor Name" DataField="FullName" />
                <asp:BoundField HeaderText="Mentorship Status" DataField="EndDate" />
                <asp:TemplateField HeaderText="Change Status">
                    <ItemTemplate>
                        <asp:Button ID="btnEndMentorship" runat="server" OnClick="btnEndMentorship_Click" />
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
