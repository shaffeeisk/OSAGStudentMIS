<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUpComplete.aspx.cs" Inherits="OSAG.login.SignUpComplete" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="description" content="Sign Up Complete Page" />
    <meta name="author" content="Madison Solutions" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up Complete</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <!-- CSS -->
    <link href="css/custom.css" rel="stylesheet" type="text/css" media="screen" />

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@500&family=Roboto:wght@300&display=swap" rel="stylesheet" />
</head>
<body class="loginbackground">
    <form id="form1" runat="server">
        <div class="modal modal-tour positon-static d-block bg-purple py-4" tabindex="-1" role="dialog" id="modalTour">
            <div class="modal-dialog" role="document">
                <div class="modal-content rounded-5 shadow">
                    <div class="modal-body">

                        <div id="login" class="row">
                            <div class="col justify-content-center pt-5 d-grid">
                                <h3><strong>SIGN UP COMPLETE</strong></h3>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col justify-content-center pt-5 pb-5 d-grid mx-auto">

                                <svg xmlns="http://www.w3.org/2000/svg" width="120" height="120" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16">
                                    <path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z" />
                                </svg>


                            </div>
                        </div>

                        <div class="row">
                            <div class="col justify-content-center text-center pb-4 px-4 d-grid">
                                <h6>Your account was successfully submitted for review.
                                </h6>

                                <br />

                                <h6>Please wait for your account to be approved.</h6>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col justify-content-center d-grid pt-4 pb-5 mx-auto">
                                <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
                                    <path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z" />
                                </svg>
                                <asp:Button ID="btnArrow" runat="server" xmlns="http://www.w3.org/2000/svg" CssClass="bi bi-arrow-right-circle-fill" Width="60" Height="60" OnClick="btnArrow_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

