#!/bin/bash

#/usr/bin/bash

echo "building"

make > /dev/null

# run sample tests
printf 'samples\nsample_tests/ours\ndcc' | ./bin/gen_tests.sh > /dev/null

set -e
ERROR=false
PASSED=0
TOTAL=0

for file in sample_tests/correct/*
do  
    filename="${file##*/}"
    filename="${filename%.*}"
    {
        diff $file sample_tests/ours/$filename.txt > sample_tests/diffs/$filename.diff    
    } || {
        echo "test failed for file: $filename ❗️"
        ERROR=true
    }

    if $ERROR;
    then
        echo "check diff: sample_tests/diffs/$filename.diff"
        echo "--------------------------------------------------"
    else
        PASSED=$((PASSED+1))
        echo "test passed for file: $filename ✅"
        echo "--------------------------------------------------"
    fi

    ERROR=false
    TOTAL=$((TOTAL+1))
done

echo "passed $PASSED / $TOTAL tests"