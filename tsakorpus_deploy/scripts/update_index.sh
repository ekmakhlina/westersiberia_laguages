#!/bin/sh

SOURCE_ROOT_DIR="$( cd $(dirname $0) && pwd -P)/.."

TSAKORPUS_DIR=${TSAKORPUS_DIR:-"$HOME/tsakorpus"}
CONFIGS_DIR=${CONFIGS_DIR:-"$SOURCE_ROOT_DIR/configs"}

rm -r $TSAKORPUS_DIR/corpus/*
(cd $CONFIGS_DIR; find . -type f | 
    while read filename; do
        echo "$filename"
        dir="$TSAKORPUS_DIR/$( dirname '$filename' )"
        mkdir -p "$dir" && cp "$CONFIGS_DIR/$filename" "$dir"
    done)

( cd "$TSAKORPUS_DIR/indexator" && python3 indexator.py )


