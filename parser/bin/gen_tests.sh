#!/bin/bash

# This script generate correct output files for running the given executable 
# for every file in the given input folder and puts the output files in
# the given output folder

echo -n "Enter the directory with input files: "
read IN_DIR

echo -n "Enter the output directory: "
read OUT_DIR

if [ ! -d $OUT_DIR ]; then
  mkdir -p $OUT_DIR;
fi

echo -n "Enter executable name: "
read EXEC

for file in $IN_DIR/*
do  
    filename="${file##*/}"
    filename="${filename%.*}"
    ./$EXEC < $file &> $OUT_DIR/$filename.txt
done