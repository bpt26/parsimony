# 2_optimise_starting_tree

To properly test parsimony- and maximum-likelihood-based methods for tree optimization, we required a phylogeny pruned of all erroneous samples. This was accomplished in the previous step. In this section, we are most interested in taking that starting tree and testing various strategies for its optimization. In particular, we are interested in  testing [matOptimize](https://github.com/yatisht/usher), [IQ-TREE 2.1.3](http://www.iqtree.org/#download), and [FastTree2](http://www.microbesonline.org/fasttree/).

## 2.1 Set up the starting tree and the alignment

First, copy over the starting tree and full alignment from the previous step, and remove the reference sequence:

```
cp ../1_sample_selection/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta.xz alignment.fa.xz
xz -d alignment.fa.xz
cp ../1_sample_selection/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.nwk.gz starting.tree.gz
gunzip starting.tree.gz

# exclude unwanted ref seq from alignment
echo "NC_045512v2" > exclude.txt
faSomeRecords alignment.fa exclude.txt alignment_trimmed.fa -exclude
```


## 2.2 Optimise starting tree with parsimony in IQ-TREE and/or UShER

#### 2.2.1 IQ-TREE Apr27 Version

| Program   | Iteration | Parsimony score | Runtime (seconds) | SPR radius/rounds | Command                   |
|-----------|-----------|-----------------|-------------------|-------------------|---------------------------
| IQ-TREE   | 0         | 296247          | NA                | NA/NA             | |
| IQ-TREE   | 1         | 294719          | 46311*            | 20/100            |iqtree -n 0 -no-ml-dist -m JC -t starting.tree -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -parsimony-tbr 100 -spr-radius 20 -tbr-radius 20 --suppress-list-of-sequences -nt 100 -fast -pre iqtree_iteration1|
| IQ-TREE   | 2         | 294519          | 11324*            | 40/100            |iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration1.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -parsimony-tbr 100 -spr-radius 40 -tbr-radius 20 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration2|
| IQ-TREE   | 3         | 294411          | 21459             | 60/100            |iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration2.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 60 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration3|
| IQ-TREE   | 4         | 294330          | 48675             | 80/100            |iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration3.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 80 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration4|
| IQ-TREE   | 5         | 294250          | 112034            | 100/100           |iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration4.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 100 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration5|

The other IQ-TREE times increase because I was tentatively increasing the SPR radius. I think one can usually expect that a single run with a larger SPR radius is sufficient (each attempts 100 rounds of SPR or until no further improvements are found)


#### 2.2.2 IQ-TREE May24 Version

| Program   | Iteration | Parsimony score | Runtime (seconds) | SPR radius/rounds | Command |
|-----------|-----------|-----------------|-------------------|-------------------|---------|
| IQ-TREEM24| 0         | 296247          | NA                | NA/NA             | |
| IQ-TREEM24| 1         | 294720    	     | 1524              | 20/100            | iqtree2 -n 0 -no-ml -t starting.tree -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 20 --suppress-list-of-sequences -nt 100 -pre iqtreemay24_iteration1 |
| IQ-TREEM24| 2         | 294258    	     | 86729             | 100/100           | iqtree2 -n 0 -no-ml -t iqtreemay24_iteration1.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 100 --suppress-list-of-sequences -nt 100 -pre iqtreemay24_iteration2 |

* For IQ-TREEM24, I did one iteration at SPR radius 20, and one at 100.

#### 2.2.3 UShER

```
# Optimization using UShER (matOptimize)

# 1. Generate starting protobuf (iter-0.pb) for matOptimize
faToVcf -ref=NC_045512v2 alignment.fa alignment.vcf
usher -t starting.tree -v alignment.vcf -o iter-0.pb

# Another version of matOptimize
/usr/bin/time build/tree_rearrange_new  -v alignment.vcf -t starting.tree -o from_start_tree.pb -T 32
matUtils extract -i from_start_tree.pb -t from_start_tree.tree 
 
# 2. Three rounds of matOptimize with radius 10 followed by one round with radius 40
for i in `seq 0 2`; do
    j=$((i+1))
    matOptimize -i iter-${i}.pb -v alignment.vcf -o iter-${j}.pb -r 10 -T 32 -s 259200 2>&1 | tee iter_$j.log 
done 
matOptimize -i iter-3.pb -v alignment.vcf -o iter-4.pb -r 40 -T 32 -s 259200 2>&1 | tee iter_4.log 

# 3. Get output trees for each iteration and compress files
for i in `seq 1 4`; do
    matUtils extract -i iter-${i}.pb -t iter-${i}.tree 
    xz -e iter-${i}.tree 
done 

# Continue optimizing with another version of matOptimize
/usr/bin/time build/tree_rearrange_new  -v alignment.vcf -t iter-4.tree -o continue_iter4.pb -T 32
matUtils extract -i continue_iter4.pb -t continue_iter4.tree 

```

| Program   | Iteration | Parsimony score | Runtime (seconds) | SPR radius/rounds |
|-----------|-----------|-----------------|-------------------|-------------------|
| UShER     | 0         | 296248          | NA                | NA/NA             |
| UShER*    | 1         | 294022          | 4324              | 10/1              |
| UShER     | 1         | 294476          | 24358             | 10/1              |
| UShER     | 2         | 294353          | 24203             | 10/1              |
| UShER     | 3         | 294343          | 23241             | 10/1              |
| UShER     | 4         | 294307          | 71972             | 40/1              |
| UShER*    | 5         | 294005          | 2323.05           | 10/1              |
| UShER-new | 0         | 296248          | NA                | NA/NA             |
| UShER-new | 1         | 294318          | 9419.3            | 10/1              |
| UShER-new | 1         | 294313          | 6537.2            | 100/1             |


UShER* denotes another version of matOptimize at https://github.com/yceh/usher/tree/Refactor-FS-cleanup.

* longer because I forgot to switch of ml branch length optimisation, and/or because it had TBR moves in as well (which never helped so I turned off)

NB - the difference between UShER and IQ-TREE may at first seem a little odd. Why don't both get the same parsimony score when they have the same SPR radius. There are two differences. First, UShER is doing one round (if I undersood correctly) of SPR moves, and IQ-TREE is doing 100. This should make UShER worse. But UShER gets a *better* score than IQ-TREE with a radius of 40 (294307 vs. 294519). The other difference is that UShER has 'true' polytomies. So a radius of 40 can trivially see through a large polytomy. IQ-TREE does not have true polytomies. Instead it has minimum branch lengths. This means that IQ-TREE SPR moves may not see through large true polytomies, simply because they are represented as randomly-resolved bifurcating trees. 


#### 2.2.4 Parsimony using the best ML tree as the starting tree

This uses the output of 5th iteration of IQ-TREE as starting tree.

| Program   | Iteration | Parsimony score | Runtime (seconds)   | SPR radius/rounds | Command |
|-----------|-----------|-----------------|---------------------|-------------------|---------|
| UShER*    | 1         | 293862          | 2400.49 (80 threads)| 10/1              | /usr/bin/time build/tree_rearrange_new  -v alignment.vcf -t iqtree_iteration5.treefile -o after-iqtree-iter5.pb # default 80 threads
matUtils extract -i after-iqtree-iter5.pb -t after-iqtree-iter5.tree |


## 2.3 Optimise starting tree with pseudo-likelihood in FastTreeMP

#### 2.3.1 FastTree 

Prior to running this set of commands, I set `export OMP_NUM_THREADS=3`, and after the last iteration, I set `unset OMP_NUM_THREADS`.

| Program   | Iteration | Likelihood score|delta lnL| Runtime (seconds) | Parsimony | Command |
|-----------|-----------|-----------------|---------|-------------------|-----------|---------|
| FastTree2 | 1         | -3216096.685    | NA      | 154416.68         | 294556    |FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree1.log -nosupport -intree starting.tree alignment_trimmed.fa > fasttree_iteration1.tree|
| FastTree2 | 2         | -3214132.001    | 1965    | 139342.44         | 294369    |FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree2.log -nosupport -intree fasttree_iteration1.tree alignment_trimmed.fa > fasttree_iteration2.tree|
| FastTree2 | 3         | -3213128.398    | 1004    | 160561.60         | 294275    |FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree3.log -nosupport -intree fasttree_iteration2.tree alignment_trimmed.fa > fasttree_iteration3.tree|
| FastTree2 | 4         | -3212658.998    | 469     | 154413.03         | 294216    |FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree4.log -nosupport -intree fasttree_iteration3.tree alignment_trimmed.fa > fasttree_iteration4.tree|
| FastTree2 | 5         | -3212241.987    | 417     | 135245.66         | 294181    |FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree5.log -nosupport -intree fasttree_iteration4.tree alignment_trimmed.fa > fasttree_iteration5.tree|
| FastTree2 | 6         | -3211964.338    | 278     | 163389.24         | 294154    |FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree6.log -nosupport -intree fasttree_iteration5.tree alignment_trimmed.fa > fasttree_iteration6.tree|

```
# Compute parsimony scores using UShER
for i in `seq 1 6`; do
    ./usher  -t fasttree_iteration${i}.tree -v alignment.vcf -o fasttree_iteration${i}.pb -T 32 2>&1 | tee fasttree_iteration${i}.parsimony 
done
```


#### 2.3.1 FastTree with the best MP tree as a starting tree

As in the previous step, prior to running this command, I set `export OMP_NUM_THREADS=3`, and afterwards, I set `unset OMP_NUM_THREADS`.

| Program   | Iteration | Likelihood score| Runtime (seconds) | Parsimony | Command |
|-----------|-----------|-----------------|-------------------|-----------|---------|
| FastTree2 | 1         | -3213087.116    | 221528.63         | 294240    |FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree_mpstart.log -nosupport -intree iqtree_iteration5.treefile alignment_trimmed.fa > fasttree__iqtree5start.tree|

```
# Compute parsimony score using UShER
./usher -t fasttree__iqtree5start.tree -v alignment.vcf -o fasttree__iqtree5start.pb -T 32 2>&1 | tee fasttree__iqtree5start.parsimony 
```

#### 2.3.2 Optimize best ML tree for parsimony

```
./matOptimize -i fasttree_iteration6.pb -v alignment.vcf -r 100 -m 0.0 -o usher-optimized-fasttree_iteration6.pb -T 32 2>&1 | tee usher-optimized-fasttree.log
./matUtils extract -i usher-optimized-fasttree_iteration6.pb -t usher-optimized-fasttree_iteration6.tree
```

| Program   | Iteration | Runtime (seconds) | Parsimony |
|-----------|-----------|-------------------|-----------|
| UShER-new | 1         | 8811              | 293899    |

```
/usr/bin/time build/tree_rearrange_new  -v alignment.vcf -t usher-optimized-fasttree_iteration6.tree -o after_usher_optimized_fasttree_iter6.pb # default 80 threads
matUtils extract -i after_usher_optimized_fasttree_iter6.pb -t after_usher_optimized_fasttree_iter6.tree 

```

| Program   | Iteration | Parsimony score | Runtime (seconds) | SPR radius/rounds |
|-----------|-----------|-----------------|-------------------|-------------------|
| UShER*    | 1         | 293866          | 988.16 (80 threads)| 10/1              |



## 2.4 Clean up

```
xz -e alignment.fa
xz -e alignment_trimmed.fa
xz -e starting.tree
```
