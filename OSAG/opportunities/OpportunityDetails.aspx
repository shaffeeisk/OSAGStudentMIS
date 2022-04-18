<%--Displays the details of the opportunity selected--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Details.Master" AutoEventWireup="true" CodeBehind="OpportunityDetails.aspx.cs" Inherits="OSAG.opportunities.OpportunityDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="row">
        <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
             <asp:Button ID="btnBack" class="btn btn-primary mx-auto" runat="server" OnClick="btnBack_Click" Text="Back to Opportunities" />
        </div>
    </div>
    <div class="col-lg-8">
                        <div class="card mb-3">
                            <div class="card-body">
                                        <div class="row">
                                            <div style="text-align:center">
                                                  <div class="col-lg-6 offset-lg-3 pb-3">
                                                    <h1><asp:Label ID="lblDetails1" runat="server" Text=""></asp:Label></h1>
                                                  </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        
    
    <div class="col-lg-8">
                        <div class="card mb-3">
                            <div class="card-body">
                                        <div class="row">
                                            <div style="text-align:center">
                                                  <div class="col-lg-6 offset-lg-3 pt-4">
                                                    <h3>OPPORTUNITY DETAILS</h3>
                                                    <h5><asp:Label ID="lblDetails2" runat="server" Text=""></asp:Label></h5>
                                                    <h5><asp:Label ID="lblDetails3" runat="server" Text=""></asp:Label></h5>
                                                    <h5><asp:Label ID="lblDetails4" runat="server" Text=""></asp:Label> </h5>
                                                  </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
    <br />
    <div class="row">
        <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
             <asp:LinkButton ID="lnkbtnApply" class="btn btn-primary mx-auto" runat="server" Visible="false" OnClick="lnkbtnApply_Click">Apply Here</asp:LinkButton>
        </div>
    </div>
    <br />
    <asp:Label ID="lblStatus" Text="Did you complete your application?" runat="server" Visible="false" />
    <br />
    <div class="row">
        <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
             <asp:Button ID="btnApplied" class="btn btn-primary mx-auto" Text="Yes!" runat="server" Visible="false" OnClick="btnApplied_Click" />
        </div>
    </div>

    <div class="row">
        <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
            &nbsp
             <asp:Button ID="btnDidNotApply" class="btn btn-primary mx-auto" Text="No!" runat="server" Visible="false" OnClick="btnDidNotApply_Click" />
        </div>
    </div>
    
    
    <%if (Session["UserType"].ToString() == "student")
            { %>

   <div class="col-lg-8">
                        <div class="card mb-3">
                            <div class="card-body">
                                        <div class="row">
                                            <div style="text-align:center">
                                                  <div class="col-lg-6 offset-lg-3 pt-4">
                                                    <h5>Set Interest Level</h5>
                                                    <asp:RadioButton ID="rdoLow" Text="Low" runat="server" GroupName="InterestLevel"
                                                        AutoPostBack="true" OnCheckedChanged="rdoLow_CheckedChanged" />
                                                    <asp:RadioButton ID="rdoMed" Text="Medium" runat="server" GroupName="InterestLevel"
                                                        AutoPostBack="true" OnCheckedChanged="rdoMed_CheckedChanged" />
                                                    <asp:RadioButton ID="rdoHi" Text="High" runat="server" GroupName="InterestLevel"
                                                        AutoPostBack="true" OnCheckedChanged="rdoHi_CheckedChanged" />
                                                  </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
    <br/>
    <div class="row">
        <div style="text-align:center">
            <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
                <asp:Button ID="btnBookmark" class="btn btn-primary mx-auto" runat="server" Text="Add Bookmark" OnClick="btnBookmark_Click" />
            </div>
        </div>
    </div>
    <%} %>
    <script type="text/javascript" language="javascript">
        function Navigate(s) {
            javascript: window.open(s)
        }
    </script>
</asp:Content>
