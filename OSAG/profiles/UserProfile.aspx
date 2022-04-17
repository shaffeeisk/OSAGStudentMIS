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
        <asp:ImageButton ID="imgProfile" runat="server" Height="100px" Width="100px" CssClass="img-thumbnail" 
            OnClick="imgProfile_Click" CausesValidation="false" />
        <br />
        <asp:Label ID="lblPFP" runat="server" Text="Upload Profile Picture (JPG/JPEG only)" Visible="false"></asp:Label>
        <asp:FileUpload ID="filePFP" runat="server" Visible="false" />
        <asp:Button ID="btnPFP" type="submit" Text="Upload" runat="server" CausesValidation="false" OnClick="btnPFP_Click" Visible="false"></asp:Button>
        <br />
        <% if (Session["UserType"].ToString() == "student")
            { %>
        
            <div class="col-lg-6 information">
                 <div class="col justify-content-center pt-3 d-grid mx-auto">
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtFirstName" runat="server" class="form-control pb-1" placeholder="First Name" aria-label="First Name"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator21"
                             ControlToValidate="txtFirstName"
                             Text="(Required)"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtLastName" runat="server" class="form-control pb-1" placeholder="Last Name" aria-label="Last Name"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator22"
                             ControlToValidate="txtLastName"
                             Text="(Required)"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtEmail" AutoCompleteType="Email" runat="server" class="form-control pb-1" placeholder="Email" aria-label="Email"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator1"
                             ControlToValidate="txtEmail"
                             Text="(Required)"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
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
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtMajor" runat="server" class="form-control pb-1" placeholder="Major" aria-label="Major"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator23"
                             ControlToValidate="txtMajor"
                             Text="(Required)"
                             runat="server" Enabled="false"/>
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtMinor" runat="server" class="form-control pb-1" placeholder="Minor" aria-label="Minor"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator2"
                             ControlToValidate="txtMinor"
                             Text="(Required)"
                             runat="server" Enabled="false"/>
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtPhone" onkeypress="return isNumberKey(event)" runat="server" class="form-control pb-1" placeholder="Phone Number" aria-label="Phone Number"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator3"
                             ControlToValidate="txtPhone"
                             Text="(Required)"
                             runat="server"/>
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtGpa" runat="server" class="form-control pb-1" placeholder="GPA" aria-label="GPA"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator10"
                             ControlToValidate="txtGpa"
                             Text="(Required)"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtClass" runat="server" class="form-control pb-1" placeholder="Class" aria-label="Class"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator19"
                             ControlToValidate="txtClass"
                             Text="(Required)"
                             runat="server" Enabled="false"/>
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine"
                                  Rows="10" Height="100" Width="200" placeholder="Please write CEO Statement" aria-label="Please write CEO Statement"></asp:TextBox>
                                  <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator11"
                                    ControlToValidate="txtBio"
                                    Text="(Required)"
                                    runat="server" />
                        </div>
                     </form>
                 </div>
            </div>
        <br />
        <br />
        <div class="row">
          <div class="col justify-content-center d-grid pt-5 pb-5 mx-auto">
              <asp:Button ID="btnUpdate" class="btn btn-primary" runat="server" Text="Save Changes" CausesValidation="false" OnClick="btnUpdate_Click" />
          </div>
        </div>
        <br />
        <br />
        <div class="row">
          <div class="col justify-content-center d-grid pt-5 pb-5 mx-auto">
              <asp:FileUpload ID="fileUpload" class="btn btn-primary" runat="server" />
              <br />
              <asp:Button ID="btnUpload" class="btn btn-primary" type="submit" Text="Upload Resume" runat="server" CausesValidation="false" OnClick="btnUpload_Click"></asp:Button>
          </div>
        </div>
        <br />
        <br />
        <div class="row">
          <div class="col justify-content-center d-grid pt-5 pb-5 mx-auto">
              <asp:Button ID="btnDownloadResume" class="btn btn-primary" runat="server" Text="Try to download student resume (if exists)" OnClick="btnDownloadResume_Click" CausesValidation="false" />
          </div>
        </div>       
        
        <% } %>

        <% if (Session["UserType"].ToString() == "member")
            { %>

        <div class="col-lg-6 information">
                 <div class="col justify-content-center pt-3 d-grid mx-auto">
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="mtxtFirstName" runat="server" class="form-control pb-1" placeholder="First Name" aria-label="First Name"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator9"
                             ControlToValidate="txtFirstName"
                             Text="(Required)"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="mtxtLastName" runat="server" class="form-control pb-1" placeholder="Last Name" aria-label="Last Name"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator12"
                             ControlToValidate="txtLastName"
                             Text="(Required)"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtMemberEmail" AutoCompleteType="Email" runat="server" class="form-control pb-1" placeholder="Email" aria-label="Email"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator13"
                             ControlToValidate="txtEmail"
                             Text="(Required)"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtState" runat="server" class="form-control pb-1" placeholder="State" aria-label="State"></asp:TextBox>
                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator25"
                                ControlToValidate="txtState"
                                Text="(Required)"
                                runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtCity" runat="server" class="form-control pb-1" placeholder="City" aria-label="City"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator26"
                             ControlToValidate="txtCity"
                             Text="(Required)"
                             runat="server" Enabled="false"/>
                        </div>
                     <form class="form-horizontal" role="form">
                        <asp:TextBox ID="txtMemberGrad" runat="server" class="form-control pb-1" placeholder="Graduation Date" aria-label="Graduation Date"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator27"
                             ControlToValidate="txtMemberGrad"
                             Text="(Required)"
                             runat="server" />
                             <asp:CompareValidator
                             ID="CompareValidator1"
                             ControlToValidate="txtMemberGrad"
                             Text="Use Date Format"
                             Operator="DataTypeCheck"
                             Type="Date"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtMemberMajor" onkeypress="return isNumberKey(event)" runat="server" class="form-control pb-1" placeholder="Major" aria-label="Major"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator28"
                             ControlToValidate="txtMemberMajor"
                             Text="(Required)"
                             runat="server" Enabled="false"/>
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtMemberMinor" runat="server" class="form-control pb-1" placeholder="Minor" aria-label="Minor"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator29"
                             ControlToValidate="txtMemberMinor"
                             Text="(Required)"
                             runat="server" Enabled="false"/>
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtPosition" runat="server" class="form-control pb-1" placeholder="Position Title" aria-label="Position Title"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator30"
                             ControlToValidate="txtPosition"
                             Text="(Required)"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtMemberPhone" onkeypress="return isNumberKey(event)" runat="server" class="form-control pb-1" placeholder="Phone Number" aria-label="Phone Number"></asp:TextBox>
                             <asp:RequiredFieldValidator
                             ID="RequiredFieldValidator31"
                             ControlToValidate="txtMemberPhone"
                             Text="(Required)"
                             runat="server" />
                        </div>
                     <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-left: auto; margin-right: auto; text-align: center;">
                             <asp:TextBox ID="txtMemberBio" runat="server" TextMode="MultiLine"
                                  Rows="10" Height="100" Width="200" placeholder="Please write Bio" aria-label="Please write Bio"></asp:TextBox>
                                  <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator32"
                                    ControlToValidate="txtMemberBio"
                                    Text="(Required)"
                                    runat="server" />
                        </div>
                     </form>
                 </div>
            </div>
        <br />
        <br />
        <div class="row">
          <div class="col justify-content-center d-grid pt-5 pb-5 mx-auto">
              <asp:Button ID="btnUpdate2" class="btn btn-primary" runat="server" Text="Save Changes" CausesValidation="false" OnClick="btnUpdate_Click" />
          </div>
        </div>
        <%--<asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
        <asp:TextBox ID="mtxtFirstName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator4"
            ControlToValidate="txtFirstName"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="lblLastName" runat="server" Text="   Last Name"></asp:Label>
        <asp:TextBox ID="mtxtLastName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator5"
            ControlToValidate="txtLastName"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="lblMemberEmail" runat="server" Text="Member Email"></asp:Label>
        <asp:TextBox ID="txtMemberEmail" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator6"
            ControlToValidate="txtMemberEmail"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="lblState" runat="server" Text="Member State"></asp:Label>
        <asp:TextBox ID="txtState" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator7"
            ControlToValidate="txtState"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="lblCity" runat="server" Text="Member City"></asp:Label>
        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator8"
            ControlToValidate="txtCity"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="Label11" runat="server" Text="GradDate"></asp:Label>
        <asp:TextBox ID="txtMemberGrad" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator14"
            ControlToValidate="txtMemberGrad"
            Text="(Required)"
            runat="server" />
        <asp:CompareValidator
            ID="CompareValidator2"
            ControlToValidate="txtMemberGrad"
            Text="Use Date Format"
            Operator="DataTypeCheck"
            Type="Date"
            runat="server" />
        <br />
        <asp:Label ID="Label12" runat="server" Text="Majors"></asp:Label>
        <asp:TextBox ID="txtMemberMajor" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator15"
            ControlToValidate="txtMemberMajor"
            Text="(Required)"
            runat="server" Enabled="false" />
        <br />
        <asp:Label ID="Label17" runat="server" Text="Minors"></asp:Label>
        <asp:TextBox ID="txtMemberMinor" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator20"
            ControlToValidate="txtMemberMinor"
            Text="(Required)"
            runat="server" Enabled="false" />
        <br />
        <asp:Label ID="Label13" runat="server" Text="Position Title"></asp:Label>
        <asp:TextBox ID="txtPosition" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator16"
            ControlToValidate="txtPosition"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="Label14" runat="server" Text="Phone"></asp:Label>
        <asp:TextBox ID="txtMemberPhone" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator17"
            ControlToValidate="txtMemberPhone"
            Text="(Required)"
            runat="server" />
        <br />
        <asp:Label ID="Label15" runat="server" Text="Bio"></asp:Label>
        <asp:TextBox ID="txtMemberBio" TextMode="MultiLine"
            Rows="10" Height="100" Width="200" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator18"
            ControlToValidate="txtMemberBio"
            Text="(Required)"
            runat="server" />--%>
       
        

        <% } %>
       
</asp:Content>
