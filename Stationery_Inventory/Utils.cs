using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Stationery_Inventory
{

    public class Utils
    {
        public static string getConnection()
        {
            return ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        }

        public static bool isValidExtention(string fileName)
        {
            bool isValid = false;
            string[] fileExtention = {".jpg", ".png", ".jpeg"};

            foreach (string file in fileExtention)
            {
                if(fileName.Contains(file)) { isValid = true; break; }
            }
            return isValid;
        }
        public static string getUniqueId()
        {
            Guid guid = Guid.NewGuid();
            return guid.ToString();

        }
        public static string getImageUrl(Object url)
        {
            string url1 = string.Empty;
            if(string.IsNullOrEmpty(url.ToString()) || url == DBNull.Value)
            {
                url1 = "../Images/No_image.png";
            }
            else
            {
                url1 = string.Format("../{0}", url);
                
            }
            return url1;
        }
    }
}