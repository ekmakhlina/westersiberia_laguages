#!/bin/sh

SOURCE_ROOT_DIR="$( cd $(dirname $0) && pwd -P)/.."

TSAKORPUS_DIR=${TSAKORPUS_DIR:-"$HOME/tsakorpus"}
CONFIGS_DIR=${CONFIGS_DIR:-"$SOURCE_ROOT_DIR/configs"}

version_file() {
    echo "$HOME/.westernsiberia_languages_version"
}

update() {
    test "$( cat $( version_file ) )" != "$( git rev-parse HEAD )"
}

(cd $CONFIGS_DIR; find . -type f | 
    while read filename; do
        echo "$filename"
        dir="$TSAKORPUS_DIR/$( dirname $filename )"
        mkdir -p "$dir" && cp "$CONFIGS_DIR/$filename" "$dir"
    done)

if test update; then
    ( cd "$TSAKORPUS_DIR/indexator" && python indexator.py &&
        git rev-parse HEAD > $( version_file ) )
else
    echo "Up to date"
fi


