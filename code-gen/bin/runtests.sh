#!/bin/bash

echo "building"

make clean > /dev/null
make > /dev/null


ERROR=false
PASSED=0
TOTAL=0

./bin/gentests.sh samples tac_tests/ours dcc tac > /dev/null

for file in tac_tests/correct/*.txt
do
    filename="${file##*/}"
    filename="${filename%.*}"
    {
        diff -w $file tac_tests/ours/$filename.txt > tac_tests/diffs/$filename.diff
    } || {
        echo "test failed for file: $filename ❗️"
        ERROR=true
    }

    if $ERROR;
    then
        echo "check diff: tac_tests/diffs/$filename.diff"
        echo "--------------------------------------------------"
    else
        rm tac_tests/diffs/$filename.diff
        PASSED=$((PASSED+1))
        echo "test passed for file: $filename ✅"
        echo "--------------------------------------------------"
    fi

    ERROR=false
    TOTAL=$((TOTAL+1))
done



echo "passed $PASSED / $TOTAL tests"