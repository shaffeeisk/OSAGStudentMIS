<%--Member Home Page--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="MemberHome.aspx.cs" Inherits="OSAG.homepages.MemberHome" %>
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
</asp:Content>
