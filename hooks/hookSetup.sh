#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo ""
    echo "************************************"
    echo "Usage: hookSetup.sh <workstream-root>"
    echo "************************************"
    echo ""
    exit -1;
fi

# Setup global template
mkdir -p ~/.git-templates/hooks
cp commit-msg.sh ~/.git-templates/hooks/
git config --global init.templatedir '~/.git-templates'

# Process all the repos

originalDir=`pwd`
cd $1
for f in *; do
    if [[ -d $f ]]; then
        echo "Dir: $f"
        cd $f
        if [ -d ".git" ]; then
            git init
        fi
        cd ..
    fi
done
cd ${originalDir}