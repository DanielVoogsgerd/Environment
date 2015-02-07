#!/bin/sh

function gpgedit(){
    if [ -z "$GPGKEY" ]; then
        echo "No \$GPGKEY variable set"
        return 1
    fi
    if [ ! -e "$1" ]; then
        echo "File does not exists, creating file"
    fi

    tmp=`mktemp`
    chmod 0600 $tmp
    gpg -d $1 > $tmp
    edit $tmp
    rm -f $1
    gpg -sear "$GPGKEY" $tmp
    cp ${tmp}.asc  $1
    rm -f $tmp ${tmp}.asc
}

function gpgencrypt() {
    if [ -z "$GPGKEY" ]; then
        echo "No \$GPGKEY variable set"
        return 1
    fi
    if [ ! -e "$1" ]; then
        echo "File does not exists"
        return 1
    fi

    gpg -sear "$GPGKEY" $1
}

function gpgdecrypt() {
    if [ ! -e "$1" ]; then
        echo "File does not exists"
        return 1
    fi

    gpg -d $1 2>/dev/null
}
