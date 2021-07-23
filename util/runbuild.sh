#!/bin/bash

ROOT_DIR="/"
CALLER_DIR=`pwd`
SCRIPT_NAME="build.sh"

SCRIPT_PATH=""

R="\e[1;31m"
G="\e[1;32m"
Y="\e[1;33m"
B="\e[1;34m"
M="\e[1;35m"
C="\e[1;36m"
W="\e[1;37m"
N="\e[0;m"

function findAndRunScript()
{
    echo -e $Y"Find Script[$W"$2"$Y] in ["$W$1$Y"]$N"

    if [ -z $1 ];then # param is not passed
        echo -e $R"Path is not found."$N
        exit 1
    fi

    if [ $ROOT_DIR == $1 ];then
        echo -e $R"it was reached to the root(/) directory."$N
        exit 1
    fi

    if [ -e $1 ];then # if path is exist
        SCRIPT_PATH=$1/$2
        if [ -e $SCRIPT_PATH ];then
            echo -e $W"Run $C"$SCRIPT_PATH$N
            sh $SCRIPT_PATH
        else
            findAndRunScript "$(dirname $1)" "$2"
        fi
    else
        echo -e $R"Path is not found."$N
    fi
}

findAndRunScript $CALLER_DIR $SCRIPT_NAME

exit 0
