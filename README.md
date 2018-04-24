# RAxML_Astral_trees from a Phyluce UCE pipeline
This project generates Astral-III species trees from gene trees generated from RAxML using UCE data generated by the [Phyluce pipeline](http://phyluce.readthedocs.io/en/latest/tutorial-one.html# "Phyluce phylogeneomics pipeline") (ctrl-click to open in new window).

There are currently four scripts, three shell and one R.
The first script, astral_prep.sh, creates directories for each UCE alignment and calls an R sript, 'RCmds'.
The R script, RCmds, uses 'ips' and 'parallel' libraries to convert formats (nexus to phylip) and runs many instances of RAxML in parallel. It also calls a third script, 'run_RAxML.sh', which launches parallel RAxML analyses.
The fourth script, astral_run.sh, creates new directories, moves the RAxMl trees into one of the directories, merges all of the trees into a single file, moves the bootstrap files into a directory, creates a file with a list of paths pointing to each bootstrap file, and launches Astral-III.

If your UCE alignments have a lot of identical sequences, RAxML will generate a .reduced alignment that can be used to rerun the RAxML ML ands bootstrap analyses and then rerun Astral III.

there are two addition scripts appended with "_reduced" for RAxML and Astral analyses.
RCmds_reduced
Astral_run_reduced.sh

## Installation and prep for Ubuntu 16.04:
1. clone the RAxML_Astral_trees git files to your home directory (or wherever you like):

``` 
$git clone https://github.com/calacademy-research/RAxML_Astral_trees.git
```
2. You will now have a directory with all required scripts in:
```
~/RAxML_Astral_trees
```
3. Make sure R is installed and that the R libraries ips and parallel are installed. Launch R at the command prompt (you should see a greater than symbol as your new prompt '>') and enter install.packages(c("ips", "parallel")):
```
$ R
>
>install.packages(c("ips", "parallel"))
```
Printed and scrolling on screen, you will see the installation progress. You may get a message that one or both libraries already exists, which should be OK. If you get errors that you cannot resolve, you will have to consult your Sys Admin.

4. There are many ways to organize your data, but the following is what I do. I create symlinks for all of the scripts in the phyluce alignment directory, which contains all of your final uce nexus alignments, ~/ABySS/mafft-nexus-min75-taxa for e.g.:
```
$cd ~/ABySS/mafft-nexus-min75-taxa
~/ABySS/mafft-nexus-min75-taxa$ ln -s ~/RAxML_Astral_trees/astral_prep.sh astral_prep.sh
~/ABySS/mafft-nexus-min75-taxa$ ln -s ~/RAxML_Astral_trees/astral_run.sh astral_run.sh
~/ABySS/mafft-nexus-min75-taxa$ ln -s ~/RAxML_Astral_trees/run_RAxML.sh run_RAxML.sh
~/ABySS/mafft-nexus-min75-taxa$ ln -s ~/RAxML_Astral_trees/RCmds RCmds
```
5. YOu must edit the RCmds R script to set your working directory. Our example here is ~/ABySS/mafft-nexus-min75-taxa. Open the RCmds script in your favorite editor (I use vi or nano) and edit the line setwd("/my/working/directory/") to match your working directory. For e.g.:
```
$ setwd("~/ABySS/mafft-nexus-min75-taxa")
```
6. You must also edit the RCmds R script to set the number of threads to match what is available on your server. The deafult line is 'final_raxml = mclapply(cmd, system, mc.cores=getOption("mc.cores", 48))  ### 48 threads'. If your server has 16 threads available then replace 48 with 16 as follows:
```
$ final_raxml = mclapply(cmd, system, mc.cores=getOption("mc.cores", 16))  ### 16 threads
```
If you are not sure of the number threads available on your system do:
```
$cat /proc/cpuinfo | grep processor | wc -l
```
or launch htop, which will show all threads. If youv do not have htop installed do:
```
$ sudo apt-get install htop
```
7. You will need to edit the last line of the astral_run.sh file to match your prefered final tree name and the amount of memory in your system. The -Xmx100G flag tell java to use 100GB of RAM. Change this to match your system RAM. The end of this line names your final Astral species tree. Edit as you like.
```
java -Xmx100G -jar ~/ASTRAL/astral.5.5.6.jar -i tree_files/RAx_genetrees_merge.tre -b boot_trees/bootstrap.filedir.list.txt -r 100 -o My_AstralIII_sp_tree.tre

```
If you are not sure of how much RAM your system has, do:
```
$sudo lshw -class memory
```
## Run the scripts
1. The first step is to run 'astral_prep.sh' from your working directory (this example uses the '~/ABySS/mafft-nexus-min75-taxa' directory). Make sure all of the scripts are executable by you by running the following for each script:
```
$chmod +x astral_prep.sh
```
The run:
```
$./astral_run.sh
```
