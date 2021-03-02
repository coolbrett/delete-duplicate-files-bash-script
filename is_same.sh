#!/bin/bash

#Brett Dale
#Project One Linux Tools

#This script compares two files and deletes one of them if they have the same 
#contents

#prompt user if no arguments
#delete file that comes first alphabetically 
#test permission mod use cases

fileOne=$1
fileTwo=$2
arg3=$3


if [ $# -gt 1 ] && [ $# -lt 4 ]; then
    if [ "$arg3" = "T" ] || [ "$arg3" = "F" ] || [ -z "$arg3" ]; then
    
        if [ -f "$fileOne"  ]; then
            if ! [[ -r "$fileOne" ]] || ! [[ -w "$fileOne" ]]; then
                if ! [[ -r "$fileOne" ]]; then
                    echo "$fileOne does not have read permissions" | tee -a log.txt
                fi

                if ! [[ -w "$fileOne" ]]; then
                    echo "$fileOne does not have write permissions" | tee -a log.txt
                fi

                echo "Cannot perform sameness check, please check files"
            fi
        else
            echo "$fileOne is not a regular file" | tee -a log.txt
            echo "Cannot perform sameness check, please check files" | tee -a log.txt
            exit 1
        fi

        if [ -f "$fileTwo" ]; then
            if ! [[ -r "$fileTwo" ]] || ! [[ -w "$fileTwo" ]]; then
                if ! [[ -r "$fileTwo" ]]; then
                    echo "$fileTwo does not have read permissions" | tee -a log.txt
                fi

                if ! [[ -w "$fileTwo" ]]; then
                    echo "$fileTwo does not have write permissions" | tee -a log.txt
                fi

                echo "Cannot perform sameness check, please check files"
            fi
        else
            echo "$fileTwo is not a regular file" | tee -a log.txt
            echo "Cannot perform sameness check, please check files" | tee -a log.txt
            exit 1
        fi
    else
        echo "usage: is_same.sh file file [T|F]" | tee -a log.txt
        exit 1
    fi

else
    echo "usage: is_same.sh file file [T|F]" | tee -a log.txt
    exit 1
fi

#end of usage and error checking

#start of checking the files to see if they are identical
cmp -s "$$fileOne" "$$fileTwo"
same=$?

if [ "$arg3" = "T" ]; then
    echo "Removing log.txt"
    rm log.txt
fi

touch log.txt
if [[ $same = 0  ]]; then
    echo -e "Files are identical:\t$fileOne removed" | tee -a log.txt
else
    echo -e "Files not identical:\t$fileTwo not removed" | tee -a log.txt
fi
