<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="OSAG.profiles.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
        <script language="Javascript">
            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
        </script>

        <asp:Label ID="lblApprove" runat="server" Text=""></asp:Label>
        <br />

        <!-- VIEW MODE STARTS -->
        <div id="divModeView" runat="server" class="container">
            <div class="main-body pt-4 px-5">
                <div class="row">
                    <div class="col-lg-4 px-3 pb-2">
                        <h2>Student Profile</h2>
                    </div>
                </div>
                <div class="row gutters-sm">
                    <div class="col-lg-4 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center pt-3">
                                    <asp:Image ID="imgViewPFP" runat="server" CssClass="rounded-circle" Width="150" Height="140" />
                                    <div class="mt-3">
                                        <h4 class="studentname">
                                            <asp:Label ID="lblViewName" runat="server"></asp:Label>
                                        </h4>
                                        <p class="text-secondary mb-4 px-3">
                                            <asp:Label ID="lblViewDesc" runat="server"></asp:Label>
                                        </p>
                                        <%if (Session["UserType"].ToString() == "student")
                                            {%>
                                        <asp:Button ID="btnDownloadResume" class="btn btn-primary mb-3" runat="server" Text="View Resume" OnClick="btnDownloadResume_Click" />
                                        <%} %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card mt-3">
                            <ul class="list-group list-group-flush">
                                <%if (Session["UserType"].ToString() == "student")
                                    {%>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0">Class</h6>
                                    <span class="text-secondary">
                                        <asp:Label ID="lblViewClass" runat="server"></asp:Label></span>
                                </li>
                                <%} %>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0">Graduation Date</h6>
                                    <span class="text-secondary">
                                        <asp:Label ID="lblViewGradDate" runat="server"></asp:Label>
                                    </span>
                                </li>

                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0">Major</h6>
                                    <span class="text-secondary">
                                        <asp:Label ID="lblViewMajor" runat="server"></asp:Label>
                                    </span>
                                </li>

                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0">Minor</h6>
                                    <span class="text-secondary">
                                        <asp:Label ID="lblViewMinor" runat="server"></asp:Label>
                                    </span>
                                </li>
                                <%if (Session["UserType"].ToString() == "student")
                                    {%>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0">GPA</h6>
                                    <span class="text-secondary">
                                        <asp:Label ID="lblViewGpa" runat="server"></asp:Label>
                                    </span>
                                </li>
                                <%} %>
                            </ul>
                        </div>
                    </div>

                    <div class="col-lg-8">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="row">
                                    <h4>Contact Information</h4>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">Email</h6>
                                    </div>
                                    <div class="col-lg-9 text-secondary">
                                        <asp:Label ID="lblViewEmail" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">Phone</h6>
                                    </div>
                                    <div class="col-lg-9 text-secondary">
                                        <asp:Label ID="lblViewPhone" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>

                                <% if (Session["UserType"].ToString() == "member")
                                    { %>
                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">City</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <asp:Label ID="lblViewCity" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-lg-3">
                                        <h6 class="mb-0">State</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <asp:Label ID="lblViewState" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <hr>
                                <% } %>

                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="btnEditMode" class="btn btn-outline-primary" CausesValidation="false" runat="server" Text="Edit" OnClick="btnEditMode_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row gutters-sm">
                            <div class="col-lg-12 mb-3">
                                <div class="card h-90">
                                    <div class="card-body">
                                        <div class="row">
                                            <h4>Biography</h4>
                                            <hr>
                                            <p>
                                                <asp:Label ID="lblViewBio" runat="server"></asp:Label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- VIEW MODE ENDS -->

        <!-- EDIT MODE START -->
        <div id="divModeEdit" runat="server" class="container justify-content-center px-5 pt-4" visible="false">
            <h2 class="editprofile text-center pb-5">Edit Profile</h2>
            <div class="row">
                <!-- Left edit column starts -->
                <div class="col-lg-6">
                    <div class="text-center">
                        <asp:Image ID="imgEditPFP" class="avatar img-circle img-thumbnail" runat="server" />

                        <h6 class="upload pt-4">
                            <asp:Label ID="lblPFP" runat="server" Text="Upload Profile Picture (JPG/JPEG)"></asp:Label>
                        </h6>
                        <div class="input-group mb-3" style="width: 400px; margin-left: auto; margin-right: auto">
                            <asp:FileUpload ID="filePFP" CssClass="form-control" runat="server" />
                            <asp:Button ID="btnPFP" type="submit" Text="Upload" class="input-group-text" runat="server" CausesValidation="false" OnClick="btnPFP_Click"></asp:Button>
                        </div>
                        <% if (Session["UserType"].ToString() == "student")
                            { %>
                        <h6 class="upload pt-1">Upload Resume</h6>
                        <div class="input-group mb-5" style="width: 400px; margin-left: auto; margin-right: auto">
                            <asp:FileUpload ID="fileResume" class="form-control" runat="server" />
                            <asp:Button ID="btnUpload" type="submit" Text="Upload" class="input-group-text" runat="server" CausesValidation="false" OnClick="btnUpload_Click"></asp:Button>
                        </div>
                        <% } %>

                        <% if (Session["UserType"].ToString() == "member")
                            { %>
                        <h6 class="upload pt-1">Position Title</h6>
                        <div class="input-group mb-5" style="width: 400px; margin-left: auto; margin-right: 65px">
                            <asp:TextBox ID="txtPosition" runat="server" class="form-control pb-1" placeholder="Position Title" aria-label="Position Title"></asp:TextBox>
                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator30"
                                ControlToValidate="txtPosition"
                                Text="(Required)"
                                runat="server" />
                        </div>
                        <% } %>
                        <h6 class="upload pt-1">Biography</h6>
                        <div class="mb-3" style="width: 504px; margin-left: auto; margin-right: auto">
                            <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine" CssClass="form-control"
                                Rows="5" Width="504" placeholder="Please write CEO Statement" aria-label="Please write CEO Statement"></asp:TextBox>
                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator11"
                                ControlToValidate="txtBio"
                                Text="(Required)"
                                runat="server" />
                        </div>
                    </div>
                </div>

                <!-- Edit info starts-->
                <div class="col-lg-6 information text-center" style="padding-left: 30px">
                    <div class="form-group" style="width: 400px; margin-right: auto; text-align: center;">
                        <asp:TextBox ID="txtFirstName" runat="server" class="form-control pb-1" placeholder="First Name" aria-label="First Name"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator21"
                            ControlToValidate="txtFirstName"
                            Text="(Required)"
                            runat="server" />
                    </div>
                    <div class="form-group" style="width: 400px; margin-right: auto; text-align: center;">
                        <asp:TextBox ID="txtLastName" runat="server" class="form-control pb-1" placeholder="Last Name" aria-label="Last Name"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator22"
                            ControlToValidate="txtLastName"
                            Text="(Required)"
                            runat="server" />
                    </div>
                    <div class="form-group" style="width: 400px; margin-right: auto; text-align: center;">
                        <asp:TextBox ID="txtEmail" AutoCompleteType="Email" runat="server" class="form-control pb-1" placeholder="Email" aria-label="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1"
                            ControlToValidate="txtEmail"
                            Text="(Required)"
                            runat="server" />
                    </div>
                    <div class="form-group" style="width: 400px; margin-right: auto; text-align: center;">
                        <asp:TextBox ID="txtGradDate" TextMode="Date" runat="server" class="form-control pb-1" placeholder="Graduation Date" aria-label="Graduation Date"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator24"
                            ControlToValidate="txtGradDate"
                            Text="(Required)"
                            runat="server" />
                        <asp:CompareValidator
                            ID="CompareValidator3"
                            ControlToValidate="txtGradDate"
                            Text="Use Date Format"
                            Operator="DataTypeCheck"
                            Type="Date"
                            runat="server" />
                    </div>
                    <div class="form-group" style="width: 400px; margin-right: auto; text-align: center;">
                        <asp:TextBox ID="txtPhone" onkeypress="return isNumberKey(event)" runat="server" class="form-control pb-1" placeholder="Phone Number" aria-label="Phone Number"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator3"
                            ControlToValidate="txtPhone"
                            Text="(Required)"
                            runat="server" />
                    </div>
                    <% if (Session["UserType"].ToString() == "student")
                        { %>
                    <div class="form-group" style="width: 400px; margin-right: auto; text-align: center;">
                        <asp:TextBox ID="txtGpa" runat="server" class="form-control pb-1" placeholder="GPA" aria-label="GPA"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator10"
                            ControlToValidate="txtGpa"
                            Text="(Required)"
                            runat="server" />
                    </div>
                    <div class="form-group" style="width: 400px; margin-right: auto; text-align: center;">
                        <asp:TextBox ID="txtClass" runat="server" class="form-control pb-1" placeholder="Class" aria-label="Class"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator19"
                            ControlToValidate="txtClass"
                            Text="(Required)"
                            runat="server" Enabled="false" />
                    </div>
                    <%} %>

                    <% if (Session["UserType"].ToString() == "member")
                        { %>
                    <div class="form-group" style="width: 400px; margin-right: auto; text-align: center;">
                        <asp:TextBox ID="txtCity" runat="server" class="form-control pb-1" placeholder="Class" aria-label="Class"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator2"
                            ControlToValidate="txtClass"
                            Text="(Required)"
                            runat="server" Enabled="false" />
                    </div>
                    <div class="form-group" style="width: 400px; margin-right: auto; text-align: center;">
                        <asp:TextBox ID="txtState" runat="server" class="form-control pb-1" placeholder="State" aria-label="State"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator4"
                            ControlToValidate="txtClass"
                            Text="(Required)"
                            runat="server" Enabled="false" />
                    </div>
                    <%} %>

                    <div class="card mt-3" style="width: 400px; margin-right: auto; text-align: center;">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                <h6 class="mb-0">Major</h6>
                                <span class="text-secondary">
                                    <asp:Label ID="lblEditMajor" runat="server"></asp:Label>
                                </span>
                            </li>

                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                <h6 class="mb-0">Minor</h6>
                                <span class="text-secondary">
                                    <asp:Label ID="lblEditMinor" runat="server"></asp:Label>
                                </span>
                            </li>
                        </ul>
                        <asp:Button ID="btnDeclareMajor" runat="server" OnClientClick="javascript:return confirm('You will be redirected to another page.\nAny unsaved changes will be lost!');"
                            Text="Declare Major(s)/Minor(s)" CausesValidation="false" OnClick="btnDeclareMajor_Click" />
                    </div>

                </div>
            </div>
        </div>
    <div class="row">
            <div class="col justify-content-center d-grid pt-5 pb-5 mx-auto">
                <asp:Button ID="btnUpdate" class="btn btn-primary" runat="server" Text="Save Changes" OnClick="btnUpdate_Click" />
            </div>
        </div>
        <!-- EDIT MODE END -->
        <br />
        <br />
</asp:Content>
