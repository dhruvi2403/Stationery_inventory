using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Stationery_Inventory.User
{
    public partial class Shop : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCategories();
                BindProducts();
            }
        }

        private void BindCategories()
        {
            con = new SqlConnection(Utils.getConnection());
            cmd = new SqlCommand("SELECT CategoryId, CategoryName FROM Category WHERE IsActive = 1", con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            
            rblCategory.DataSource = dt;
            rblCategory.DataTextField = "CategoryName";
            rblCategory.DataValueField = "CategoryId";
            rblCategory.DataBind();
            
            rblCategory.Items.Insert(0, new ListItem("All Categories", "0"));
            rblCategory.SelectedIndex = 0;
        }

        private void BindProducts()
        {
            string query = @"SELECT p.ProductId, p.ProductName, p.Price, pi.ImageUrl 
                             FROM Product p 
                             LEFT JOIN ProductImages pi ON p.ProductId = pi.ProductId AND pi.DefaultImage = 1 
                             WHERE p.IsActive = 1 ";

            if (rblCategory.SelectedValue != "0" && rblCategory.SelectedValue != "")
            {
                query += " AND p.CategoryId = " + rblCategory.SelectedValue;
            }

            if (rblPrice.SelectedValue != "0" && rblPrice.SelectedValue != "")
            {
                if (rblPrice.SelectedValue == "1") query += " AND p.Price < 100";
                else if (rblPrice.SelectedValue == "2") query += " AND p.Price >= 100 AND p.Price <= 500";
                else if (rblPrice.SelectedValue == "3") query += " AND p.Price > 500 AND p.Price <= 1000";
                else if (rblPrice.SelectedValue == "4") query += " AND p.Price > 1000";
            }

            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                query += " AND p.ProductName LIKE '%" + txtSearch.Text.Trim() + "%'";
            }

            if (ddlSort.SelectedValue == "1")
            {
                query += " ORDER BY p.CreatedDate DESC";
            }
            else if (ddlSort.SelectedValue == "2")
            {
                query += " ORDER BY p.Price ASC";
            }
            else if (ddlSort.SelectedValue == "3")
            {
                query += " ORDER BY p.Price DESC";
            }

            con = new SqlConnection(Utils.getConnection());
            cmd = new SqlCommand(query, con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);

            rProducts.DataSource = dt;
            rProducts.DataBind();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            BindProducts();
        }
    }
}