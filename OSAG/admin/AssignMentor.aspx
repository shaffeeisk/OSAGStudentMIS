<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="AssignMentor.aspx.cs" Inherits="OSAG.admin.AssignMentor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row"> <!--Toggle requests button-->
          <div class="col justify-content-center d-grid pt-5 pb-5 mx-auto">
              <asp:Button ID="btnToggleRequests" class="btn btn-primary" runat="server" Text="Toggle Requests" OnClick="btnToggleRequests_Click" />
          </div>
      </div>

        <div class="container text-center px-5 pt-5 pb-5"> <!--Header starts-->
            <div class="row">
                <div class="col text-center pb-4">
                    <h2>View Student's Mentorships</h2>
                </div>
            </div> 


            <!--Header ends-->

    <div style="margin-left: auto; margin-right: auto; text-align: center; width: fit-content">
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
            AutoGenerateColumns="false"
            CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
            PagerStyle-CssClass="pager"
            HeaderStyle-CssClass="header"
            RowStyle-CssClass="rows"
            CellSpacing="7"
            font="Roboto"
            ForeColor="black">
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
        <br />
        <div class="row justify-content-center">
            <asp:Label ID="lblMember" runat="server" Text="Member: " Width="177px"></asp:Label>
                <asp:DropDownList ID="ddlMember" runat="server"
                    DataSourceID="sqlsrcMemberList"
                    DataTextField="MemberName"
                    DataValueField="MemberID"
                    CssClass="form-control">
                </asp:DropDownList>
        </div>

        <div class="row"> <!--Assign student button-->
            <div class="col justify-content-center d-grid pt-5 pb-5 mx-auto">
                <asp:Button ID="btnUpdate"  class="btn btn-primary" runat="server" Text="Assign to Student" OnClick="btnUpdate_Click" />
            </div>
        </div>
        <br />
        <div class="row"> <!--Assign student button-->
            <div class="col justify-content-center d-grid pt-5 pb-5 mx-auto">
                <asp:Label ID="lblUpdateStatus" Text="" runat="server" />
            </div>
        </div>
        <br />
        <br />
        <asp:GridView ID="grdvwMentorships"
            runat="server"
            DataSourceID="sqlsrcMentorships"
            DataKeyNames="MemberID"
            OnRowDataBound="grdvwMentorships_RowDataBound"
            AutoGenerateColumns="false"
            CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow--on-hover"
            PagerStyle-CssClass="pager"
            HeaderStyle-CssClass="header"
            RowStyle-CssClass="rows"
            CellSpacing="7"
            font="Roboto"
            ForeColor="black">
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
