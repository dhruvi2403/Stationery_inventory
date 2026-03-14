using System;
using System.Data.SqlClient;

namespace Stationery_Inventory.User
{
    public partial class Registration : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            con = new SqlConnection(Utils.getConnection());
            // Check if username exists
            cmd = new SqlCommand("SELECT COUNT(*) FROM users WHERE Username = @Username", con);
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            try
            {
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                if (count > 0)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Username already taken!";
                    lblMsg.CssClass = "alert alert-danger";
                    return;
                }

                // Insert user
                cmd = new SqlCommand("INSERT INTO users (Name, Username, Mobile, Email, Password, RoleId, CreatedDate) VALUES (@Name, @Username, @Mobile, @Email, @Password, 2, @CreatedDate)", con);
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                cmd.ExecuteNonQuery();

                lblMsg.Visible = true;
                lblMsg.Text = "Registration Successful! <a href='Login.aspx'>Login Here</a>";
                lblMsg.CssClass = "alert alert-success";
                
                // Clear fields
                txtName.Text = string.Empty;
                txtUsername.Text = string.Empty;
                txtMobile.Text = string.Empty;
                txtEmail.Text = string.Empty;
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



