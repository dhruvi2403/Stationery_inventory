using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Stationery_Inventory.Admin
{
    public partial class SubCategory : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["breadCumbTitle"] = "Manage SubCategory";
            Session["breadCumbPage"] = "SubCategory";
            lblMsg.Visible = false;
            if (!IsPostBack)
            {
                getCategories();
                getSubCategories();
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

        void getSubCategories()
        {
            con = new SqlConnection(Utils.getConnection());
            cmd = new SqlCommand("SELECT s.SubCategoryId, s.SubCategoryName, s.IsActive, s.CreatedDate, c.CategoryName FROM SubCategory s INNER JOIN Category c ON c.CategoryId = s.CategoryId", con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rSubCategory.DataSource = dt;
            rSubCategory.DataBind();
        }

        protected void btnAddorUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty;
            int subCategoryId = Convert.ToInt32(hfSubCategoryId.Value);
            con = new SqlConnection(Utils.getConnection());

            if (subCategoryId == 0) // Insert
            {
                cmd = new SqlCommand("INSERT INTO SubCategory (SubCategoryName, CategoryId, IsActive, CreatedDate) VALUES (@SubCategoryName, @CategoryId, @IsActive, @CreatedDate)", con);
                cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
            }
            else // Update
            {
                cmd = new SqlCommand("UPDATE SubCategory SET SubCategoryName=@SubCategoryName, CategoryId=@CategoryId, IsActive=@IsActive WHERE SubCategoryId=@SubCategoryId", con);
                cmd.Parameters.AddWithValue("@SubCategoryId", subCategoryId);
            }

            cmd.Parameters.AddWithValue("@SubCategoryName", txtSubCategoryName.Text.Trim());
            cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                actionName = subCategoryId == 0 ? "inserted" : "updated";
                lblMsg.Visible = true;
                lblMsg.Text = "SubCategory " + actionName + " successfully!";
                lblMsg.CssClass = "alert alert-success";
                getSubCategories();
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

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        void clear()
        {
            txtSubCategoryName.Text = string.Empty;
            ddlCategory.ClearSelection();
            cbIsActive.Checked = false;
            hfSubCategoryId.Value = "0";
            btnAddorUpdate.Text = "Add";
        }

        protected void rSubCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Utils.getConnection());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("SELECT * FROM SubCategory WHERE SubCategoryId = @SubCategoryId", con);
                cmd.Parameters.AddWithValue("@SubCategoryId", e.CommandArgument);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    txtSubCategoryName.Text = dt.Rows[0]["SubCategoryName"].ToString();
                    ddlCategory.SelectedValue = dt.Rows[0]["CategoryId"].ToString();
                    cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                    hfSubCategoryId.Value = dt.Rows[0]["SubCategoryId"].ToString();
                    btnAddorUpdate.Text = "Update";
                }
            }
            else if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("DELETE FROM SubCategory WHERE SubCategoryId = @SubCategoryId", con);
                cmd.Parameters.AddWithValue("@SubCategoryId", e.CommandArgument);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "SubCategory deleted successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    getSubCategories();
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