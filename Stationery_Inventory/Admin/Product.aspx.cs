using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace Stationery_Inventory.Admin
{
    public partial class Product : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["breadCumbTitle"] = "Manage Product";
            Session["breadCumbPage"] = "Product";
            lblMsg.Visible = false;
            if (!IsPostBack)
            {
                getCategories();
                getProducts();
            }
        }

        void getCategories()
        {
            con = new SqlConnection(Utils.getConnection());
            cmd = new SqlCommand("SELECT CategoryId, CategoryName FROM Category WHERE IsActive = 1", con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryId";
            ddlCategory.DataBind();
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Select SubCategory", "0"));
            if (categoryId > 0)
            {
                con = new SqlConnection(Utils.getConnection());
                cmd = new SqlCommand("SELECT SubCategoryId, SubCategoryName FROM SubCategory WHERE CategoryId = @CategoryId AND IsActive = 1", con);
                cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                ddlSubCategory.DataSource = dt;
                ddlSubCategory.DataTextField = "SubCategoryName";
                ddlSubCategory.DataValueField = "SubCategoryId";
                ddlSubCategory.DataBind();
            }
        }

        void getProducts()
        {
            con = new SqlConnection(Utils.getConnection());
            cmd = new SqlCommand(@"SELECT p.*, c.CategoryName, pi.ImageUrl 
                                   FROM Product p 
                                   INNER JOIN Category c ON c.CategoryId = p.CategoryId 
                                   LEFT JOIN ProductImages pi ON pi.ProductId = p.ProductId AND pi.DefaultImage = 1", con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProduct.DataSource = dt;
            rProduct.DataBind();
        }

        protected void btnAddorUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtention = string.Empty;
            bool isValidToExecute = false;
            int productId = Convert.ToInt32(hfProductId.Value);
            con = new SqlConnection(Utils.getConnection());

            if (fuProductImage.HasFile)
            {
                if (Utils.isValidExtention(fuProductImage.FileName))
                {
                    string newImageName = Utils.getUniqueId();
                    fileExtention = Path.GetExtension(fuProductImage.FileName);
                    imagePath = "Images/Product/" + newImageName.ToString() + fileExtention;
                    fuProductImage.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + newImageName.ToString() + fileExtention);
                    isValidToExecute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Please select .jpg, .jpeg or .png image";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;
                    return;
                }
            }
            else
            {
                isValidToExecute = true;
            }

            if (isValidToExecute)
            {
                try
                {
                    con.Open();
                    if (productId == 0) // Insert
                    {
                        cmd = new SqlCommand(@"INSERT INTO Product (ProductName, ShortDescription, LongDescription, AdditionalDescription, Price, Quantity, Size, Color, CompanyName, CategoryId, SubCategoryId, Sold, IsCustomised, IsActive, CreatedDate) 
OUTPUT INSERTED.ProductId
VALUES (@ProductName, @ShortDescription, @LongDescription, @AdditionalDescription, @Price, @Quantity, @Size, @Color, @CompanyName, @CategoryId, @SubCategoryId, 0, @IsCustomised, @IsActive, @CreatedDate)", con);
                        cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                    }
                    else // Update
                    {
                        cmd = new SqlCommand(@"UPDATE Product SET ProductName=@ProductName, ShortDescription=@ShortDescription, LongDescription=@LongDescription, AdditionalDescription=@AdditionalDescription, Price=@Price, Quantity=@Quantity, Size=@Size, Color=@Color, CompanyName=@CompanyName, CategoryId=@CategoryId, SubCategoryId=@SubCategoryId, IsCustomised=@IsCustomised, IsActive=@IsActive WHERE ProductId=@ProductId; SELECT @ProductId;", con);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                    }

                    cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ShortDescription", txtShortDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@LongDescription", txtLongDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@AdditionalDescription", txtAdditionalDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text.Trim()));
                    cmd.Parameters.AddWithValue("@Quantity", Convert.ToInt32(txtQuantity.Text.Trim()));
                    cmd.Parameters.AddWithValue("@Size", txtSize.Text.Trim());
                    cmd.Parameters.AddWithValue("@Color", txtColor.Text.Trim());
                    cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text.Trim());
                    cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@SubCategoryId", ddlSubCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@IsCustomised", cbIsCustomised.Checked);
                    cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);

                    int newProductId = Convert.ToInt32(cmd.ExecuteScalar());

                    if (fuProductImage.HasFile)
                    {
                        SqlCommand cmdImage = new SqlCommand("IF EXISTS (SELECT 1 FROM ProductImages WHERE ProductId=@ProductId) UPDATE ProductImages SET ImageUrl=@ImageUrl WHERE ProductId=@ProductId ELSE INSERT INTO ProductImages (ImageUrl, ProductId, DefaultImage) VALUES (@ImageUrl, @ProductId, 1)", con);
                        cmdImage.Parameters.AddWithValue("@ProductId", newProductId);
                        cmdImage.Parameters.AddWithValue("@ImageUrl", imagePath);
                        cmdImage.ExecuteNonQuery();
                    }

                    actionName = productId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Product " + actionName + " successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    getProducts();
                    clear();
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

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        void clear()
        {
            txtProductName.Text = string.Empty;
            txtShortDescription.Text = string.Empty;
            txtLongDescription.Text = string.Empty;
            txtAdditionalDescription.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtQuantity.Text = string.Empty;
            txtSize.Text = string.Empty;
            txtColor.Text = string.Empty;
            txtCompanyName.Text = string.Empty;
            ddlCategory.ClearSelection();
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Select SubCategory", "0"));
            cbIsCustomised.Checked = false;
            cbIsActive.Checked = false;
            hfProductId.Value = "0";
            btnAddorUpdate.Text = "Add";
            imagePreview.ImageUrl = string.Empty;
        }

        protected void rProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Utils.getConnection());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand(@"SELECT p.*, pi.ImageUrl 
                                       FROM Product p 
                                       LEFT JOIN ProductImages pi ON pi.ProductId = p.ProductId AND pi.DefaultImage = 1 
                                       WHERE p.ProductId = @ProductId", con);
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                    txtShortDescription.Text = dt.Rows[0]["ShortDescription"].ToString();
                    txtLongDescription.Text = dt.Rows[0]["LongDescription"].ToString();
                    txtAdditionalDescription.Text = dt.Rows[0]["AdditionalDescription"].ToString();
                    txtPrice.Text = dt.Rows[0]["Price"].ToString();
                    txtQuantity.Text = dt.Rows[0]["Quantity"].ToString();
                    txtSize.Text = dt.Rows[0]["Size"].ToString();
                    txtColor.Text = dt.Rows[0]["Color"].ToString();
                    txtCompanyName.Text = dt.Rows[0]["CompanyName"].ToString();
                    ddlCategory.SelectedValue = dt.Rows[0]["CategoryId"].ToString();
                    
                    // Bind subcategory for selected category
                    ddlCategory_SelectedIndexChanged(null, null);
                    if(ddlSubCategory.Items.FindByValue(dt.Rows[0]["SubCategoryId"].ToString()) != null)
                    {
                        ddlSubCategory.SelectedValue = dt.Rows[0]["SubCategoryId"].ToString();
                    }

                    cbIsCustomised.Checked = Convert.ToBoolean(dt.Rows[0]["IsCustomised"]);
                    cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                    imagePreview.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
                    imagePreview.Height = 200;
                    imagePreview.Width = 200;
                    hfProductId.Value = dt.Rows[0]["ProductId"].ToString();
                    btnAddorUpdate.Text = "Update";
                }
            }
            else if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("DELETE FROM Product WHERE ProductId = @ProductId", con);
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Product deleted successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    getProducts();
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
}
