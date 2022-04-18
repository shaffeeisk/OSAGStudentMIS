<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UnapprovedUserProfile.aspx.cs" Inherits="OSAG.profiles.UnapprovedUserProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
            <script language="Javascript">
                function isNumberKey(evt) {
                    var charCode = (evt.which) ? evt.which : evt.keyCode;
                    if (charCode > 31 && (charCode < 48 || charCode > 57))
                        return false;
                    return true;
                }
            </script>
            <asp:Button ID="btn_logOut" runat="server" OnClick="btn_logOut_Click" Text="LOG OUT" CausesValidation="false" />
            User Profile not yet approved. Your Access is limited to editing your profile.
            <br />
            <br />
            <br />
            <asp:Label ID="lblApprove" runat="server" Text=""></asp:Label>
            <br />
            <% if (Session["UserType"].ToString() == "student")
                { %>
            <asp:Label ID="Label1" runat="server" Text="First Name"></asp:Label>
            <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="reqField"
                ControlToValidate="txtFirstName"
                Text="(Required)"
                runat="server" />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Last Name"></asp:Label>
            <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator1"
                ControlToValidate="txtLastName"
                Text="(Required)"
                runat="server" />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Email"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" AutoCompleteType="Email"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator2"
                ControlToValidate="txtEmail"
                Text="(Required)"
                runat="server" />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Grad Date"></asp:Label>
            <asp:TextBox ID="txtGradDate" TextMode="Date" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator3"
                ControlToValidate="txtGradDate"
                Text="(Required)"
                runat="server" />
            <asp:CompareValidator
                ID="CompareValidator1"
                ControlToValidate="txtGradDate"
                Text="Use Date Format"
                Operator="DataTypeCheck"
                Type="Date"
                runat="server" />
            <br />
            <asp:Label ID="Label6" runat="server" Text="Majors"></asp:Label>
            <asp:TextBox ID="txtMajor" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator10"
                ControlToValidate="txtMajor"
                Text="(Required)"
                runat="server" Enabled="false" />
            <br />
            <asp:Label ID="Label16" runat="server" Text="Minors"></asp:Label>
            <asp:TextBox ID="txtMinor" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator19"
                ControlToValidate="txtMinor"
                Text="(Required)"
                runat="server" Enabled="false" />
            <br />
            <asp:Label ID="Label8" runat="server" Text="Phone #"></asp:Label>
            <asp:TextBox ID="txtPhone" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator11"
                ControlToValidate="txtPhone"
                Text="(Required)"
                runat="server" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
                runat="server"
                ErrorMessage="Must be less than 15 digits"
                ControlToValidate="txtPhone"
                ValidationExpression="^[0-9]{0,15}$">
            </asp:RegularExpressionValidator>
            <br />
            <asp:Label ID="Label9" runat="server" Text="GPA"></asp:Label>
            <asp:TextBox ID="txtGpa" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator12"
                ControlToValidate="txtGpa"
                Text="(Required)"
                runat="server" />
            <br />
            <asp:Label ID="Label10" runat="server" Text="Class"></asp:Label>
            <asp:TextBox ID="txtClass" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator13"
                ControlToValidate="txtClass"
                Text="(Required)"
                runat="server" />
            <br />
            <asp:Label ID="Label7" runat="server" Text="Bio"></asp:Label>
            <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine"
                Rows="10" Height="100" Width="200"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator9"
                ControlToValidate="txtBio"
                Text="(Required)"
                runat="server" />
            <br />
            <br />
            <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CausesValidation="false" OnClick="btnUpdate_Click" />
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="Upload your Resume"></asp:Label>
            <asp:FileUpload ID="fileUpload" runat="server" />
            <asp:Button ID="btnUpload" type="submit" Text="Upload" runat="server" CausesValidation="false" OnClick="btnUpload_Click"></asp:Button>
            <br />
            <asp:Button ID="btnDownloadResume" runat="server" Text="Try to download student resume (if exists)" OnClick="btnDownloadResume_Click" CausesValidation="false" />
            <% } %>

            <% if (Session["UserType"].ToString() == "member")
                { %>
            <asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
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
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                runat="server"
                ErrorMessage="Must be less than 15 digits"
                ControlToValidate="txtMemberPhone"
                ValidationExpression="^[0-9]{0,15}$">
            </asp:RegularExpressionValidator>
            <br />
            <asp:Label ID="Label15" runat="server" Text="Bio"></asp:Label>
            <asp:TextBox ID="txtMemberBio" TextMode="MultiLine"
                Rows="10" Height="100" Width="200" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator18"
                ControlToValidate="txtMemberBio"
                Text="(Required)"
                runat="server" />
            <br />
            <br />
            <asp:Button ID="btnUpdate2" runat="server" Text="Save Changes" CausesValidation="false" OnClick="btnUpdate_Click" />

            <% } %>
    </form>
</body>
</html>
