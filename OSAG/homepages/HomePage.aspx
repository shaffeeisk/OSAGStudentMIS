<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="OSAG.homepages.HomePage" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Public Homepage">
    <meta name="author" content="Madison Solutions">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ole School Alumni Scholarship Group</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <!-- Bootstrap Font Icon CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

    <!--Java Script for counter feature-->
    <script>
        $(document).ready(function () {

            $('.counter').each(function () {
                $(this).prop('Counter', 0).animate({
                    Counter: $(this).text()
                }, {
                    duration: 4000,
                    easing: 'swing',
                    step: function (now) {
                        $(this).text(Math.ceil(now));
                    }
                });
            });

        });
    </script>
    <!-- CSS -->
    <link href="/_css/custom.css" rel="stylesheet" type="text/css" media="screen" />

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@500&family=Roboto:wght@300&display=swap" rel="stylesheet" />

    <!-- Icons -->
    <script src="https://kit.fontawesome.com/b51d9e9335.js" crossorigin="anonymous"></script>
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />
</head>

<body class="publicpage">

    <!--banner blurb-->
    <div class="findfuture">
        <h1 class="display-2">FIND YOUR FUTURE</h1>
    </div>

    <div class="row gx-0">
        <div class="text-center">
            <iframe width="547" height="308" src="https://www.youtube.com/embed/ABiRjz3--10" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
    </div>

    <div class="col-md-12 text-center pt-5">
        <p class="findfuture" style="padding: unset; margin: unset; font-size: x-large">GET STARTED</p>
        <a href="/login/LoginPage.aspx"><i class="bi bi-arrow-right-circle-fill"></i></a>
    </div>
    <div class="top" style="margin-top: 15px;">

        <div class="successes px-5 pt-4">
            <div class="row gx-0">
                <!-- counter -->
                <div class="col-md-3 col-sm-6 bottom-margin text-center counter-section wow fadeInUp sm-margin-bottom-ten animated" data-wow-duration="300ms" style="visibility: visible; animation-duration: 300ms; animation-name: fadeInUp;">
                    <i class="bi bi-cash-coin medium-icon"></i><span id="anim-number-pizza" class="counter-number"></span>
                    <span class="timer counter alt-font appear" data-to="980" data-speed="7000">
                        <asp:Label ID="lblScholarship" runat="server" Text=""></asp:Label>
                    </span>
                    <span class="counter-title">Given in Scholarships</span>
                </div>
                <!-- end counter -->

                <!-- counter -->
                <div class="col-md-3 col-sm-6 bottom-margin text-center counter-section wow fadeInUp sm-margin-bottom-ten animated" data-wow-duration="600ms" style="visibility: visible; animation-duration: 600ms; animation-name: fadeInUp;">
                    <i class="bi bi-award medium-icon"></i>
                    <span class="timer counter alt-font appear" data-to="980" data-speed="7000">
                        <asp:Label ID="lblJandI" runat="server" Text="Label"></asp:Label>
                    </span>
                    <span class="counter-title">Jobs and Internship Opportunities Facilitated </span>
                </div>
                <!-- end counter -->

                <!-- counter -->
                <div class="col-md-3 col-sm-6 bottom-margin-small text-center counter-section wow fadeInUp xs-margin-bottom-ten animated" data-wow-duration="900ms" style="visibility: visible; animation-duration: 900ms; animation-name: fadeInUp;">
                    <i class="bi bi-building medium-icon"></i><span class="timer counter alt-font appear" data-to="810" data-speed="7000">
                        <asp:Label ID="lblCompanies" runat="server" Text=""></asp:Label>
                    </span><span class="counter-title">Company Partners</span>
                </div>
                <!-- end counter -->

                <!-- counter -->
                <div class="col-md-3 col-sm-6 text-center counter-section wow fadeInUp animated" data-wow-duration="1200ms" style="visibility: visible; animation-duration: 1200ms; animation-name: fadeInUp;">
                    <i class="bi bi-person-fill medium-icon"></i>
                    <span class="timer counter alt-font appear" data-to="600" data-speed="7000">
                        <asp:Label ID="lblMembers" runat="server" Text=""></asp:Label>
                    </span><span class="counter-title">Members</span>
                </div>
                <!-- end counter -->

            </div>
        </div>
    </div>
</body>
</html>
