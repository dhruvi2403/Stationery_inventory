using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Stationery_Inventory.User
{
    public partial class ShopDetail : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    GetProductDetails();
                }
                else
                {
                    Response.Redirect("Shop.aspx");
                }
            }
        }

        void GetProductDetails()
        {
            string productId = Request.QueryString["id"];
            con = new SqlConnection(Utils.getConnection());
            
            // Get Product Details
            cmd = new SqlCommand("SELECT * FROM Product WHERE ProductId = @ProductId AND IsActive = 1", con);
            cmd.Parameters.AddWithValue("@ProductId", productId);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            
            if (dt.Rows.Count > 0)
            {
                lblName.Text = dt.Rows[0]["ProductName"].ToString();
                lblPrice.Text = dt.Rows[0]["Price"].ToString();
                lblShortDesc.Text = dt.Rows[0]["ShortDescription"].ToString();
                lblLongDesc.Text = dt.Rows[0]["LongDescription"].ToString();
                lblAddDesc.Text = dt.Rows[0]["AdditionalDescription"].ToString();
                lblSize.Text = string.IsNullOrEmpty(dt.Rows[0]["Size"].ToString()) ? "N/A" : dt.Rows[0]["Size"].ToString();
                lblColor.Text = string.IsNullOrEmpty(dt.Rows[0]["Color"].ToString()) ? "N/A" : dt.Rows[0]["Color"].ToString();
            }
            else
            {
                Response.Redirect("Shop.aspx");
            }
            
            // Get Product Images
            cmd = new SqlCommand("SELECT ImageUrl FROM ProductImages WHERE ProductId = @ProductId", con);
            cmd.Parameters.AddWithValue("@ProductId", productId);
            sda = new SqlDataAdapter(cmd);
            DataTable dtImages = new DataTable();
            sda.Fill(dtImages);
            
            rProductImages.DataSource = dtImages;
            rProductImages.DataBind();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                int productId = Convert.ToInt32(Request.QueryString["id"]);
                int quantity = Convert.ToInt32(txtQuantity.Text);
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
                    int newQty = Convert.ToInt32(dt.Rows[0]["Quantity"]) + quantity;
                    cmd = new SqlCommand("UPDATE Cart SET Quantity = @Quantity WHERE ProductId = @ProductId AND UserId = @UserId", con);
                    cmd.Parameters.AddWithValue("@Quantity", newQty);
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                }
                else
                {
                    // Insert new cart item
                    cmd = new SqlCommand("INSERT INTO Cart (ProductId, Quantity, UserId, CreatedDate) VALUES (@ProductId, @Quantity, @UserId, GETDATE())", con);
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                }
                
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Item added to cart successfully!";
                    lblMsg.CssClass = "alert alert-success";
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
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}