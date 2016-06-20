#!/bin/bash
usage() {
cat << EOF

    epub.sh is a script to be run from the root sub-directory of an epub 
    file that has been newly created or opened for editing and is ready
    for packing.  
    
    For an epub to open and viewed in epub reading software, the file 
    'mimetpye' plus directories 'META-INF' and 'OEPBS' need to be at the 
    root of an epub file directory tree.  To faciliate the process epub.sh 
    runs from the root of the present working directory which should 
    be the root of an opened epub file.  Options stated below with a path 
    which leads to a directory other than the current one will throw an error.


    usage: $0 -e <name_of_epub>.epub -l <list_of_files>.txt

    $0

    OPTIONS
    -? or -h  this message
    -e        name of epub. [mandatory] Book to create in epub format.
    -l        list of files to compress into an epub. [optional]  Used for partially 
              creating an epub. Without this option script will act on entire 
              sub-directory structure.
EOF
}

EPUB=
LIST=

while getopts "h\?e:l:" OPTION
do
    case $OPTION in 
    h)
        usage
        exit 1
        ;;
    e)
        EPUB=$OPTARG
        ;;
    l)
        LIST=$OPTARG
        ;;
    ?)
        usage
        exit 1
        ;;
    esac
done

PATH_EPUB=$(dirname "${EPUB}" )
PATH_LIST=$(dirname "${LIST}" )

# if paths of LIST file or the EPUB file are other than the present working directory

if [[  "." != "$PATH_LIST" ]] || [[  "." != "$PATH_EPUB" ]]
    then
    usage
    exit 1
fi

#if LIST file is specified but doesn't exist physically
if [[ ! -f "$LIST" ]]
    then
    usage
    exit 1    
fi

if [[ -z $EPUB ]]; 
    then
    usage
    exit 1
fi


# if the EPUB file exists
if [ -f $EPUB ];
then
    rm $EPUB
fi

#initiate EPUB file
zip -0X $EPUB mimetype 

#if LIST of files was NOT specified in options
if [[ -z $LIST ]]
then
    #build the epub using files present
    zip -qXr9D $EPUB META-INF/ OEBPS/ -x 'OEBPS/text/.directory' 
else
    #build the epub using the list specified
    cat $LIST | zip -qXr9D $EPUB -@ -x 'OEBPS/text/.directory'
fi

#test the epub to see if it passes
java -jar /home/daniel/epubcheck-4.0.1/epubcheck.jar $EPUB
