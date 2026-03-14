using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Stationery_Inventory.User
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSendMessage_Click(object sender, EventArgs e)
        {
            try
            {
                using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(Utils.getConnection()))
                {
                    con.Open();
                    using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("INSERT INTO Contact (Name, Email, Subject, Message, CreatedDate) VALUES (@Name, @Email, @Subject, @Message, GETDATE())", con))
                    {
                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
                        cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                        
                        cmd.ExecuteNonQuery();
                    }
                }
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showAlertModal('Your message has been sent completely! We will be in touch securely.', 'Contact.aspx');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"showAlertModal('An error occurred: {ex.Message.Replace("'", "\\'")}', '');", true);
            }
        }
    }
}