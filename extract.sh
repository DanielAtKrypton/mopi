#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# extract
# Extract or decompress a file with unknown compression method
# Inputs
#   Filename
function extract {
    if [ -z "$1" ] || [ "$1" == "-h" ]; then
        # display usage if no parameters given
        echo "Usage: extract file_name [target_directory]"
        return 0;
    fi;
    if [ -z "$2" ]; then
        TARGETDIR=$1;
    else
        if [ -e "$2" ]; then
            TARGETDIR=$2;
        else
          echo "'$2' - target directory does not exist"
          return 1;
        fi;
    fi;
    if [ ! -f "$1" ] ; then
        # Make sure file exists
        echo "'$1' - file does not exist"
        return 1;
    fi;
    # Try to decompress file based on extension
    case "$1" in
        *.tar.bz2)   tar -xvjf "$1";                return  ;;
        *.tar.gz)    tar -xvzf "$1";                return  ;;
        *.tar.xz)    tar -xvJf "$1";                return  ;;
        *.lzma)      unlzma "$1";                   return  ;;
        *.bz2)       bunzip2 "$1";                  return  ;;
        *.rar)       unrar x -ad "$1";              return  ;;
        *.gz)        gunzip "$1";                   return  ;;
        *.tar)       tar -xvf "$1";                 return  ;;
        *.tbz2)      tar -xvjf "$1";                return  ;;
        *.tgz)       tar -xvzf "$1";                return  ;;
        *.zip)       unzip "$1" -d "$TARGETDIR";    return  ;;
        *.Z)         uncompress "$1";               return  ;;
        *.7z)        7z x "$1";                     return  ;;
        *.xz)        unxz "$1";                     return  ;;
        *.exe)       cabextract "$1";               return  ;;
        *)           echo "extract: '$1' - unknown extension";;
    esac;
    # No extension given it seems, so we will try to work it out by MIME-type
    TYPE=$(file --mime-type -b "$1")
    echo "Trying to deduce compression method from MIME type";
    echo "$1 is a $TYPE";
    case $TYPE in
        application/x-gtar)
            tar -C "$TARGETDIR" -xvf "$1";;
        application/x-lzma)
            unlzma "$1";;
        application/x-bzip2)
            bunzip2 "$1";;
        application/x-rar)
            unrar x -ad "$1";;
        application/gzip)
            # gunzip won't work without an extension, so just use 7z
            false;;
        application/zip)
            unzip "$1" -d "$TARGETDIR";;
        application/x-compress)
            uncompress "$1";;
        application/x-7z-compressed)
            7z x "$1";
            return;; # Don't double up on 7z
        application/x-xz)
            unxz "$1";;
        *)
            echo "extract: '$1' - unknown mime-type '$TYPE'";
            false;;
    esac;
    # 7z is a Swiss-army knife for decompression, so try that
    RESULT=$?;
    if [[ $RESULT -ne 0 ]];
    then
        command -v 7z >/dev/null 2>&1 \
            && 7z x "$1";
        RESULT=$?;
    fi;
    if [[ $RESULT -ne 0 ]];
    then
        echo "extract: '$1' - extraction failed";
    fi;
    return $RESULT;
}

FILENAME=$1;
TARGETDIR=$2;

echo "Attempting to extract contents from $FILENAME";
# extract "$FILENAME" && rm -f "$FILENAME";
extract "$FILENAME" "$TARGETDIR";
# If we can't extract it, let's assume it wasn't an archive after
# all, and we're done if we just put the downloaded file in the
# directory.
RESULT=$?;
if [[ $RESULT -ne 0 ]];
then
    echo "";
else
    echo "";
    echo "Decompression of $FILENAME appears to have been successful.";
fi;
exit $RESULT;