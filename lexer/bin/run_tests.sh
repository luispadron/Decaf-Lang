#/usr/bin/bash

set -e

echo "Building"

make dpp
make dcc

echo ""

echo "Running pre-processor tests"
echo "------------------------------"
./bin/run_test.py dpp decaf
echo "------------------------------"
