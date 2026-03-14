using System;
using System.Data;
using System.Data.SqlClient;

namespace Stationery_Inventory.User
{
    public partial class Checkout : System.Web.UI.Page
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
                getCheckoutItems();
            }
        }

        void getCheckoutItems()
        {
            con = new SqlConnection(Utils.getConnection());
            cmd = new SqlCommand(@"SELECT c.ProductId, p.ProductName, p.Price, c.Quantity, (p.Price * c.Quantity) as TotalPrice 
                                   FROM Cart c 
                                   INNER JOIN Product p ON p.ProductId = c.ProductId 
                                   WHERE c.UserId = @UserId", con);
            cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            
            rCheckoutItem.DataSource = dt;
            rCheckoutItem.DataBind();

            decimal subTotal = 0;
            foreach (DataRow row in dt.Rows)
            {
                subTotal += Convert.ToDecimal(row["TotalPrice"]);
            }

            lblSubtotal.Text = subTotal.ToString("0.00");
            decimal shipping = subTotal > 0 ? 10 : 0; 
            lblShipping.Text = shipping.ToString("0.00");
            lblTotal.Text = (subTotal + shipping).ToString("0.00");
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            var userIdObj = Session["UserId"];
            if (userIdObj == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(userIdObj);

            try
            {
                con = new SqlConnection(Utils.getConnection());
                con.Open();

                // Check cart is not empty
                cmd = new SqlCommand(@"SELECT ProductId, Quantity FROM Cart WHERE UserId = @UserId", con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                DataTable cartDt = new DataTable();
                using (SqlDataAdapter sda1 = new SqlDataAdapter(cmd))
                {
                    sda1.Fill(cartDt);
                }

                if (cartDt.Rows.Count == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "showAlertModal('Your cart is empty.', '');", true);
                    return;
                }

                // 1. Insert Payment
                cmd = new SqlCommand("INSERT INTO Payment (Name, CardNo, ExpiryDate, CvvNo, Address, PaymentMode) OUTPUT INSERTED.PaymentId VALUES (@Name, @CardNo, @ExpiryDate, @CvvNo, @Address, @PaymentMode)", con);
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@CardNo", txtCardNo.Text);
                cmd.Parameters.AddWithValue("@ExpiryDate", txtExpDate.Text);
                cmd.Parameters.AddWithValue("@CvvNo", Convert.ToInt32(txtCvv.Text));
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                
                string paymentMode = Request.Form["payment"] ?? "Online";
                cmd.Parameters.AddWithValue("@PaymentMode", paymentMode);
                
                int paymentId = (int)cmd.ExecuteScalar();
                
                // 2. Insert Orders
                string orderNo = "ORD" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
                
                foreach (DataRow row in cartDt.Rows)
                {
                    SqlCommand orderCmd = new SqlCommand("INSERT INTO Orders (OrderNo, ProductId, Quantity, UserId, Status, PaymentId, OrderDate, IsCancel) VALUES (@OrderNo, @ProductId, @Quantity, @UserId, 'Pending', @PaymentId, GETDATE(), 0)", con);
                    orderCmd.Parameters.AddWithValue("@OrderNo", orderNo);
                    orderCmd.Parameters.AddWithValue("@ProductId", row["ProductId"]);
                    orderCmd.Parameters.AddWithValue("@Quantity", row["Quantity"]);
                    orderCmd.Parameters.AddWithValue("@UserId", userId);
                    orderCmd.Parameters.AddWithValue("@PaymentId", paymentId);
                    orderCmd.ExecuteNonQuery();
                }
                
                // 3. Clear Cart
                SqlCommand clearCartCmd = new SqlCommand("DELETE FROM Cart WHERE UserId = @UserId", con);
                clearCartCmd.Parameters.AddWithValue("@UserId", userId);
                clearCartCmd.ExecuteNonQuery();
                
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showAlertModal('Order placed successfully!', 'Shop.aspx');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"showAlertModal('An error occurred: {ex.Message.Replace("'", "\\'")}', '');", true);
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }
    }
}