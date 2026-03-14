<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs"
    Inherits="Stationery_Inventory.User.Checkout" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <!-- Page Header Start -->
        <div class="container-fluid bg-secondary mb-5">
            <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
                <h1 class="font-weight-semi-bold text-uppercase mb-3">Checkout</h1>
                <div class="d-inline-flex">
                    <p class="m-0"><a href="">Home</a></p>
                    <p class="m-0 px-2">-</p>
                    <p class="m-0">Checkout</p>
                </div>
            </div>
        </div>
        <!-- Page Header End -->


        <!-- Checkout Start -->
        <div class="container-fluid pt-5">
            <div class="row px-xl-5">
                <div class="col-lg-8">
                    <div class="mb-4">
                        <h4 class="font-weight-semi-bold mb-4">Payment & Shipping Details</h4>
                        <div class="row">
                            <div class="col-md-12 form-group">
                                <label>Name on Card</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="John Doe"
                                    Required="true"></asp:TextBox>
                            </div>
                            <div class="col-md-12 form-group">
                                <label>Full Shipping Address</label>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"
                                    placeholder="123 Street, New York, 10001" Required="true"></asp:TextBox>
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Card Number</label>
                                <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control"
                                    placeholder="1234 5678 9101 1121" Required="true" MaxLength="16"></asp:TextBox>
                            </div>
                            <div class="col-md-3 form-group">
                                <label>Expiry Date</label>
                                <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control" placeholder="MM/YY"
                                    Required="true"></asp:TextBox>
                            </div>
                            <div class="col-md-3 form-group">
                                <label>CVV Number</label>
                                <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control" placeholder="123"
                                    Required="true" MaxLength="4"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card border-secondary mb-5">
                        <div class="card-header bg-secondary border-0">
                            <h4 class="font-weight-semi-bold m-0">Order Total</h4>
                        </div>
                        <div class="card-body">
                            <h5 class="font-weight-medium mb-3">Products</h5>
                            <asp:Repeater ID="rCheckoutItem" runat="server">
                                <ItemTemplate>
                                    <div class="d-flex justify-content-between">
                                        <p>
                                            <%# Eval("ProductName") %> x <%# Eval("Quantity") %>
                                        </p>
                                        <p>Rs.<%# Eval("TotalPrice") %>
                                        </p>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <hr class="mt-0">
                            <div class="d-flex justify-content-between mb-3 pt-1">
                                <h6 class="font-weight-medium">Subtotal</h6>
                                <h6 class="font-weight-medium">Rs.<asp:Label ID="lblSubtotal" runat="server">
                                    </asp:Label>
                                </h6>
                            </div>
                            <div class="d-flex justify-content-between">
                                <h6 class="font-weight-medium">Shipping</h6>
                                <h6 class="font-weight-medium">Rs.<asp:Label ID="lblShipping" runat="server">
                                    </asp:Label>
                                </h6>
                            </div>
                        </div>
                        <div class="card-footer border-secondary bg-transparent">
                            <div class="d-flex justify-content-between mt-2">
                                <h5 class="font-weight-bold">Total</h5>
                                <h5 class="font-weight-bold">Rs.<asp:Label ID="lblTotal" runat="server"></asp:Label>
                                </h5>
                            </div>
                        </div>
                    </div>
                    <div class="card border-secondary mb-5">
                        <div class="card-header bg-secondary border-0">
                            <h4 class="font-weight-semi-bold m-0">Payment</h4>
                        </div>
                        <div class="card-body">
                            <!-- <div class="form-group">
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" name="payment" id="paypal">
                                    <label class="custom-control-label" for="paypal">Paypal</label>
                                </div>
                            </div> -->
                            <div class="form-group">
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" name="payment" id="directcheck">
                                    <label class="custom-control-label" for="directcheck">Cash on Delivery</label>
                                </div>
                            </div>
                            <div class="">
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" name="payment" id="banktransfer">
                                    <label class="custom-control-label" for="banktransfer">Bank Transfer</label>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer border-secondary bg-transparent">
                            <asp:Button ID="btnPlaceOrder" runat="server"
                                CssClass="btn btn-lg btn-block btn-primary font-weight-bold my-3 py-3"
                                Text="Place Order" OnClick="btnPlaceOrder_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Checkout End -->

    </asp:Content>