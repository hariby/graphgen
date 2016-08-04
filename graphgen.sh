#!/bin/bash
command -v wget >/dev/null 2>&1 || { echo >&2 "I require wget but it's not installed.  Aborting."; exit 1; }
# Check all files exist
if ! [ -f "./rudy.c" ]; then
    wget http://web.stanford.edu/~yyye/yyye/Gset/rudy.c; fi
if ! [ -f "./gb_lib.c" ]; then
    wget http://web.stanford.edu/~yyye/yyye/Gset/gb_lib.c; fi
if ! [ -f "./ggenerator.readme" ]; then
    wget http://web.stanford.edu/~yyye/yyye/Gset/ggenerator.readme; fi
# Check rudy.c is compiled
if ! [ -f "./rudy" ]; then
    gcc gb_lib.c rudy.c -lm -o rudy; fi
# Check arg
if [ $# -ne 1 ]; then
    echo "Usage: ./graphgen.sh #V" 1>&2; exit 1; fi

NUM_VERTEX=$1
INDICATOR='##################################################                                                  '
    echo "Generating {±1}-weighted complete graphs of order $NUM_VERTEX ..."
for i in {1..100}
do
    echo -ne "[${INDICATOR:(50-$i/2):50}] ($i%)\r"
    ./rudy -clique $NUM_VERTEX -random 0 1 $NUM_VERTEX"$i" -times 2 -plus -1 >> WK"$NUM_VERTEX"_"$i".rud
done
echo
