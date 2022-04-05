<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationPage.aspx.cs" Inherits="OSAG.login.RegistrationPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="description" content="Registration Page" />
    <meta name="author" content="Courtney Miyashiro" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create an Account</title>

    <!-- Bootstrap v5.0.0-beta3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
    <link href="/_css/custom.css" rel="stylesheet" type="text/css" media="screen" />

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@500&family=Roboto:wght@300&display=swap" rel="stylesheet" />
</head>

<body style="background-color: #E4E0E7;">
    <form id="form1" runat="server">
        <div class="modal modal-tour position-static d-block bg-purple py-4" tabindex="-1" role="dialog" id="modalTour">
            <div class="modal-dialog" role="document">
                <div class="modal-content rounded-5 shadow">
                    <div class="modal-body">

                        <div id="login" class="row">
                            <div class="col justify-content-center pt-3 d-grid">
                                <h3><strong>CREATE AN ACCOUNT</strong></h3>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col justify-content-center pt-3 d-grid mx-auto">
                                <asp:Button ID="btnDemo" runat="server" Text="DEMO BUTTON" OnClick="btnDemo_Click" Font-Bold="true" CssClass="btn btn-primary" />
                                <br />
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control pb-1" placeholder="First Name"></asp:TextBox>
                                <br />
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control pb-1" placeholder="Last Name"></asp:TextBox>
                                <br />
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control pb-1" placeholder="Email"></asp:TextBox>
                                <br />
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control pb-1" placeholder="Username"></asp:TextBox>
                                <br />
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control pb-1" placeholder="Password"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div id="passwordHelpBlock" class="form-text col justify-content-center pt-2 d-grid mx-auto">
                                Password should be 8-20 characters in length, and contain
                                <br />
                                a mix of letters, numbers and at least one special character
                            </div>
                        </div>

                        <div class="row">
                            <div class="col justify-content-center d-grid pt-4 pb-1 mx-auto">
                                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="SIGN UP" CssClass="btn btn-primary" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col justify-content-center d-grid pt-4 pb-1 mx-auto">
                                <asp:Label ID="lblStatus" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col justify-content-center d-grid pt-4">
                                <p>Already have an account? Login <a href="/login/LoginPage.aspx" style="color:indigo">here</a>  </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
