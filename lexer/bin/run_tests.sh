#/usr/bin/bash

set -e

echo "Building"

make dpp
make dcc

echo ""

echo "Running pre-processor tests"
echo "------------------------------"
./bin/run_test.py dpp_tests dpp decaf
echo "------------------------------"


# These tests are handled like this because the python test
# script doesnt work with the dcc output
echo ""
echo "Running lexer tests"
echo "------------------------------"

# run the location handling tests
./dcc < dcc_tests/dcc_loc/in.txt > dcc_tests/dcc_loc/bad.txt
diff dcc_tests/dcc_loc/out.txt dcc_tests/dcc_loc/bad.txt
rm dcc_tests/dcc_loc/bad.txt
echo "test dcc_loc succeeded\t\t✅"
# end location handling tests

# run operator lexing tests
./dcc < dcc_tests/dcc_operators/in.txt > dcc_tests/dcc_operators/bad.txt
diff dcc_tests/dcc_operators/out.txt dcc_tests/dcc_operators/bad.txt
rm dcc_tests/dcc_operators/bad.txt
echo "test dcc_operators succeeded\t✅"
# end operator tests

# run complete lexing tests
./dcc < dcc_tests/dcc_complete/in.decaf > dcc_tests/dcc_complete/bad.txt
diff dcc_tests/dcc_complete/out.txt dcc_tests/dcc_complete/bad.txt
rm dcc_tests/dcc_complete/bad.txt
echo "test dcc_complete succeeded\t✅"
# end complete tests

# run tab lexing tests
./dcc < dcc_tests/dcc_tabs/in.decaf > dcc_tests/dcc_tabs/bad.txt
diff dcc_tests/dcc_tabs/out.txt dcc_tests/dcc_tabs/bad.txt
rm dcc_tests/dcc_tabs/bad.txt
echo "test dcc_tabs succeeded\t\t✅"
# end tab tests

# run sample tests

printf 'samples\nsample_tests/ours\ndcc' | ./bin/gen_tests.sh > /dev/null

for file in sample_tests/correct/*
do  
    filename="${file##*/}"
    filename="${filename%.*}"
    {
        diff $file sample_tests/ours/$filename.txt > sample_tests/diffs/$filename.diff    
    } || {
        echo "test sample_tests failed\t❗️"
        exit
    }
done
echo "test sample_tests succeeded\t\t✅"
#end run sample tests

echo "------------------------------"