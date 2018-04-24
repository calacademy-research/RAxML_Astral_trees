# RAxML_Astral_trees
This project generates Astral-III species trees from gene trees generated from RAxML using UCE data generated by the Phyluce pipeline.

There are currently four scripts, three shell and one R.
The first script, astral_prep.sh, creates directories for each UCE alignment and calls an R sript, 'RCmds'.
The R script, RCmds, uses 'ips' and 'parallel' libraries to convert formats (nexus to phylip) and runs many instances of RAxML in parallel. It also calls a third script, 'run_RAxML.sh', which launches parallel RAxML analyses.
The fourth script, astral_run.sh, creates new directories, moves the RAxMl trees into one of the directories, merges all of the trees into a single file, moves the bootstrap files into a directory, creates a file with a list of paths pointing to each bootstrap file, and launches Astral-III.

If your UCE alignments have a lot of identical sequences, RAxML will generate a .reduced alignment that can be used to rerun the RAxML ML ands bootstrap analyses and then rerun Astral III.

there are two addition scripts appended with "_reduced" for RAxML and Astral analyses.
RCmds_reduced
Astral_run_reduced.sh

# Tutorial
1. clone the RAxML_Astral_trees git files to your home directory (or wherever you like):

``` 
$git clone https://github.com/calacademy-research/RAxML_Astral_trees.git
```
2. You will now have a directory with all required scripts in:
```
~/RAxML_Astral_trees
```
