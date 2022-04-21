<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OSAG.homepages.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!--Banner starts-->
        <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" style="height: auto;">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="/_images/carousel/carousel1.png" class="d-block w-100 h-20" alt="...">
                </div>

                <div class="carousel-item">
                    <img src="/_images/carousel/carousel2.png" class="d-block w-100" alt="...">
                </div>
                <%if (Session["UserType"].ToString() == "student")
                    { %>
                <div class="carousel-item">
                    <a href="/student/OleSchoolScholarship.aspx">
                        <img src="/_images/carousel/carousel3.png" class="d-block w-100" alt="..."></a>
                </div>
                <% } %>
                <div class="carousel-item">
                    <img src="/_images/carousel/carousel4.png" class="d-block w-100" alt="...">
                </div>

                <div class="carousel-item">
                    <img src="/_images/carousel/carousel5.png" class="d-block w-100" alt="...">
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
        </div>


        <div class="container text-center">
            <div class="row">
                <h1>WELCOME BACK,
                        <asp:Label ID="lblName" runat="server" Text=""></asp:Label></h1>
            </div>
        </div>

        <%if (Session["UserType"].ToString() == "student")
            { %>
        <section class="features-icons text-center pt-5">
            <div class="container pt-4 pb-3">
                <div class="row">


                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/internships/Internships.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-graduation-cap m-auto pb-5"></i></div>
                                <h5>FIND<br>
                                    INTERNSHIPS</h5>
                            </div>
                        </a>
                    </div>



                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/opportunities/Opportunities.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="far fa-lightbulb m-auto pb-5"></i></div>
                                <h5>FIND<br>
                                    OPPORTUNITIES</h5>
                            </div>
                        </a>
                    </div>



                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/jobs/Jobs.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-suitcase m-auto pb-5"></i></div>
                                <h5>FIND<br>
                                    JOBS</h5>
                            </div>
                        </a>
                    </div>



                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/student/Bookmarks.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="far fa-bookmark m-auto pb-5"></i></div>
                                <h5>MY<br>
                                    BOOKMARKS</h5>
                            </div>
                        </a>
                    </div>



                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/student/ViewApplications.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-list m-auto pb-5"></i></div>
                                <h5>MY<br>
                                    APPLICATIONS</h5>
                            </div>
                        </a>
                    </div>



                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/profiles/ListUsers.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-search m-auto pb-5"></i></div>
                                <h5>USER<br>
                                    SEARCH</h5>
                            </div>
                        </a>
                    </div>


                </div>
            </div>
        </section>
        <%}
            else if (Session["MemberType"].ToString() == "1")
            {%>

        <section class="features-icons text-center pt-5">
            <div class="container pt-5 pb-3">
                <div class="row">

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/admin/CreateInternship.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-graduation-cap m-auto pb-5"></i></div>
                                <h5>ADD<br>
                                    INTERNSHIPS</h5>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/admin/CreateOpportunity.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="far fa-lightbulb m-auto pb-5"></i></div>
                                <h5>ADD
                                <br>
                                    OPPORTUNITIES</h5>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/admin/CreateJob.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-suitcase m-auto pb-5"></i></div>
                                <h5>ADD<br>
                                    JOBS</h5>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/admin/CreateAnnouncement.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-bullhorn m-auto pb-5"></i></div>
                                <h5>ADD ANNOUNCEMENT</h5>
                            </div>
                        </a>
                    </div>


                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/admin/ApproveRegistration.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-user-check m-auto pb-5"></i></div>
                                <h5>APPROVE REGISTRATIONS</h5>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/admin/AssignMentor.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-hand-point-up m-auto pb-5"></i></div>
                                <h5>ASSIGN
                                <br>
                                    MENTOR</h5>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <% } %>

        <% else if (Session["MemberType"].ToString() == "2" || Session["MemberType"].ToString() == "3")
            { %>
        <section class="features-icons text-center pt-5">
            <div class="container pt-4 pb-3">
                <div class="row">

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/internships/Internships.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-graduation-cap m-auto pb-5"></i></div>
                                <h5>VIEW<br>
                                    INTERNSHIPS</h5>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/opportunities/Opportunities.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="far fa-lightbulb m-auto pb-5"></i></div>
                                <h5>VIEW<br>
                                    OPPORTUNITIES</h5>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/jobs/Jobs.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-suitcase m-auto pb-5"></i></div>
                                <h5>VIEW<br>
                                    JOBS</h5>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/profiles/ListUsers.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-search m-auto pb-5"></i></div>
                                <h5>USER<br>
                                    SEARCH</h5>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/member/ViewMentorships.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-list m-auto pb-5"></i></div>
                                <h5>VIEW MY
                                <br>
                                    MENTORSHIPS</h5>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-2">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/member/ViewStudentInterests.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="far fa-bookmark m-auto pb-5"></i></div>
                                <h5>VIEW STUDENT<br>
                                    INTERESTS</h5>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <% }
            else
            { %>
        <section class="features-icons text-center pt-5">
            <div class="container pt-4 pb-3">
                <div class="row">
                    <div class="col-lg-3" style="margin-left: auto; margin-right: auto;">
                        <a style="width: auto; text-decoration: none; color: #73637f;" href="/member/ProgramSuccesses.aspx">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex"><i class="fas fa-search m-auto pb-5"></i></div>
                                <h5 style="text-align: center">VIEW PROGRAM<br>
                                    SUCCESSES</h5>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <%} %>

        <div class="container text-center pt-5 pb-3">
            <h3>ANNOUNCEMENTS</h3>
        </div>

        <asp:GridView ID="gv_Announcements" runat="server"
            DataSourceID="sqlsrcAnnouncements"
            AutoGenerateColumns="false"
            AllowPaging="true"
            PageSize="3"
            CellPadding="25"
            DataKeyNames="AnnouncementID"
            HorizontalAlign="Center"
            ShowHeaderWhenEmpty="true"
            CssClass="card-body border-0 shadow p-3 mb-2 bg-body rounded shadow-on-hover"
            PagerStyle-CssClass="pager"
            HeaderStyle-Font-Names="Roboto"
            RowStyle-Font-Names="Roboto"
            ForeColor="black" RowStyle-BackColor="#d0c2da" AlternatingRowStyle-BackColor="#F7F7F7">
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="4" FirstPageText="<<" LastPageText=">>" />
            <PagerStyle HorizontalAlign="Center" Font-Names="Roboto" Font-Size="Large" Font-Bold="true" ForeColor="#73637F" Height="1" />
            <Columns>
                <asp:BoundField ReadOnly="true" HeaderText="Sent" DataField="DateCreated" DataFormatString="{0:MM/dd/yyyy HH:mm tt}" ItemStyle-Wrap="true" ItemStyle-Width="110" />
                <asp:BoundField ReadOnly="true" HeaderText="Subject" DataField="Header" ItemStyle-Font-Bold="true" />
                <asp:BoundField ReadOnly="true" HeaderText="Details" DataField="Body" />
                <asp:HyperLinkField HeaderText="Link" DataNavigateUrlFields="Link" DataTextField="Link" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sqlsrcAnnouncements" runat="server"
            ConnectionString="<%$ ConnectionStrings:OSAG %>"></asp:SqlDataSource>

    </div>
</asp:Content>
