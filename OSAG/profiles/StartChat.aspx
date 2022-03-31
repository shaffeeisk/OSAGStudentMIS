<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="StartChat.aspx.cs" Inherits="OSAG.profiles.StartChat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Select a User to Chat With</h3>
    <br />
    <h3>Students:</h3>
    <asp:GridView ID="grdvStudent" 
                runat="server" 
                DataSourceID="sqlsrcStudent" 
                AllowSorting="true" 
                AutoGenerateSelectButton ="false"
                 AutoGenerateColumns="false" DataKeyNames="StudentID">
                <Columns>
                    <asp:BoundField HeaderText="FirstName" DataField="FirstName" SortExpression="FirstName" />
                    <asp:BoundField HeaderText="LastName" DataField="LastName" SortExpression="LastName" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btn_studentChat" runat="server" Text="Chat" OnClick="btn_studentChat_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView> 
        <asp:SqlDataSource ID="sqlsrcStudent" runat="server" 
            ConnectionString="<%$ ConnectionStrings:OSAG %>"  ></asp:SqlDataSource> 
   
    <h3>Mentors:</h3>
    <asp:GridView ID="grdvMentor" 
                runat="server" 
                DataSourceID="sqlsrcMentor" 
                AllowSorting="true" 
                AutoGenerateSelectButton ="false"
                 AutoGenerateColumns="false" DataKeyNames="MentorID">
                <Columns>
                    <asp:BoundField HeaderText="FirstName" DataField="FirstName" SortExpression="FirstName" />
                    <asp:BoundField HeaderText="LastName" DataField="LastName" SortExpression="LastName" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btn_mentorChat" runat="server" Text="Chat" OnClick="btn_mentorChat_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView> 
        <asp:SqlDataSource ID="sqlsrcMentor" runat="server"  
            ConnectionString="<%$ ConnectionStrings:OSAG %>"  ></asp:SqlDataSource>
</asp:Content>
