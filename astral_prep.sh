#!/bin/bash
# Make directories for the phylip files with name of uce locus and launch R code file RCmds
for f in uce*.nexus; do
    dir=$(basename $f .nexus)
    [ ! -d $dir ] && mkdir $dir
done

Rscript RCmds
