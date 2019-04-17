#!/bin/bash

# This script runs the whole compiling process
# Example usage: ./decaf.sh <FILE.decaf>

set -e

FILE=$1

make > /dev/null

./solution/dcc-mac < $FILE > $FILE.asm
spim -file $FILE.asm
rm $FILE.asm