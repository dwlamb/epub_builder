# epub_builder
BASH Script to make epubs

This is a script - written in GNU BASH found on Ubuntu - for packing source files into an epub container.

Run from the command-line and once variables a user has entered are validated the script will:

-   delete the existing epub file, if it exists;
-   initiate the epub file by packing 'mimetype' first with no compression and no extra file attributes;
-   compress the rest of the files into an epub file format;
-   if an epub checking software run from the command-line is installed, verify the  epub file to ensure it is error free.

###INSTALLATION:

Save the script file to a directory in your system's path statement.  The software to validate a completed epub with this script is availble [here on github](https://github.com/IDPF/epubcheck).  Save that software to a path on your system and modify the script to that location.

###Syntax:
```
epub.sh -l <list_of_files>.txt -e <name_of_epub>.epub
```
`-l <list_of_files>.txt` is optional.  Omitted, the script will compress the entire contents of the sub-directory.
`-e <name_of_epub>.epub` is mandatory.

###N.B.:
For this script to work properly, only use it from the command line already set to the root of where the source files for the epub exist.
####Example:
```
A file location on your system:
<~/Documents/A_Great_Novel/>
   |
   /OEBPS
   /META-INF/
   mimetype

Your command prompt in a shell
user@some_machine:~/Documents/A_Great_Novel/ $> epub.sh -l <list_of_files>.txt -e <name_of_epub>.epub
```
###Initiating an epub:

Some epub software readers will not function properly if the `mimetype` file is compressed and has file attributes associated with it in the epub container.

The command: 
```
zip -0X <name_of_epub>.epub mimetype
```

run before another zip command to create the epub, resolves that limitation for the file will appear first when the file is opened in an epub reader. This step is done automatically in the script.

###Packing all other files:

This script offers the option of a specified list of files to zip/place in an epub container.
```
epub.sh -l <list_of_files>.txt -e <name_of_epub>.epub
```

The switch -l is an option designed for debugging and only packing some of the source files.

The syntax `-l list_of_files>.txt` are optional. The file name provided after -l is a simple text file format for zip'ping a list of files. A web search will yield further guidance on using zip with a file list from the command-line, if this is unfamiliar to you.

To work successfully, the list file must reside at the root of the epub source files.  The contents of the list file must be relative to the  root of the epub source files as well.

##Example:
```
<~/Documents/A_Great_Novel/>
   |
   /OEBPS
   /META-INF/
   mimetype
   file_list.txt

user@some_machine:~/Documents/A_Great_Novel/ $>
```
The contents of the list file must be relative to the present location.

##Sample:
```
META-INF/container.xml
OEBPS/content.opf
OEBPS/Fonts/School-Book.otf
OEBPS/Fonts/School-BookItalic.otf
OEBPS/Images/cover.png
OEBPS/Styles/fonts.css
OEBPS/Styles/styles.css
OEBPS/Text/cover.xhtml
OEBPS/Text/titlepage.xhtml
OEBPS/toc.ncx
OEBPS/Text/A_Great_Novel_0001.html
OEBPS/Text/A_Great_Novel_0002.html
OEBPS/Text/A_Great_Novel_0003.html
OEBPS/Text/A_Great_Novel_0004.html
OEBPS/Text/A_Great_Novel_0005.html
OEBPS/Text/A_Great_Novel_0006.html
OEBPS/Text/A_Great_Novel_0007.html
```
