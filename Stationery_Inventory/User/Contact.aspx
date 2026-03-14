<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs"
    Inherits="Stationery_Inventory.User.Contact" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <!-- Page Header Start -->
        <div class="container-fluid bg-secondary mb-5">
            <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
                <h1 class="font-weight-semi-bold text-uppercase mb-3">Contact Us</h1>
                <div class="d-inline-flex">
                    <p class="m-0"><a href="">Home</a></p>
                    <p class="m-0 px-2">-</p>
                    <p class="m-0">Contact</p>
                </div>
            </div>
        </div>
        <!-- Page Header End -->


        <!-- Contact Start -->
        <div class="container-fluid pt-5">
            <div class="text-center mb-4">
                <h2 class="section-title px-5"><span class="px-2">Contact For Any Queries</span></h2>
            </div>
            <div class="row px-xl-5">
                <div class="col-lg-7 mb-5">
                    <div class="contact-form">
                        <div id="success"></div>
                        <div>
                            <div class="control-group">
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name"
                                    required="required"></asp:TextBox>
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="control-group">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                    placeholder="Your Email" required="required" TextMode="Email"></asp:TextBox>
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="control-group">
                                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"
                                    placeholder="Subject" required="required"></asp:TextBox>
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="control-group">
                                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" Rows="6"
                                    TextMode="MultiLine" placeholder="Message" required="required"></asp:TextBox>
                                <p class="help-block text-danger"></p>
                            </div>
                            <div>
                                <asp:Button ID="btnSendMessage" runat="server" CssClass="btn btn-primary py-2 px-4"
                                    Text="Send Message" OnClick="btnSendMessage_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 mb-5">
                    <h5 class="font-weight-semi-bold mb-3">Get In Touch</h5>
                    <p>At Enote, we believe great ideas start with the right tools. Explore our collection of premium
                        stationery designed to support learning, creativity, and productivity.</p>
                    <div class="d-flex flex-column mb-3">
                        <h5 class="font-weight-semi-bold mb-3">Store 1</h5>
                        <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>GF-12 City Center, Science
                            City, Ahmedabad</p>
                        <p class="mb-2"><i class="fa fa-envelope text-primary mr-3"></i>enote@example.com</p>
                        <p class="mb-2"><i class="fa fa-phone-alt text-primary mr-3"></i>+91 9876543210</p>
                    </div>
                    <div class="d-flex flex-column">
                        <h5 class="font-weight-semi-bold mb-3">Store 2</h5>
                        <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>1st Floor, Iconic Shyamal,
                            Ahmedabad</p>
                        <p class="mb-2"><i class="fa fa-envelope text-primary mr-3"></i>enote@example.com</p>
                        <p class="mb-0"><i class="fa fa-phone-alt text-primary mr-3"></i>+91 2345678980</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contact End -->


    </asp:Content>