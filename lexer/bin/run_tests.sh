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

echo "Running lexer tests"
echo "------------------------------"
./bin/run_test.py dcc_tests dcc txt
echo "------------------------------"