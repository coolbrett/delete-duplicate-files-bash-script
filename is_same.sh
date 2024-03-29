#!/bin/bash

#Brett Dale
#Project One Linux Tools

#This script compares two files and deletes one of them if they have the same 
#contents

fileOne=$1
fileTwo=$2
arg3=$3

if [ $# -eq 0 ]; then
    echo -e "Enter first file name >"
    read first
    echo -e "Enter second file name >"
    read second
    if [ -z "$first" ] || [ -z "$second" ]; then
        echo "prompt error"
        echo "usage: is_same.sh file file [T|F]"
        exit 1
    else
        fileOne=$first
        fileTwo=$second
    fi

if [ $# -gt 3 ]; then
    echo "usage: is_same.sh file file [T|F]" | tee -a log.txt
    exit 1
fi

fi

if [[ -n "$fileOne" ]] && [[ -n "$fileTwo" ]]  ; then
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
cmp -s "$fileOne" "$fileTwo"
same=$?

if [ "$arg3" = "T" ]; then
    echo "Removing log.txt"
    rm log.txt
fi

#choosing file
chosen=0
if [[ $fileOne < $fileTwo ]]; then
    chosen=$fileTwo
else
    chosen=$fileOne
fi

touch log.txt
if [[ $same = 0  ]]; then
    echo -e "Files are identical:\t$chosen removed" | tee -a log.txt
    rm "$chosen"
else
    echo -e "Files not identical:\t$chosen not removed" | tee -a log.txt
fi
