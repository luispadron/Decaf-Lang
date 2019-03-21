#!/bin/bash

# This script generate correct output files for running the given executable
# for every file in the given input folder and puts the output files in
# the given output folder

# collect flags
IN_DIR=$1
OUT_DIR=$2
EXEC=$3
EXEC_FLAG=$4

if [ ! -d $OUT_DIR ]; then
  mkdir -p $OUT_DIR;
fi


for file in $IN_DIR/*.decaf
do
    filename="${file##*/}"
    filename="${filename%.*}"
    echo "generating output for: $filename"
    ./$EXEC -d $EXEC_FLAG < $file &> $OUT_DIR/$filename.txt

done