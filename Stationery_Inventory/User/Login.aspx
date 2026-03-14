<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Stationery_Inventory.User.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function() {
            var url = window.location.href;
            document.getElementById("navbarCollapse").querySelector("a[href='Login.aspx']").className += " active";
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">Login</h1>
            <div class="d-inline-flex">
                <p class="m-0"><a href="Default.aspx">Home</a></p>
                <p class="m-0 px-2">-</p>
                <p class="m-0">Login</p>
            </div>
        </div>
    </div>
    <!-- Page Header End -->

    <!-- Login Start -->
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">Signin to Your Account</span></h2>
        </div>
        <div class="row px-xl-5 justify-content-center">
            <div class="col-lg-6 mb-5">
                <div class="contact-form">
                    <asp:Label ID="lblMsg" runat="server" Visible="False"></asp:Label>
                    <div class="control-group mb-4">
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username" required="required"></asp:TextBox>
                        <p class="help-block text-danger"></p>
                    </div>
                    <div class="control-group mb-4">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password" required="required"></asp:TextBox>
                        <p class="help-block text-danger"></p>
                    </div>
                    <div>
                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary py-2 px-4" OnClick="btnLogin_Click" />
                        <span class="ml-3">Don't have an account? <a href="Registration.aspx">Register Here</a></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Login End -->
</asp:Content>
