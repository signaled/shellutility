#!/bin/bash

RUN_DIR=`dirname $0`
CURRENT_DIR=`readlink -f $RUN_DIR`
# COLOR
source $CURRENT_DIR/color.sh

ROOT_DIR="/"
CALLER_DIR=`pwd`
SCRIPT_NAME="build.sh"

SCRIPT_PATH=""

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
