# SpearSoft.Utilities.SqlObjectsGenerator

The purpose of the SqlObject Generator is to generate Create Scripts for
your Microsoft Sql Server database objects (ie, procedures, functions, views, and triggers. )

For example, you might have an existing database but none of your sql objects are in source 
control.  In that case you can use this utility to generate your scripts and put them into 
source control. 

I wrote this utility in a couple of hours so it is rough but it worked for my purposes.

## Installation

'git clone' the repository and open the SpearSoft.Utilities.SqlObjectsGenerator.sln file in 
Visual Studio 2015 and build.

## Usage

You need to update the app.config if running straight from Visual Studio or if running 
compiled assemblies you will need to update the SpearSoft.Utilities.SqlObjectsGenerator.exe.config.

You need to, of course, update the connection string in the config.  For more information ...
https://www.connectionstrings.com/sqlconnection/.

The other values in the appSettings node are not as obvious but here is what 
needs to be changed:

* querystring - probably don't need to change this.  This is the query used to fetch the 
  object names, types, and code.  If you find that this query doesn't work you may need to
  tweak it...but it works for me.
* <object>OutPath - for example viewsOutPath.  
  For each type of object (..or not..you could use the same path) put the full path to 
  the target folders where the generated objects will be placed.
* <object>Header - for example viewsHeader or procedureHeader.  Template files.
  The code fetches the object code from the database but that is all.  Your create script
  will want to run setup code.  The most obvious use for this is to check for the existence
  of your object and drop it if it already exists.  This will allow your code to only have 
  CREATE <OBJECT_TYPE> statements in them rather than ALTER statements.  For example, this
  is the stored procedure header file that is included (look in the template folder.)  
    `if object_id(dbo.{{objectname}}) is not null`  
	      `drop procedure dbo.{{objectname}}`  
  this text will be injected into the generated file BEFORE the objects code.  Of course, the
  moustache template string will be replaced with the actual object name.  
* <object>Footer - for example viewsFooter or procedureFooter.  Template files.  
  Of course, this is template text that is inserted AFTER the code rather then before.  For 
  example, you might put GRANT permission statement after the code.
  
You need to update the full path to your template files and the full path to your out path.  
Maybe in the future I will use a "basePath" configuration to make it a little easier to configure.

After configuring everything in the *.exe.config, the utility should mostly work.  
There is very little error handling.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

No history yet

## Roadmap

* Update exception handling.
* Use a 'basePath' configurations to point to the 'out' destination and the template locations.
* Add logging

## Credits

Seth Brian Spearman
SpearSoft LLC 
www.spearsofttech.com

## License

MIT License

Copyright (c) [year] [fullname]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
