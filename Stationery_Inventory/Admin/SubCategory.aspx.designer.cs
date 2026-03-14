namespace Stationery_Inventory.Admin
{
    public partial class SubCategory
    {
        protected global::System.Web.UI.WebControls.Label lblMsg;
        protected global::System.Web.UI.WebControls.DropDownList ddlCategory;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvCategory;
        protected global::System.Web.UI.WebControls.TextBox txtSubCategoryName;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvSubCategoryName;
        protected global::System.Web.UI.WebControls.HiddenField hfSubCategoryId;
        protected global::System.Web.UI.WebControls.CheckBox cbIsActive;
        protected global::System.Web.UI.WebControls.Button btnAddorUpdate;
        protected global::System.Web.UI.WebControls.Button btnClear;
        protected global::System.Web.UI.WebControls.Repeater rSubCategory;
    }
}
