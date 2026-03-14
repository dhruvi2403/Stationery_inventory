<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs"
    Inherits="Stationery_Inventory.User.Shop" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
            .custom-control label {
                margin-left: 5px;
                cursor: pointer;
            }

            .custom-control input[type="radio"] {
                cursor: pointer;
            }
        </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <!-- Page Header Start -->
        <div class="container-fluid bg-secondary mb-5">
            <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
                <h1 class="font-weight-semi-bold text-uppercase mb-3">Our Shop</h1>
                <div class="d-inline-flex">
                    <p class="m-0"><a href="Default.aspx">Home</a></p>
                    <p class="m-0 px-2">-</p>
                    <p class="m-0">Shop</p>
                </div>
            </div>
        </div>
        <!-- Page Header End -->

        <!-- Shop Start -->
        <div class="container-fluid pt-5">
            <div class="row px-xl-5">
                <!-- Shop Sidebar Start -->
                <div class="col-lg-3 col-md-12">
                    <!-- Category Start -->
                    <div class="border-bottom mb-4 pb-4">
                        <h5 class="font-weight-semi-bold mb-4">Filter by Category</h5>
                        <asp:RadioButtonList ID="rblCategory" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="Filter_Changed" CssClass="custom-control">
                            <asp:ListItem Text="All Categories" Value="0" Selected="True"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <!-- Category End -->

                    <!-- Price Start -->
                    <div class="border-bottom mb-4 pb-4">
                        <h5 class="font-weight-semi-bold mb-4">Filter by Price</h5>
                        <asp:RadioButtonList ID="rblPrice" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="Filter_Changed" CssClass="custom-control">
                            <asp:ListItem Text="All Price" Value="0" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Under  Rs.100" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Rs.100 - Rs.500" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Rs.500 - Rs.1000" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Above Rs.1000" Value="4"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <!-- Price End -->
                </div>
                <!-- Shop Sidebar End -->

                <!-- Shop Product Start -->
                <div class="col-lg-9 col-md-12">
                    <div class="row pb-3">
                        <div class="col-12 pb-1">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <div>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                            placeholder="Search by name"></asp:TextBox>
                                        <div class="input-group-append">
                                            <asp:LinkButton ID="btnSearch" runat="server"
                                                CssClass="input-group-text bg-transparent text-primary"
                                                OnClick="Filter_Changed">
                                                <i class="fa fa-search"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <div class="ml-4">
                                    <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-control"
                                        AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                                        <asp:ListItem Text="Sort By Latest" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Price: Low to High" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Price: High to Low" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <asp:Repeater ID="rProducts" runat="server">
                            <ItemTemplate>
                                <div class="col-lg-4 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4">
                                        <div
                                            class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                            <img class="img-fluid w-100" style="height: 350px; object-fit: cover;"
                                                src='<%# Stationery_Inventory.Utils.getImageUrl(Eval("ImageUrl")) %>'
                                                alt="">
                                        </div>
                                        <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                            <h6 class="text-truncate mb-3">
                                                <%# Eval("ProductName") %>
                                            </h6>
                                            <div class="d-flex justify-content-center">
                                                <h6>Rs.<%# Eval("Price") %>
                                                </h6>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex justify-content-between bg-light border">
                                            <a href="ShopDetail.aspx?id=<%# Eval(" ProductId") %>" class="btn btn-sm
                                                text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View
                                                Detail</a>
                                            <a href="Cart.aspx?id=<%# Eval(" ProductId") %>" class="btn btn-sm text-dark
                                                p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To
                                                Cart</a>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblNoProducts" runat="server"
                                    Visible='<%# bool.Parse((rProducts.Items.Count==0).ToString()) %>'
                                    Text="No products found." CssClass="alert alert-warning w-100 m-3"></asp:Label>
                            </FooterTemplate>
                        </asp:Repeater>

                    </div>
                </div>
                <!-- Shop Product End -->
            </div>
        </div>
        <!-- Shop End -->
    </asp:Content>