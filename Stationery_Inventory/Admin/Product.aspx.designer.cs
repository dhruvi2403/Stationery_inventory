namespace Stationery_Inventory.Admin
{
    public partial class Product
    {
        protected global::System.Web.UI.WebControls.Label lblMsg;
        protected global::System.Web.UI.WebControls.TextBox txtProductName;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvProductName;
        protected global::System.Web.UI.WebControls.HiddenField hfProductId;
        protected global::System.Web.UI.WebControls.TextBox txtPrice;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvPrice;
        protected global::System.Web.UI.WebControls.TextBox txtQuantity;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvQuantity;
        protected global::System.Web.UI.WebControls.TextBox txtCompanyName;
        protected global::System.Web.UI.WebControls.TextBox txtSize;
        protected global::System.Web.UI.WebControls.TextBox txtColor;
        protected global::System.Web.UI.WebControls.DropDownList ddlCategory;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvCategory;
        protected global::System.Web.UI.WebControls.DropDownList ddlSubCategory;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvSubCategory;
        protected global::System.Web.UI.WebControls.TextBox txtShortDescription;
        protected global::System.Web.UI.WebControls.TextBox txtLongDescription;
        protected global::System.Web.UI.WebControls.TextBox txtAdditionalDescription;
        protected global::System.Web.UI.WebControls.FileUpload fuProductImage;
        protected global::System.Web.UI.WebControls.Image imagePreview;
        protected global::System.Web.UI.WebControls.CheckBox cbIsCustomised;
        protected global::System.Web.UI.WebControls.CheckBox cbIsActive;
        protected global::System.Web.UI.WebControls.Button btnAddorUpdate;
        protected global::System.Web.UI.WebControls.Button btnClear;
        protected global::System.Web.UI.WebControls.Repeater rProduct;
    }
}
