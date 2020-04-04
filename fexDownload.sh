#!/usr/bin/env bash

# 03-mar-2020
# The following workaround is needed because downloading directly  fails if downloading from a GitHub connected FEX repository. 
finalURL=$(curl -Ls -o /dev/null -w %{url_effective} "$2"?download=true)

githubFexEndingString="/github_repo.zip?src=&license="
if [[ $finalURL == *$githubFexEndingString ]]
then
    downloadURL=${finalURL/$githubFexEndingString/}   
else
    downloadURL=$finalURL
fi
wget -O "$1" "$downloadURL";