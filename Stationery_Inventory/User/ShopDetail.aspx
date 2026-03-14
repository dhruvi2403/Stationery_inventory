<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="ShopDetail.aspx.cs" Inherits="Stationery_Inventory.User.ShopDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">Shop Detail</h1>
            <div class="d-inline-flex">
                <p class="m-0"><a href="Default.aspx">Home</a></p>
                <p class="m-0 px-2">-</p>
                <p class="m-0">Shop Detail</p>
            </div>
        </div>
    </div>
    <!-- Page Header End -->

    <!-- Shop Detail Start -->
    <div class="container-fluid py-5">
        <div class="px-xl-5 mb-3">
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>
        <div class="row px-xl-5">
            <div class="col-lg-5 pb-5">
                <div id="product-carousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner border">
                        <asp:Repeater ID="rProductImages" runat="server">
                            <ItemTemplate>
                                <div class='carousel-item <%# Container.ItemIndex == 0 ? "active" : "" %>'>
                                    <img class="w-100" style="height: 500px; object-fit: cover;" src='<%# Stationery_Inventory.Utils.getImageUrl(Eval("ImageUrl")) %>' alt="Image">
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <div class="col-lg-7 pb-5">
                <h3 class="font-weight-semi-bold"><asp:Label ID="lblName" runat="server"></asp:Label></h3>
                <h3 class="font-weight-semi-bold mb-4">₹<asp:Label ID="lblPrice" runat="server"></asp:Label></h3>
                <p class="mb-4"><asp:Label ID="lblShortDesc" runat="server"></asp:Label></p>
                <div class="d-flex mb-3">
                    <p class="text-dark font-weight-medium mb-0 mr-3">Size:</p>
                    <p><asp:Label ID="lblSize" runat="server"></asp:Label></p>
                </div>
                <div class="d-flex mb-4">
                    <p class="text-dark font-weight-medium mb-0 mr-3">Color:</p>
                    <p><asp:Label ID="lblColor" runat="server"></asp:Label></p>
                </div>
                <div class="d-flex align-items-center mb-4 pt-2">
                    <div class="input-group quantity mr-3" style="width: 130px;">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-primary btn-minus" onclick="if(document.getElementById('<%=txtQuantity.ClientID%>').value > 1) { document.getElementById('<%=txtQuantity.ClientID%>').value--; } return false;" >
                            <i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control bg-secondary text-center" Text="1"></asp:TextBox>
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-primary btn-plus" onclick="document.getElementById('<%=txtQuantity.ClientID%>').value++; return false;">
                                <i class="fa fa-plus"></i>
                            </button>
                        </div>
                    </div>
                    <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-primary px-3" Text="Add To Cart" OnClick="btnAddToCart_Click" />
                </div>
            </div>
        </div>
        <div class="row px-xl-5">
            <div class="col">
                <div class="nav nav-tabs justify-content-center border-secondary mb-4">
                    <a class="nav-item nav-link active" data-toggle="tab" href="#tab-pane-1">Description</a>
                    <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-2">Additional Information</a>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="tab-pane-1">
                        <h4 class="mb-3">Product Description</h4>
                        <p><asp:Label ID="lblLongDesc" runat="server"></asp:Label></p>
                    </div>
                    <div class="tab-pane fade" id="tab-pane-2">
                        <h4 class="mb-3">Additional Information</h4>
                        <p><asp:Label ID="lblAddDesc" runat="server"></asp:Label></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Shop Detail End -->
</asp:Content>
