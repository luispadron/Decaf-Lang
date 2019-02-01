#!/bin/bash

#/usr/bin/bash

echo "building"

make > /dev/null

# run sample tests
printf 'samples\nsample_tests/ours\ndcc' | ./bin/gen_tests.sh > /dev/null

set -e
ERROR=false

for file in sample_tests/correct/*
do  
    filename="${file##*/}"
    filename="${filename%.*}"
    {
        diff $file sample_tests/ours/$filename.txt > sample_tests/diffs/$filename.diff    
    } || {
        echo "test failed for file: $filename❗️"
        echo "check diff here: sample_tests/diffs/$filename.diff"
        echo "--------------------------------------------------"
        ERROR=true
    }
done

if $ERROR;
then
    echo "tests failed❗️"
else 
    echo "tests succeeded✅"
fi