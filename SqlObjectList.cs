using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace SpearSoft.Utilities.SqlObjectsGenerator
{
    class SqlObjectList:List<SqlObject>
    {

        public void LoadObjects()
        {
            
            using (var cn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString))
            {
                cn.Open();
                using (var cmd = new SqlCommand(ConfigurationManager.AppSettings["querystring"],cn))
                {
                    var reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Add(new SqlObject()
                        {
                            Name = reader.GetString(reader.GetOrdinal("Name")),
                            Type = reader.GetString(reader.GetOrdinal("type")),
                            TypeDescription = reader.GetString(reader.GetOrdinal("type_desc")),
                            Definition = reader.GetString(reader.GetOrdinal("definition"))
                        });
                    }
                    reader.Close();
                    reader.Dispose();
                }
            }
            
            

        }
        
    }
}

