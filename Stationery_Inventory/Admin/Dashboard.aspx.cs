using System;
using System.Data.SqlClient;

namespace Stationery_Inventory.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDashboardData();
            }
        }

        private void BindDashboardData()
        {
            try
            {
                con = new SqlConnection(Utils.getConnection());
                con.Open();

                // Total Customers
                cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE RoleId = 2", con);
                lblTotalCustomers.Text = cmd.ExecuteScalar().ToString();

                // Total Earnings (Assuming Cart totals * Price, simplified sum for demonstration if no orders yet, or use OrderDetails table logic if Orders implemented)
                // Let's assume total revenue from all active products for now, or just Orders if exist. 
                // Since the exact column for total isn't cleanly defined without Orders join, let's just do a placeholder or basic select.
                // Let's just do 'Orders' count and 'Products' count properly.
                cmd = new SqlCommand("SELECT COUNT(*) FROM Product", con);
                lblTotalProducts.Text = cmd.ExecuteScalar().ToString();

                // Total Orders
                cmd = new SqlCommand("SELECT COUNT(*) FROM Orders", con);
                lblTotalOrders.Text = cmd.ExecuteScalar().ToString();
                
                // Total Earnings Approximation 
                // In a real scenario, this would sum up `Quantity * Price` from `Orders` joined with `Product`
                cmd = new SqlCommand("SELECT ISNULL(SUM(o.Quantity * p.Price), 0) FROM Orders o INNER JOIN Product p ON o.ProductId = p.ProductId", con);
                lblTotalEarnings.Text = Convert.ToDecimal(cmd.ExecuteScalar()).ToString("0.00");

            }
            catch (Exception)
            {
                // Optionally handle exception
            }
            finally
            {
                if (con != null && con.State == System.Data.ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }
    }
}