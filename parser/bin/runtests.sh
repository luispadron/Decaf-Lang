#!/bin/bash

#/usr/bin/bash

echo "building"

make > /dev/null

echo "running sample_tests"
echo ""
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
        diff -w $file sample_tests/ours/$filename.txt > sample_tests/diffs/$filename.diff    
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

echo "running our_tests"
echo ""
printf 'our_tests/input\nour_tests/correct\nsolution/dcc' | ./bin/gen_tests.sh > /dev/null
printf 'our_tests/input\nour_tests/output\ndcc' | ./bin/gen_tests.sh > /dev/null

for file in our_tests/correct/*
do  
    filename="${file##*/}"
    filename="${filename%.*}"
    {
        diff -w $file our_tests/output/$filename.txt > our_tests/diffs/$filename.diff    
    } || {
        echo "test failed for file: $filename ❗️"
        ERROR=true
    }

    if $ERROR;
    then
        echo "check diff: our_tests/diffs/$filename.diff"
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