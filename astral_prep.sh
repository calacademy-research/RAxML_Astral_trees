#!/bin/bash
#make directories for the phylip files with name of uce locus
for f in uce*.nexus; do
    dir=$(basename $f .nexus)
    [ ! -d $dir ] && mkdir $dir
done

Rscript RCmds
