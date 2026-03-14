<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Stationery_Inventory.Admin.Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                var lblMsgs = document.getElementById("<%= lblMsg.ClientID %>");
                if (lblMsgs) { lblMsgs.style.display = "none"; }
            }, seconds * 1000);
        };
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imagePreview.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mb-4">
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Manage Product</h4>
                    <hr />
                    <div class="form-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Product Name</label>
                                    <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="Product Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="txtProductName" ErrorMessage="Name is required"></asp:RequiredFieldValidator>
                                    <asp:HiddenField ID="hfProductId" runat="server" Value="0" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Price</label>
                                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="Price" TextMode="Number" step="0.01"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="txtPrice" ErrorMessage="Price is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Quantity</label>
                                    <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" placeholder="Quantity" TextMode="Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="txtQuantity" ErrorMessage="Quantity is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Company Name</label>
                                    <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" placeholder="Company Name"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Size</label>
                                    <asp:TextBox ID="txtSize" runat="server" CssClass="form-control" placeholder="Size"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Color</label>
                                    <asp:TextBox ID="txtColor" runat="server" CssClass="form-control" placeholder="Color"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Category</label>
                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AppendDataBoundItems="true" AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                                        <asp:ListItem Value="0">Select Category</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="ddlCategory" InitialValue="0" ErrorMessage="Category is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>SubCategory</label>
                                    <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                                        <asp:ListItem Value="0">Select SubCategory</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvSubCategory" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="ddlSubCategory" InitialValue="0" ErrorMessage="SubCategory is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Short Description</label>
                                    <asp:TextBox ID="txtShortDescription" runat="server" CssClass="form-control" placeholder="Short Description" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Long Description</label>
                                    <asp:TextBox ID="txtLongDescription" runat="server" CssClass="form-control" placeholder="Long Description" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Additional Description</label>
                                    <asp:TextBox ID="txtAdditionalDescription" runat="server" CssClass="form-control" placeholder="Additional Description" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Product Image</label>
                                    <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Image ID="imagePreview" runat="server" CssClass="img-thumbnail" AlternateText="" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:CheckBox ID="cbIsCustomised" runat="server" Text="&nbsp; Is Customised" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; Is Active" />
                                </div>
                            </div>
                        </div>

                        <div class="form-action pb-5">
                            <div class="text-left">
                                <asp:Button ID="btnAddorUpdate" runat="server" CssClass="btn btn-info" Text="Add" onClick="btnAddorUpdate_Click"/>
                                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-dark" Text="Reset" OnClick="btnClear_Click" CausesValidation="false" />
                            </div>
                        </div>

                    </div>
                    
                    <h4 class="card-title mt-5">Product List</h4>
                    <hr />
                    <div class="table-responsive">
                        <asp:Repeater ID="rProduct" runat="server" onItemCommand="rProduct_ItemCommand" >
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Image</th>
                                            <th>Price(₹)</th>
                                            <th>Qty</th>
                                            <th>Category</th>
                                            <th>IsActive</th>
                                            <th class="datatable-nosort">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%#Eval("ProductName") %></td>
                                    <td><img width="40" src="<%# Stationery_Inventory.Utils.getImageUrl(Eval("ImageUrl")) %>" alt="image"/></td>
                                    <td><%#Eval("Price") %></td>
                                    <td><%#Eval("Quantity") %></td>
                                    <td><%#Eval("CategoryName") %></td>
                                    <td>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# (bool)Eval("IsActive") == true? "Active" : "Inactive" %>'
                                            CssClass='<%# (bool)Eval("IsActive") == true ? "badge badge-success" : "badge badge-danger" %>' >
                                        </asp:Label>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lbEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                            CommandArgument = '<%# Eval("ProductId") %>' CommandName="edit" CausesValidation="false" >
                                            <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbDelete" Text="Delete" runat="server" CssClass="badge badge-danger"
                                            CommandArgument = '<%# Eval("ProductId") %>' CommandName="delete" CausesValidation="false" >
                                            <i class="fas fa-trash-alt"></i>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
