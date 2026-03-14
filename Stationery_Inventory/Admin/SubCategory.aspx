<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="SubCategory.aspx.cs" Inherits="Stationery_Inventory.Admin.SubCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                var lblMsgs = document.getElementById("<%= lblMsg.ClientID %>");
                if (lblMsgs) { lblMsgs.style.display = "none"; }
            }, seconds * 1000);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mb-4">
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>
    <div class="row">
        <div class="col-sm-12 col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">SubCategory</h4>
                    <hr />
                    <div class="form-body">
                        <label>Category</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                                        <asp:ListItem Value="0">Select Category</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ForeColor="Red" Font-Size="Small"
                                        Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlCategory" InitialValue="0"
                                        ErrorMessage="Category is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <label>SubCategory Name</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtSubCategoryName" runat="server" CssClass="form-control" placeholder="SubCategory Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvSubCategoryName" runat="server" ForeColor="Red" Font-Size="Small"
                                        Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtSubCategoryName"
                                        ErrorMessage="SubCategory name is required"></asp:RequiredFieldValidator>
                                    <asp:HiddenField ID="hfSubCategoryId" runat="server" Value="0" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; Is Active" />
                                </div>
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
            </div>
        </div>

        <div class="col-sm-12 col-md-8">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">SubCategory List</h4>
                    <hr />
                    <div class="table-responsive">
                        <asp:Repeater ID="rSubCategory" runat="server" onItemCommand="rSubCategory_ItemCommand" >
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">SubCategory</th>
                                            <th>Category</th>
                                            <th>IsActive</th>
                                            <th>CreatedDate</th>
                                            <th class="datatable-nosort">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="table-plus"> <%#Eval("SubCategoryName") %> </td>
                                    <td><%#Eval("CategoryName") %></td>
                                    <td>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# (bool)Eval("IsActive") == true? "Active" : "Inactive" %>'
                                            CssClass='<%# (bool)Eval("IsActive") == true ? "badge badge-success" : "badge badge-danger" %>' >
                                        </asp:Label>
                                    </td>
                                    <td>
                                        <%# Eval("CreatedDate") %>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lbEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                            CommandArgument = '<%# Eval("SubCategoryId") %>' CommandName="edit" CausesValidation="false" >
                                            <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbDelete" Text="Delete" runat="server" CssClass="badge badge-danger"
                                            CommandArgument = '<%# Eval("SubCategoryId") %>' CommandName="delete" CausesValidation="false" >
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
