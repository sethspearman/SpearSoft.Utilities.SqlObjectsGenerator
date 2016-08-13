using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net;
using System.Runtime.Remoting.Messaging;

namespace SpearSoft.Utilities.SqlObjectsGenerator
{
    public static class FileHandler
    {
        public static void SaveFile(string fileName, string filePath, string content)
        {
            var file = Path.Combine(filePath, fileName);
            if (File.Exists(file)) { File.Delete(file); }
            File.AppendAllText(file,content);
        }

        public static string CombineContent(string header, string content, string footer)
        {
            var combinedContent = string.Format("{0}{3}{1}{3}{2}", header, content, footer, Environment.NewLine);
            //need to figure out a token replacement strategry
            return combinedContent;

        }

        public static string GetTemplate(string type,string headerFooter )
        {
            var templateFile = ConfigurationManager.AppSettings[$"{type}{headerFooter}"];
            return File.ReadAllText(templateFile);
        }

        public static string UpdateTemplateTokens( List<SearchReplaceString> searchReplaceStrings, string template  )
        {
            var newTemplate = template;
            foreach (var values in searchReplaceStrings)
            {
                newTemplate = newTemplate.Replace(values.SearchToken, values.ReplaceValue);
            }
            return newTemplate;
        }
    }
}

