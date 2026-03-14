using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Stationery_Inventory.User
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader sdr;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            con = new SqlConnection(Utils.getConnection());
            cmd = new SqlCommand("SELECT * FROM users WHERE Username=@Username AND Password=@Password", con);
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
            try
            {
                con.Open();
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    Session["UserId"] = sdr["UserId"];
                    Session["Username"] = sdr["Username"];
                    Session["RoleId"] = sdr["RoleId"];
                    if (Convert.ToInt32(sdr["RoleId"]) == 1)
                    {
                        Response.Redirect("../Admin/Dashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Invalid Username or Password!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
            finally
            {
                con.Close();
            }
        }
    }
}
