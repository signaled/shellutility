#!/bin/bash

RUN_DIR=`dirname $0`
CURRENT_DIR=`readlink -f $RUN_DIR`
SOURCE_UTILDIR=$CURRENT_DIR/util 
TARGET_UTILDIR=$HOME/util

# COLOR
source $CURRENT_DIR/util/color.sh
# Helper
source $CURRENT_DIR/util/helper.sh

#----- Install ~/util/utilities ------#
# Create Repo/util to ~/util
# Set PATH=$PATH:~/util

UTIL_DIR=$HOME/util

prepareDirectory $UTIL_DIR
if [ $? != 0 ]; then 
    echo -e $R"Fail to create install dir["$W$UTIL_DIR$r"]"
    exit -1
fi

copyDirectory $SOURCE_UTILDIR $TARGET_UTILDIR
updatePathEnv $TARGET_UTILDIR
installBLDAlias

exit

