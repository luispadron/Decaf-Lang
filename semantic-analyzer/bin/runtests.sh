#!/bin/bash

#/usr/bin/bash

echo "building"

make clean > /dev/null
make > /dev/null

echo ""
echo "running sample_tests"
echo ""
printf 'samples\nsample_tests/ours\ndcc' | ./bin/gentests.sh > /dev/null

ERROR=false
PASSED=0
TOTAL=0

for file in samples/*.out
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
        rm sample_tests/diffs/$filename.diff
        PASSED=$((PASSED+1))
        echo "test passed for file: $filename ✅"
        echo "--------------------------------------------------"
    fi

    ERROR=false
    TOTAL=$((TOTAL+1))
done

echo ""
echo "running our_samples"
echo ""
printf 'our_samples/in\nour_samples/correct\nsolution/dcc-mac' | ./bin/gentests.sh > /dev/null
printf 'our_samples/in\nour_samples/out\ndcc' | ./bin/gentests.sh > /dev/null

for file in our_samples/correct/*
do
    filename="${file##*/}"
    filename="${filename%.*}"
    {
        diff -w $file our_samples/out/$filename.txt > our_samples/diff/$filename.diff
    } || {
        echo "test failed for file: $filename ❗️"
        ERROR=true
    }

    if $ERROR;
    then
        echo "check diff: our_samples/diff/$filename.diff"
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