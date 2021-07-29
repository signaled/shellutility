#!/bin/sh

#*****
# create directory if not exist
# $1 : directory full path
function prepareDirectory()
{
    local DIRECTORY=$1
    if [ -d $DIRECTORY ];then 
        return 0 # already exist
    fi
    mkdir $DIRECTORY
    if [ -d $DIRECTORY ];then
        return 0
    fi
    return -1
}

#*****
# copy file
# $1 : exist file
# $2 : target file
function copyfile()
{
    local SOURCE=$1
    local TARGET=$2
    if [ !-e $SOURCE ];then
        return -1 # file not found
    fi
    cp $SOURCE $TARGET
    if [ !-e $TARGET ];then
        return -1 # file not found
    fi

    return 0;
}

#*****
# copy directory
# $1 : exist directory fullpath
# $2 : target directory fullpath
function copyDirectory()
{
    local SOURCE=$1
    local TARGET=$2
    local SOURCE_FILENAME=""
    local TARGET_FILENAME=""

    echo "copy Directory from[$SOURCE] to [$TARGET]"
    for filename in $(ls -C $SOURCE)
    do
        SOURCE_FILENAME=$SOURCE/$filename
        TARGET_FILENAME=$TARGET/$filename
        if [ -d $SOURCE_FILENAME ];then
            copyDirectory $SOURCE_FILENAME $TARGET_FILENAME
        elif [ -f $SOURCE_FILENAME ];then
            echo "copy file from [$SOURCE] to [$TARGET]"
            cp $SOURCE_FILENAME $TARGET_FILENAME
        fi
    done
    updateExecRight $TARGET
}

#*****
# add exec right
# $1 : directory full path
function updateExecRight()
{
    local DIRECTORY=$1
    local FILEPATH=""
    for filename in $(ls -C $DIRECTORY/*.sh) # w/ ls make filename to full path
    do
        echo "Add exec right for [$filename]"
        if [ -f $filename ];then
            echo "chmod a+x $filename"
            chmod a+x $filename
        fi
    done
}

#*****
# PATH update 
# $1 : full path
function updatePathEnv()
{
    local NEWPATH=$1
    local Found=false
    
    directories=$(echo "$PATH" | tr ':' '\n')
    for dir in $directories
    do
        if [ $dir == $NEWPATH ];then
            Found=true
        fi
    done
    if [ $Found == false ];then
        echo "Update ~/.bashrc"
        echo "export PATH=\$PATH:$NEWPATH" >> $HOME/.bashrc
        source $HOME/.bashrc
    fi

    #it is not working on my host
    #echo $PATH | grep -q $NEWPATH && echo "export PATH=\$PATH:$NEWPATH" >> $HOME/.bashrc
    #source $HOME/.bashrc
}

