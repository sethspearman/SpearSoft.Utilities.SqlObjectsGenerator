using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;

namespace SpearSoft.Utilities.SqlObjectsGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            var list = new SqlObjectList();
            list.LoadObjects();
            const string extension = "sql";
            const string footer = "footer";
            const string header = "header";

            DoOutput(list, extension, header, footer,"V","viewsOutPath","views");
            DoOutput(list, extension, header, footer,"P", "proceduresOutPath", "procedures");
            DoOutput(list, extension, header, footer,"FN", "functionsOutPath", "functions");  //SCALAR FUNCTIONS
            DoOutput(list, extension, header, footer,"IF", "functionsOutPath", "functions");  //INLINE FUNCTIONS
            DoOutput(list, extension, header, footer,"TR", "triggersOutPath", "triggers");
        }
        // V  "viewsOutPath"   "views"
        private static void DoOutput(SqlObjectList list, string extension, string header, string footer, string objCode, string settingsKey, string objType )
        {
            var typeCode = objCode;
            var filePath = ConfigurationManager.AppSettings[settingsKey];
            var objectType = objType;

            OutputSqlObjectType(list, typeCode, extension, filePath, objectType, header, footer);
        }

        private static void OutputSqlObjectType(SqlObjectList list, string typeCode, string extension, string filePath,
            string objectType, string header, string footer)
        {
            var items = list.Where(t => t.Type.Trim() == typeCode).ToList();
            foreach (var sqlObject in items)
            {
                var fileName = $"{sqlObject.Name}.{extension}";

                var headerContent = FileHandler.GetTemplate(objectType, header);
                var objectScript = sqlObject.Definition;
                var footerContent = FileHandler.GetTemplate(objectType, footer);

                var contents = FileHandler.CombineContent(headerContent, objectScript, footerContent);

                FileHandler.SaveFile(fileName, filePath, contents);
            }
        }
    }
}
