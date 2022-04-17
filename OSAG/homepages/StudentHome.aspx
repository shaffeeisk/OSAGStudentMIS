<%--Student home page--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="StudentHome.aspx.cs" Inherits="OSAG.homepages.LoggedInHomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--Banner starts-->
    <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="/_images/carousel/carousel1.png" class="d-block w-100 h-20" alt="...">
            </div>

            <div class="carousel-item">
                <img src="/_images/carousel/carousel2.png" class="d-block w-100" alt="...">
            </div>

            <div class="carousel-item">
                <img src="/_images/carousel/carousel3.png" class="d-block w-100" alt="...">
            </div>

            <div class="carousel-item">
                <img src="/_images/carousel/carousel4.png" class="d-block w-100" alt="...">
            </div>

            <div class="carousel-item">
                <img src="/_images/carousel/carousel5.png" class="d-block w-100" alt="...">
            </div>

        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
    <!--Banner ends-->

    <!--Internships feature starts-->
    <div class="container px-5 py-5" id="hanging-iconsInternship">
        <h2 class="jobs pb-2 border-bottom">INTERNSHIPS</h2>

        <div class="row g-4 py-5 row-cols-1 row-cols-lg-3">
            <div class="col d-flex align-items-start">
                <div class="icon-square bg-light text-dark flex-shrink-0 me-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark" viewBox="0 0 16 16">
                        <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z" />
                    </svg>
                </div>

                <div>
                    <h6 class="type">Full-Time, Internship</h6>
                    <h5 class="internshiptitle">Claims Legal Intern - Summer 2022</h5>
                    <br>
                    <p>
                        Markel Corporation
                                <br>
                        Richmond, VA
                    </p>

                </div>
            </div>

            <div class="col d-flex align-items-start">
                <div class="icon-square bg-light text-dark flex-shrink-0 me-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark" viewBox="0 0 16 16">
                        <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z" />
                    </svg>
                </div>

                <div>
                    <h6 class="type">Full-Time, Internship</h6>
                    <h5 class="internshiptitle">EY - Launch Intern - Summer 2022</h5>
                    <br>
                    <p>
                        EY LLP
                                <br>
                        United States
                    </p>
                </div>
            </div>

            <div class="col d-flex align-items-start">
                <div class="icon-square bg-light text-dark flex-shrink-0 me-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark" viewBox="0 0 16 16">
                        <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z" />
                    </svg>
                </div>

                <div>
                    <h6 class="type">Full-Time, Internship</h6>
                    <h5 class="internshiptitle">Internal Audit Intern - Summer 2022</h5>
                    <br>
                    <p>
                        Freddie Mac
                                <br>
                        McLean, VA
                    </p>
                </div>
            </div>
        </div>

        <div class="col d-flex align-items-start">
            <p>
                See more
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z" />
                        </svg>
            </p>
        </div>



    </div>
    <!--Internships feature ends-->


    <!--Jobs feature starts-->
    <div class="container px-5 py-5" id="hanging-iconsJobs">
        <h2 class="jobs pb-2 border-bottom">JOBS</h2>

        <div class="row g-4 py-5 row-cols-1 row-cols-lg-3">
            <div class="col d-flex align-items-start">
                <div class="icon-square bg-light text-dark flex-shrink-0 me-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark" viewBox="0 0 16 16">
                        <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z" />
                    </svg>
                </div>

                <div>
                    <h6 class="type">Full-Time, Job</h6>
                    <h5 class="jobtitle">Accountaing Analyst, Close, Controls,
                                <br>
                        and Reporting</h5>
                    <br>
                    <p>
                        Markel Corporation
                                <br>
                        Richmond, VA
                    </p>

                </div>
            </div>

            <div class="col d-flex align-items-start">
                <div class="icon-square bg-light text-dark flex-shrink-0 me-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark" viewBox="0 0 16 16">
                        <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z" />
                    </svg>
                </div>

                <div>
                    <h6 class="type">Full-Time, Job</h6>
                    <h5 class="jobtitle">Fund Operations Specialist - NEW00484</h5>
                    <br>
                    <p>
                        EY LLP
                                <br>
                        United States
                    </p>
                </div>
            </div>

            <div class="col d-flex align-items-start">
                <div class="icon-square bg-light text-dark flex-shrink-0 me-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark" viewBox="0 0 16 16">
                        <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z" />
                    </svg>
                </div>

                <div>
                    <h6 class="type">Full-Time, Job</h6>
                    <h5 class="jobtitle">EY - Consulting - Enterprise Risk Staff</h5>
                    <br>
                    <p>
                        Freddie Mac
                                <br>
                        McLean, VA
                    </p>
                </div>
            </div>
        </div>

        <div class="col d-flex align-items-start">
            <p>
                See more
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z" />
                        </svg>
            </p>
        </div>



    </div>
    <!--Jobs feature ends-->

    <!--Opportunities starts-->

    <div class="container px-5 py-4">
        <h2 class="jobs pb-2 border-bottom">OPPORTUNITIES</h2>

        <div class="row">
            <div class="col justify-content-center d-grid border-bottom py-3">
                <h4 class="opportunity">Finding Part-Time Jobs</h4>
                <br>
                <h6 class="opportunitydetails">Date: April 5, 2022</h6>
                <h6 class="opportunitydetails">Time: 2:30pm - 4:30pm EDT</h6>
                <h6 class="opportunitydetails">Location: Student Success Center 3240</h6>
                <br>
                <p>Learn strategies for identifying and securing jobs on campus and in the area during this workshop.</p>
            </div>
        </div>
    </div>

    <!--Opportunities feature ends-->

</asp:Content>
