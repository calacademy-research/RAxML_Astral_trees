#!/bin/bash
cd $(dirname $1)
id=$(basename $(dirname $1))
phy=$(basename $1)

~/standard-RAxML/raxmlHPC-AVX -f a -m GTRGAMMA -N 100 -x 12345 -p 25258 -n ${id}.txt -s $phy
