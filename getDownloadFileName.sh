#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# wgetFileName
# Get the filename which a server would like us to use when downloading
# their file.
# Inputs
#   Unique Resource Location (URL)
# Outputs
#   Filename determined from content disposition given in header

## Error reporting block.
# https://codeinthehole.com/tips/bash-error-reporting/
set -eu -o pipefail

function print_error {
    read line file <<<$(caller)
    echo "An error occurred in line $line of file $file:" >&2
    sed "${line}q;d" "$file" >&2
}
trap print_error ERR
######################################################

websiteResponse=$(wget --server-response -q -O - "$1" 2>&1 | tr '\0' '\n');
if [[ ! $websiteResponse =~ Content-Disposition:.* ]]; then
    echo 'Content-Disposition: not found';
    exit 1;
fi
contentDisposition=$(echo $websiteResponse | grep -P 'Content-Disposition:.*' -o 2>&1);
if [[ ! $contentDisposition =~ filename=.* ]]; then
    echo 'filename= not found';
    exit 1; 
fi
filename=$(echo $contentDisposition | grep -P '(?<=filename=)([^.]+)([^\s|\n]+)' -o 2>&1 | cut -d \" -f2);
echo $filename;