#!/bin/bash

# collect flags
IN_DIR=$1
OUT_DIR=$2
EXEC=$3

if [ ! -d $OUT_DIR ]; then
  mkdir -p $OUT_DIR;
fi


for file in $IN_DIR/*.decaf
do
    filename="${file##*/}"
    filename="${filename%.*}"
    echo "generating tac output for: $filename"
    ./$EXEC < $file &> $OUT_DIR/$filename.tac
    echo "generating spim output for: $filename"
    {
        spim -file $OUT_DIR/$filename.tac &> $OUT_DIR/$filename.out
        rm $OUT_DIR/$filename.tac
    } || {
        echo "Failed to run spim for $filename"
    }
done