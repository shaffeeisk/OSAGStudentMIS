<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AssignMentor.aspx.cs" Inherits="OSAG.admin.AssignMentor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: auto; margin-right: auto; text-align: center; width: fit-content">
        <h2>Edit Student Data:</h2>
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
