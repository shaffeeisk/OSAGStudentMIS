<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Home.Master" AutoEventWireup="true" CodeBehind="OleSchoolScholarship.aspx.cs" Inherits="OSAG.student.OleSchoolScholarship" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Ole School Scholarship Fund</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    

    <div class="container">
        <div class="p-5 text-center bg-image"
            style="background-image: url(/_images/carousel/carousel3.png); background-size: cover; height: 400px;">
        </div>
    </div>

    <div class="container pb-5">

        <div class="row">
            <div class="col-lg-6 offset-lg-3 text-center pt-5 pb-5">
                <h2 class="display-5">APPLY TODAY</h2>
                <h6 class="display-6">Deadline: May 31, 2022</h6>
            </div>
        </div>

        <div class="row">
            <div class="col-4 offset-lg-2 pt-3 pb-2">
                <h5>The Ole School Scholarship Fund awarded to:</h5>
                <ul class="scholarshiplist">
                    <li>1 scholarship to an <u>incoming freshman</u></li>
                    <li>1 scholarship to a <u>current JMU student</u></li>
                </ul>

                <br>

                <h5>If you would like to apply, you must submit:</h5>
                <ul class="scholarshiplist">
                    <li>Resume</li>
                    <li>Current Transcript</li>
                    <li>500 Word Essay (Describe your concept of diversity, and what experiences have you had that inform your thoughts)</li>
                    <li>(Optional): An email to <a class="email" href="mailto: mooregems@aol.com">mooregems@aol.com</a> <strong>OR</strong> mail to:</li>
                </ul>
                <h5 class="offset-lg-3">Lesa Moore
                        <br>
                    7303 Dominion Drive
                        <br>
                    Oxon Hill, MD 20745
                </h5>
            </div>


            <div id="scholarshipcard" class="card col-lg-5 offset-lg-1 scholarship-card" style="width: 25rem;">
                <div class="scholarship-card-header text-center pt-4">
                    <h4 class="applynow">Apply Now</h4>
                </div>

                <div class="scholarship-card-body pt-2" style="width: 25rem; margin-left: auto; margin-right: auto; text-align:center;">
                    <p>Would you like to apply?</p>
                    <div>
                        <asp:RadioButton ID="rdoYes" AutoPostBack="true" GroupName="YesNo" runat="server" OnCheckedChanged="rdoYesNo_CheckedChanged" />
                        <label class="form-check-label" for="twoFactorOn">Yes</label>
                    </div>

                    <div class="pb-4">
                        <asp:RadioButton ID="rdoNo" AutoPostBack="true" GroupName="YesNo" runat="server" OnCheckedChanged="rdoYesNo_CheckedChanged" />
                        <label class="form-check-label" for="twoFactorOff">No</label>
                    </div>

                    <div id="divApply" runat="server" visible="false">
                        <p>Upload Resume</p>
                        <div class="input-group" style="width: 29.7rem; margin-left: auto; margin-right: auto">
                            <asp:FileUpload ID="fileTranscript" class="form-control" runat="server" />
                        </div>
                        <p>
                            <asp:Label ID="lblTStatus" ForeColor="Red" runat="server" Text=" "></asp:Label>
                        </p>
                        <p>Upload Essay</p>
                        <div class="input-group" style="width: 29.7rem; margin-left: auto; margin-right: auto">
                            <asp:FileUpload ID="fileEssay" class="form-control" runat="server" />
                        </div>
                        <p class="pb-2">
                            <asp:Label ID="lblEStatus" ForeColor="Red" runat="server" Text=" "></asp:Label>
                        </p>
                        <asp:Button ID="btnSubmit" class="btn btn-primary" runat="server" Text="SUBMIT" OnClick="btnSubmit_Click" />
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
