using System;

namespace Stationery_Inventory.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["RoleId"] == null || Convert.ToInt32(Session["RoleId"]) != 1)
            {
                Response.Redirect("../User/Login.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("../User/Login.aspx");
        }
    }
}