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

echo "------------------------------"