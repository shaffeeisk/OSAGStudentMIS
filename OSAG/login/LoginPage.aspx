<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="OSAG.login.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="description" content="Login Page" />
    <meta name="author" content="Madison Solutions" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>

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
        <div class="modal modal-tour position-static d-block bg-purple py-5" tabindex="-1" role="dialog" id="modalTour">
            <div class="modal-dialog" role="document">
                <div class="modal-content rounded-5 shadow">
                    <div class="modal-body pt-2">

                        <div class="logo">
                            <img class="center-block" src="/_images/logo.png" />
                        </div>


                        <div class="row">
                            <div class="col justify-content-center pb-3 d-grid">
                                <h6>Scholarship | Mentorship | Community</h6>
                            </div>
                        </div>


                        <div id="login" class="row">
                            <div class="col justify-content-center pt-1 d-grid">
                                <h3><strong>USER LOGIN</strong></h3>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col justify-content-center pt-3 d-grid mx-auto">
                                <asp:TextBox ID="txtUsername" runat="server" class="form-control pb-1" placeholder="Username" aria-label="Username"></asp:TextBox>
                                <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator1"
                                    ControlToValidate="txtUsername"
                                    Text="(Required)"
                                    runat="server" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col justify-content-center pt-3 d-grid mx-auto">
                                <asp:TextBox ID="txtPassword" class="form-control pb-1" placeholder="Password" aria-label="Password" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator2"
                                    ControlToValidate="txtPassword"
                                    Text="(Required)"
                                    runat="server" />
                                <br />
                            </div>

                            <asp:Label ID="lblStatus" runat="server"></asp:Label>

                            <div class="row">
                                <div class="col justify-content-center d-grid pt-4 pb-3 mx-auto">
                                    <asp:Button ID="btnLogin" class="btn btn-primary" runat="server" OnClick="btnLogin_Click" Text="Login" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col justify-content-center d-grid pt-2 pb-5">
                                    <p>Don't have an account already?</p>
                                    <asp:Button ID="btnCreate" class="btn btn-primary mx-auto" runat="server" Text="SIGN UP" CausesValidation="false" OnClick="btnCreate_Click" />
                                </div>
                            </div>
        </div>
        </div>
            </div>
        </div>
    </form>
</body>
</html>
