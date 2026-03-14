<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs"
    Inherits="Stationery_Inventory.User.Cart" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <!-- Page Header Start -->
        <div class="container-fluid bg-secondary mb-5">
            <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
                <h1 class="font-weight-semi-bold text-uppercase mb-3">Shopping Cart</h1>
                <div class="d-inline-flex">
                    <p class="m-0"><a href="">Home</a></p>
                    <p class="m-0 px-2">-</p>
                    <p class="m-0">Shopping Cart</p>
                </div>
            </div>
        </div>
        <!-- Page Header End -->


        <!-- Cart Start -->
        <div class="container-fluid pt-5">
            <div class="row px-xl-5">
                <div class="col-lg-8 table-responsive mb-5">
                    <table class="table table-bordered text-center mb-0">
                        <thead class="bg-secondary text-dark">
                            <tr>
                                <th>Products</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody class="align-middle">
                            <asp:Repeater ID="rCartItem" runat="server" OnItemCommand="rCartItem_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td class="align-middle"><img
                                                src='<%# Stationery_Inventory.Utils.getImageUrl(Eval("ImageUrl")) %>'
                                                alt="" style="width: 50px;">
                                            <%# Eval("ProductName") %>
                                        </td>
                                        <td class="align-middle">Rs.<%# Eval("Price") %>
                                        </td>
                                        <td class="align-middle">
                                            <div class="input-group quantity mx-auto" style="width: 100px;">
                                                <div class="input-group-btn">
                                                    <asp:LinkButton ID="lbMinus" runat="server" CommandName="minus"
                                                        CommandArgument='<%# Eval("ProductId") %>'
                                                        CssClass="btn btn-sm btn-primary btn-minus">
                                                        <i class="fa fa-minus"></i>
                                                    </asp:LinkButton>
                                                </div>
                                                <asp:TextBox ID="txtQuantity" runat="server"
                                                    Text='<%# Eval("Quantity") %>'
                                                    CssClass="form-control form-control-sm bg-secondary text-center">
                                                </asp:TextBox>
                                                <div class="input-group-btn">
                                                    <asp:LinkButton ID="lbPlus" runat="server" CommandName="plus"
                                                        CommandArgument='<%# Eval("ProductId") %>'
                                                        CssClass="btn btn-sm btn-primary btn-plus">
                                                        <i class="fa fa-plus"></i>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="align-middle">Rs.<%# Eval("TotalPrice") %>
                                        </td>
                                        <td class="align-middle">
                                            <asp:LinkButton ID="lbRemove" runat="server" CommandName="remove"
                                                CommandArgument='<%# Eval("ProductId") %>'
                                                CssClass="btn btn-sm btn-primary">
                                                <i class="fa fa-times"></i>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="col-lg-4">
                    <form class="mb-5" action="">
                        <div class="input-group">
                            <input type="text" class="form-control p-4" placeholder="Coupon Code">
                            <div class="input-group-append">
                                <button class="btn btn-primary">Apply Coupon</button>
                            </div>
                        </div>
                    </form>
                    <div class="card border-secondary mb-5">
                        <div class="card-header bg-secondary border-0">
                            <h4 class="font-weight-semi-bold m-0">Cart Summary</h4>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-3 pt-1">
                                <h6 class="font-weight-medium">Subtotal</h6>
                                <h6 class="font-weight-medium">Rs.<asp:Label ID="lblSubtotal" runat="server"
                                        Text="0.00"></asp:Label>
                                </h6>
                            </div>
                            <div class="d-flex justify-content-between">
                                <h6 class="font-weight-medium">Shipping</h6>
                                <h6 class="font-weight-medium">Rs.<asp:Label ID="lblShipping" runat="server"
                                        Text="0.00"></asp:Label>
                                </h6>
                            </div>
                        </div>
                        <div class="card-footer border-secondary bg-transparent">
                            <div class="d-flex justify-content-between mt-2">
                                <h5 class="font-weight-bold">Total</h5>
                                <h5 class="font-weight-bold">Rs.<asp:Label ID="lblTotal" runat="server" Text="0.00">
                                    </asp:Label>
                                </h5>
                            </div>
                            <a href="Checkout.aspx" class="btn btn-block btn-primary my-3 py-3">Proceed To Checkout</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Cart End -->

    </asp:Content>