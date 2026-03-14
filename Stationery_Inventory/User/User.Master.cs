using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Stationery_Inventory.User
{
    public partial class User : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Url.AbsoluteUri.ToString().Contains("Default.aspx"))
            {
                //load control
                Control sliderUserControl = (Control)Page.LoadControl("SliderUserControl.ascx");
                pnlSliderUC.Controls.Add(sliderUserControl);
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        public int cartCount()
        {
            if (Session["UserId"] != null)
            {
                using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(Utils.getConnection()))
                {
                    using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("SELECT ISNULL(SUM(Quantity), 0) FROM Cart WHERE UserId = @UserId", con))
                    {
                        cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                        con.Open();
                        object val = cmd.ExecuteScalar();
                        if (val != DBNull.Value) return Convert.ToInt32(val);
                    }
                }
            }
            return 0;
        }
    }
}