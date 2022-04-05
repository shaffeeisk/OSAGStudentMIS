<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="CreateOpportunity.aspx.cs" Inherits="OSAG.member.CreateOpportunity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <asp:Label ID="lblAwardName" runat="server" Text="Award Name: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtAwardName" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblAmount" runat="server" Text="Award Amount: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtAmount" TextMode="Number" runat="server"></asp:TextBox>

        <br />
        <asp:Label ID="Label1" runat="server" Text="Award Description: " Width="160px"></asp:Label>
        <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="btnSaveOpportunity" Text="Save ->" runat="server" OnClick="btnSaveOpportunity_Click" />
        <br />
        <br />
        <asp:Label ID="lblSuccess" Text="" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnClear" runat="server" Text="Clear ALL user inputs" OnClick="btnClear_Click" Font-Bold="true" BackColor="OrangeRed" />
        <br />
        <br />
        <asp:GridView ID="grdvwOpportunities"
            runat="server"
            DataSourceID="sqlsrc"
            AllowSorting="true"
            AutoGenerateSelectButton="false"
            AutoGenerateColumns="false" 
            HorizontalAlign="Center"
            DataKeyNames="OpportunityID">
            <Columns>
                <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" CausesValidation="False" />
                <asp:BoundField HeaderText="AwardName" DataField="AwardName" SortExpression="AwardName" />
                <asp:BoundField HeaderText="AwardAmount" DataField="AwardAmount" SortExpression="AwardAmount" />
                <asp:BoundField HeaderText="AwardDescription" DataField="AwardDescription" SortExpression="AwardDescription" />
                <asp:BoundField HeaderText="IsAvailable" DataField="IsAvailable" SortExpression="IsAvailable" />
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sqlsrc" runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"
            SelectCommand="SELECT OpportunityID, AwardName, AwardDescription, AwardAmount, IsAvailable FROM Opportunity"
            UpdateCommand="UPDATE Opportunity SET AwardName = @AwardName, AwardDescription = @AwardDescription, AwardAmount = @AwardAmount, IsAvailable = @IsAvailable WHERE OpportunityID=@OpportunityID "
            DeleteCommand="Delete from OpportunityMatch  Where OpportunityID = @OpportunityID Delete FROM Opportunity where OpportunityID = @OpportunityID"></asp:SqlDataSource>
    </div>
</asp:Content>
