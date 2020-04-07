#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# extract
# Extract or decompress a file with unknown compression method
# Inputs
#   Filename
function extract {
    TARGETPARAM="`eval echo ${2//>}`";
    TARGETFILE="`eval echo ${1//>}`";
    if [ -z "$TARGETFILE" ] || [ "$TARGETFILE" == "-h" ]; then
        # display usage if no parameters given
        echo "Usage: extract file_name [target_directory]"
        return 0;
    fi;
    if [ -z "$TARGETPARAM" ]; then
        TARGETDIR=$TARGETFILE;
    else
        if [ -d "$TARGETPARAM" ]; then
            TARGETDIR="$TARGETPARAM";
        else
          echo "'$TARGETPARAM' - target directory does not exist"
          return 1;
        fi;
    fi;
    cd "$TARGETDIR";
    if [ ! -f "$TARGETFILE" ]; then
    # if [ ! -f "$1" ] ; then
        # Make sure file exists
        echo "'$1' - file does not exist"
        return 1;
    fi;
    # Try to decompress file based on extension
    case "$1" in
        *.tar.bz2)   tar -xvjf "$TARGETFILE";    return  ;;
        *.tar.gz)    tar -xvzf "$TARGETFILE";    return  ;;
        *.tar.xz)    tar -xvJf "$TARGETFILE";    return  ;;
        *.lzma)      unlzma "$TARGETFILE";       return  ;;
        *.bz2)       bunzip2 "$TARGETFILE";      return  ;;
        *.rar)       unrar x -ad "$TARGETFILE";  return  ;;
        *.gz)        gunzip "$TARGETFILE";       return  ;;
        *.tar)       tar -xvf "$TARGETFILE";     return  ;;
        *.tbz2)      tar -xvjf "$TARGETFILE";    return  ;;
        *.tgz)       tar -xvzf "$TARGETFILE";    return  ;;
        *.zip)       unzip "$TARGETFILE";        return  ;;
        *.Z)         uncompress "$TARGETFILE";   return  ;;
        *.7z)        7z x "$TARGETFILE";         return  ;;
        *.xz)        unxz "$TARGETFILE";         return  ;;
        *.exe)       cabextract "$TARGETFILE";   return  ;;
        *)           echo "extract: '$1' - unknown extension";;
    esac;
    # No extension given it seems, so we will try to work it out by MIME-type
    TYPE=$(file --mime-type -b "$TARGETFILE")
    echo "Trying to deduce compression method from MIME type";
    echo "$TARGETFILE is a $TYPE";
    case $TYPE in
        application/x-gtar)
            tar -xvf "$TARGETFILE";;
        application/x-lzma)
            unlzma "$TARGETFILE";;
        application/x-bzip2)
            bunzip2 "$TARGETFILE";;
        application/x-rar)
            unrar x -ad "$TARGETFILE";;
        application/gzip)
            # gunzip won't work without an extension, so just use 7z
            false;;
        application/zip)
            unzip "$TARGETFILE";;
        application/x-compress)
            uncompress "$TARGETFILE";;
        application/x-7z-compressed)
            7z x "$TARGETFILE";
            return;; # Don't double up on 7z
        application/x-xz)
            unxz "$TARGETFILE";;
        *)
            echo "extract: '$TARGETFILE' - unknown mime-type '$TYPE'";
            false;;
    esac;
    # 7z is a Swiss-army knife for decompression, so try that
    RESULT=$?;
    if [[ $RESULT -ne 0 ]];
    then
        case $TYPE in
        application/gzip)
            command -v 7z && \
            7z x "$TARGETFILE" && \
            7z x "$TARGETFILE~";;
        *)
            command -v 7z && \
            7z x "$TARGETFILE";;
        esac;
        RESULT=$?;
        if [[ $RESULT -ne 0 ]];
        then
            echo "extract: '$TARGETFILE' - extraction failed";
            echo " - reason: 7z is not installed!"
        fi;
        return $RESULT;
    fi;
    echo "extract: '$TARGETFILE' - extraction failed";
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