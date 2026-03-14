using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Stationery_Inventory.User
{
    public partial class Cart : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    AddToCart(Request.QueryString["id"]);
                }
                else
                {
                    getCartItems();
                }
            }
        }

        void AddToCart(string productId)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            con = new SqlConnection(Utils.getConnection());

            // Check if already in cart
            cmd = new SqlCommand("SELECT * FROM Cart WHERE ProductId = @ProductId AND UserId = @UserId", con);
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@UserId", userId);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                // Update quantity
                int newQty = Convert.ToInt32(dt.Rows[0]["Quantity"]) + 1;
                cmd = new SqlCommand("UPDATE Cart SET Quantity = @Quantity WHERE ProductId = @ProductId AND UserId = @UserId", con);
                cmd.Parameters.AddWithValue("@Quantity", newQty);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@UserId", userId);
            }
            else
            {
                // Insert new cart item
                cmd = new SqlCommand("INSERT INTO Cart (ProductId, Quantity, UserId, CreatedDate) VALUES (@ProductId, 1, @UserId, GETDATE())", con);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@UserId", userId);
            }

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
                // Handle theoretically
            }
            finally
            {
                con.Close();
                Response.Redirect("Cart.aspx");
            }
        }

        void getCartItems()
        {
            con = new SqlConnection(Utils.getConnection());
            cmd = new SqlCommand(@"SELECT c.ProductId, p.ProductName, p.Price, c.Quantity, (p.Price * c.Quantity) as TotalPrice, pi.ImageUrl 
                                   FROM Cart c 
                                   INNER JOIN Product p ON p.ProductId = c.ProductId 
                                   LEFT JOIN ProductImages pi ON pi.ProductId = p.ProductId AND pi.DefaultImage = 1 
                                   WHERE c.UserId = @UserId", con);
            cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            
            rCartItem.DataSource = dt;
            rCartItem.DataBind();

            decimal subTotal = 0;
            foreach (DataRow row in dt.Rows)
            {
                subTotal += Convert.ToDecimal(row["TotalPrice"]);
            }

            lblSubtotal.Text = subTotal.ToString("0.00");
            decimal shipping = subTotal > 0 ? 10 : 0; // Flat shipping rate if cart not empty
            lblShipping.Text = shipping.ToString("0.00");
            lblTotal.Text = (subTotal + shipping).ToString("0.00");
        }

        protected void rCartItem_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);
            int userId = Convert.ToInt32(Session["UserId"]);
            con = new SqlConnection(Utils.getConnection());

            if (e.CommandName == "remove")
            {
                cmd = new SqlCommand("DELETE FROM Cart WHERE ProductId = @ProductId AND UserId = @UserId", con);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@UserId", userId);
            }
            else if (e.CommandName == "plus" || e.CommandName == "minus")
            {
                // Get current quantity
                cmd = new SqlCommand("SELECT Quantity FROM Cart WHERE ProductId = @ProductId AND UserId = @UserId", con);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@UserId", userId);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                if(dt.Rows.Count > 0)
                {
                    int qty = Convert.ToInt32(dt.Rows[0]["Quantity"]);
                    if (e.CommandName == "plus") qty++;
                    else if (e.CommandName == "minus") qty--;

                    if (qty > 0)
                    {
                        cmd = new SqlCommand("UPDATE Cart SET Quantity = @Quantity WHERE ProductId = @ProductId AND UserId = @UserId", con);
                        cmd.Parameters.AddWithValue("@Quantity", qty);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                    }
                    else
                    {
                        cmd = new SqlCommand("DELETE FROM Cart WHERE ProductId = @ProductId AND UserId = @UserId", con);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                    }
                }
            }

            try
            {
                con.Open();
                if (cmd != null && cmd.CommandText.Length > 0)
                {
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception)
            {
                // Handle theoretically
            }
            finally
            {
                con.Close();
                getCartItems();
            }
        }
    }
}