#!/bin/bash

echo "building"

make > /dev/null


ERROR=false
PASSED=0
TOTAL=0

### Tac tests

echo ""
echo "running tac tests"
echo ""

./bin/gentests.sh tac_tests/in tac_tests/ours dcc tac
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

### Spim tests

#echo ""
#echo "running spim tests"
#echo ""
#
## Generate spim output for correct compiler
#./bin/genspimtests.sh spim_tests/in spim_tests/correct dcc-mac &> /dev/null
## Generate spim output for our compiler
#./bin/genspimtests.sh spim_tests/in spim_tests/ours dcc &> /dev/null
#
#for file in spim_tests/correct/*.out
#do
#    filename="${file##*/}"
#    filename="${filename%.*}"
#    {
#        diff -w $file spim_tests/ours/$filename.out > spim_tests/diffs/$filename.diff
#    } || {
#        echo "test failed for file: $filename ❗️"
#        ERROR=true
#    }
#
#    if $ERROR;
#    then
#        echo "check diff: spim_tests/diffs/$filename.diff"
#        echo "--------------------------------------------------"
#    else
#        rm spim_tests/diffs/$filename.diff
#        PASSED=$((PASSED+1))
#        echo "test passed for file: $filename ✅"
#        echo "--------------------------------------------------"
#    fi
#
#    ERROR=false
#    TOTAL=$((TOTAL+1))
#
#done
#
#### Custom tests
#
#echo ""
#echo "running our_tests"
#echo ""
#
## Generate spim output for correct compiler
#./bin/genspimtests.sh our_tests/in our_tests/correct dcc-mac &> /dev/null
## Generate spim output for our compiler
#./bin/genspimtests.sh our_tests/in our_tests/ours dcc &> /dev/null
#
#
#for file in our_tests/correct/*.out
#do
#    filename="${file##*/}"
#    filename="${filename%.*}"
#    {
#        diff -w $file our_tests/ours/$filename.out > our_tests/diffs/$filename.diff
#    } || {
#        echo "test failed for file: $filename ❗️"
#        ERROR=true
#    }
#
#    if $ERROR;
#    then
#        echo "check diff: our_tests/diffs/$filename.diff"
#        echo "--------------------------------------------------"
#    else
#        rm our_tests/diffs/$filename.diff
#        PASSED=$((PASSED+1))
#        echo "test passed for file: $filename ✅"
#        echo "--------------------------------------------------"
#    fi
#
#    ERROR=false
#    TOTAL=$((TOTAL+1))
#
#done

echo "passed $PASSED / $TOTAL tests"