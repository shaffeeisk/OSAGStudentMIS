<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="ProgramSuccesses.aspx.cs" Inherits="OSAG.member.ProgramSuccesses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

    <!-- Bootstrap Font Icon CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row pt-5 pb-5">
        <div class="col text-center">
            <h2>PROGRAM SUCCESSES</h2>
        </div>
    </div>

    <div class="top" style="margin-top: 15px;">
        <div class="successes px-5 pt-5">
            <div class="row">
                <!-- counter -->
                <div class="col-md-3 col-sm-6 bottom-margin text-center counter-section wow fadeInUp sm-margin-bottom-ten animated" data-wow-duration="300ms" style="visibility: visible; animation-duration: 300ms; animation-name: fadeInUp; color:black">
                    <i class="bi bi-cash-coin medium-icon"></i><span id="anim-number-pizza" class="counter-number"></span>
                    <span class="timer counter alt-font appear" data-to="980" data-speed="7000">
                        <asp:Label ID="lblScholarship" runat="server" Text="" ForeColor="Black"></asp:Label>
                    </span>
                    <span class="counter-title" style="color:black">Given in Scholarships</span>
                </div>
                <!-- end counter -->

                <!-- counter -->
                <div class="col-md-3 col-sm-6 bottom-margin text-center counter-section wow fadeInUp sm-margin-bottom-ten animated" data-wow-duration="600ms" style="color:black; visibility: visible; animation-duration: 600ms; animation-name: fadeInUp;">
                    <i class="bi bi-award medium-icon"></i>
                    <span class="timer counter alt-font appear" data-to="980" data-speed="7000">
                        <asp:Label ID="lblJandI" runat="server" Text="Label" ForeColor="Black"></asp:Label>
                    </span>
                    <span style="color:black"" class="counter-title">Jobs and Internship Opportunities Facilitated </span>
                </div>
                <!-- end counter -->

                <!-- counter -->
                <div class="col-md-3 col-sm-6 bottom-margin-small text-center counter-section wow fadeInUp xs-margin-bottom-ten animated" data-wow-duration="900ms" style="color:black; visibility: visible; animation-duration: 900ms; animation-name: fadeInUp;">
                    <i class="bi bi-building medium-icon"></i><span class="timer counter alt-font appear" data-to="810" data-speed="7000">
                        <asp:Label ID="lblCompanies" runat="server" Text="" ForeColor="Black"></asp:Label>
                    </span><span class="counter-title" style="color:black">Company Partners</span>
                </div>
                <!-- end counter -->

                <!-- counter -->
                <div class="col-md-3 col-sm-6 text-center counter-section wow fadeInUp animated" data-wow-duration="1200ms" style="color:black; visibility: visible; animation-duration: 1200ms; animation-name: fadeInUp;">
                    <i class="bi bi-person-fill medium-icon"></i>
                    <span class="timer counter alt-font appear" data-to="600" data-speed="7000">
                        <asp:Label ID="lblMembers" runat="server" Text="" ForeColor="Black"></asp:Label>
                    </span><span class="counter-title" style="color:black">Members</span>
                </div>
                <!-- end counter -->

            </div>
        </div>
    </div>
</asp:Content>
