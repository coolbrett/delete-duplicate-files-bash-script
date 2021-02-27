#!/bin/bash

#Brett Dale
#Project One Linux Tools

#This script compares two files and deletes one of them if they have the same 
#contents

#I'm unable to run the file without adding bash at the beginning on the 
#command line

if [ $# -gt 1 ] && [ $# -lt 4 ]; then
    
    if [ -f "$1"  ]; then
        if ! [[ -r "$1" ]] || ! [[ -w "$1" ]]; then
            if ! [[ -r "$1" ]]; then
                echo "$1 does not have read permissions" | tee -a log.txt
            fi

            if ! [[ -w "$1" ]]; then
                echo "$1 does not have write permissions" | tee -a log.txt
            fi

            echo "Cannot perform sameness check, please check files"
        fi
    else
        echo "$1 is not a regular file" | tee -a log.txt
        echo "Cannot perform sameness check, please check files" | tee -a log.txt
        exit 1
    fi

    if [ -f "$2" ]; then
        echo "it's a file"
        if ! [[ -r "$2" ]] || ! [[ -w "$2" ]]; then
            if ! [[ -r "$2" ]]; then
                echo "$2 does not have read permissions" | tee -a log.txt
            fi

            if ! [[ -w "$2" ]]; then
                echo "$2 does not have write permissions" | tee -a log.txt
            fi

            echo "Cannot perform sameness check, please check files"
        fi
    else
        echo "$2 is not a regular file" | tee -a log.txt
        echo "Cannot perform sameness check, please check files" | tee -a log.txt
        exit 1
    fi

else
    echo "usage: is_same.sh file file [T|F]" | tee -a log.txt
    exit 1
fi

#end of usage and error checking

#start of checking the files to see if they are identical
cmp "$1" "$2"
same=$?

if [ "$3" = "T" ]; then
    echo "Removing log.txt"
    rm log.txt
fi

touch log.txt
if [[ $same = 0  ]]; then
    echo -e "Files are identical:\t$1 removed" | tee -a log.txt
else
    echo -e "Files not identical:\t$2 not removed" | tee -a log.txt
fi
