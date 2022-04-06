# Optimize starting tree

In this folder, we evaluate the performance of [matOptimize](https://github.com/yatisht/usher), [TreeRearrange](https://github.com/yceh/usher), [IQ-TREE 2.1.3](http://www.iqtree.org/#download), and [FastTree2](http://www.microbesonline.org/fasttree/) as optimization strategies. The best tree (highest log likelihood, lowest parsimony) was chosen as a ground truth phylogeny for use in simulated data experiments.

**Input**: The "starting tree" from folder 1

**Output**: `output/after_usher_optimized_fasttree_iter6.tree.xz`: An optimized version of the starting tree (six iterations of FastTree2 + one iteration of matOptimize). This tree is used as input in the analyses in folder 4.

The resulting trees and logs of each analysis are available in `results`.

---
## 2.1 Set up the starting tree and the alignment

First, copy over the starting tree and full alignment from folder 1, and remove the reference sequence:

```
cp ../1_make_starting_tree/output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta.xz input/alignment.fa.xz
xz -d input/alignment.fa.xz
cp ../1_make_starting_tree/output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.nwk.gz input/starting.tree.gz
gunzip input/starting.tree.gz

# exclude unwanted ref seq from alignment
echo "NC_045512v2" > tmp/exclude.txt
faSomeRecords input/alignment.fa tmp/exclude.txt tmp/alignment_trimmed.fa -exclude
```

## Test various optimization strategies
The below steps test different strategies of optimizing the starting tree. Steps in **2.3.1** and **2.3.3** were used to produce the final ground truth tree (`output/after_usher_optimized_fasttree_iter6.pb`).
## 2.2 Optimise starting tree with parsimony (IQ-TREE 2, matOptimize)

### 2.2.1 IQ-TREE Apr27 Version
The below experiments were performed with IQ-TREE 2.1.2 built on April 27, 2021

| Program   | Iteration | Parsimony score | Runtime (seconds) | SPR radius/rounds | Command                   |
|-----------|-----------|-----------------|-------------------|-------------------|---------------------------
| IQ-TREE   | 0         | 296247          | NA                | NA/NA             | |
| IQ-TREE   | 1         | 294719          | 46311*            | 20/100            |iqtree -n 0 -no-ml-dist -m JC -t starting.tree -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -parsimony-tbr 100 -spr-radius 20 -tbr-radius 20 --suppress-list-of-sequences -nt 100 -fast -pre iqtree_iteration1|
| IQ-TREE   | 2         | 294519          | 11324*            | 40/100            |iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration1.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -parsimony-tbr 100 -spr-radius 40 -tbr-radius 20 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration2|
| IQ-TREE   | 3         | 294411          | 21459             | 60/100            |iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration2.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 60 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration3|
| IQ-TREE   | 4         | 294330          | 48675             | 80/100            |iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration3.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 80 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration4|
| IQ-TREE   | 5         | 294250          | 112034            | 100/100           |iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration4.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 100 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration5|

The other IQ-TREE times increase because I was tentatively increasing the SPR radius. I think one can usually expect that a single run with a larger SPR radius is sufficient (each attempts 100 rounds of SPR or until no further improvements are found)

* longer because I forgot to switch of ml branch length optimisation, and/or because it had TBR moves in as well (which never helped so I turned off)

### 2.2.2 IQ-TREE May24 Version
The below experiments were performed with IQ-TREE 2.1.2 built on May 24, 2021

| Program | Iteration | Parsimony score | Runtime (seconds) | SPR radius/rounds | Command |
|---------|-----------|-----------------|-------------------|-------------------|---------|
| IQ-TREE | 0         | 296247          | NA                | NA/NA             | |
| IQ-TREE | 1         | 294720    	     | 1524              | 20/100            | iqtree2 -n 0 -no-ml -t starting.tree -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 20 --suppress-list-of-sequences -nt 100 -pre iqtreemay24_iteration1 |
| IQ-TREE | 2         | 294258    	     | 86729             | 100/100           | iqtree2 -n 0 -no-ml -t iqtreemay24_iteration1.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 100 --suppress-list-of-sequences -nt 100 -pre iqtreemay24_iteration2 |

* For IQ-TREEM24, I did one iteration at SPR radius 20, and one at 100.

### 2.2.3 matOptimize

#### 2.2.3.1 General Workflow
```
# Optimization using UShER (matOptimize)

# 1. Generate starting protobuf (iter-0.pb) for matOptimize
faToVcf -ref=NC_045512v2 alignment.fa alignment.vcf
usher -t starting.tree -v alignment.vcf -o iter-0.pb
 
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

```

#### 2.2.3.2 May 24, 2021 version of matOptimize

| Program   | Iteration | Parsimony score | Runtime (seconds) | SPR radius/rounds | Command |
|-----------|-----------|-----------------|-------------------|-------------------|---------|
|matOptimize| 0         | 296248          | NA                | NA/NA             |usher -t starting.tree -v alignment.vcf -o iter-0.pb|
|matOptimize| 1         | 294476          | 24358             | 10/1              |matOptimize -i iter-0.pb -v alignment.vcf -o iter-1.pb -r 10 -T 32 -s 259200|
|matOptimize| 2         | 294353          | 24203             | 10/1              |matOptimize -i iter-1.pb -v alignment.vcf -o iter-2.pb -r 10 -T 32 -s 259200|
|matOptimize| 3         | 294343          | 23241             | 10/1              |matOptimize -i iter-2.pb -v alignment.vcf -o iter-3.pb -r 10 -T 32 -s 259200|
|matOptimize| 4         | 294307          | 71972             | 40/1              |matOptimize -i iter-3.pb -v alignment.vcf -o iter-4.pb -r 40 -T 32 -s 259200|


#### 2.2.3.3 May 24, 2021 version of matOptimize

After running these iterations, we updated matOptimize such that it does less search space pruning, and evaluates pruning prior to performing pruning and placement. This update was made on May 24 2021 and is reflected in the current version of matOptimize as of June 2 2021. The results of this most current version of matOptimize are shown below.

| Program   | Iteration | Parsimony score | Runtime (seconds) | SPR radius/rounds | Command |
|-----------|-----------|-----------------|-------------------|-------------------|---------|
| matOptimize-new | 0         | 296248          | NA                | NA/NA             |usher -t starting.tree -v alignment.vcf -o iter-0.pb|
| matOptimize-new | 1         | 294318          | 9419.3            | 10/1              |matOptimize -i iter-0.pb -v alignment.vcf -o iter-1.pb -r 10 -T 32 -s 259200|
| matOptimize-new | 1         | 294313          | 6537.2            | 100/1             |matOptimize -i iter-0.pb -v alignment.vcf -o iter-1.pb -r 100 -T 32 -s 259200|

### 2.2.4 TreeRearrange

We also tested [TreeRearrange](https://github.com/yceh/usher/tree/Refactor-FS-cleanup) on both the starting tree (iteration 0) and the final tree (iteration 4) from step 2.2.3.2.

| Program   | Iteration | Parsimony score | Runtime (seconds) | SPR radius/rounds | Command |
|-----------|-----------|-----------------|-------------------|-------------------|---------|
|TreeRearrange| 1         | 294022          | 4324           | 10/1       |tree_rearrange_new  -v alignment.vcf -t starting.tree -o from_start_tree.pb -T 32<br />matUtils extract -i from_start_tree.pb -t from_start_tree.tree|
|TreeRearrange| 1 (After 4 rounds of matOptimize) | 294005          | 2323.05        | 10/1       |tree_rearrange_new -v alignment.vcf -t iter-4.tree -o continue_iter4.pb -T 32<br />matUtils extract -i continue_iter4.pb -t continue_iter4.tree|

### Note

The difference between UShER and IQ-TREE may at first seem a little odd. Why don't both get the same parsimony score when they have the same SPR radius. There are two differences. First, UShER is doing one round (if I undersood correctly) of SPR moves, and IQ-TREE is doing 100. This should make UShER worse. But UShER gets a *better* score than IQ-TREE with a radius of 40 (294307 vs. 294519). The other difference is that UShER has 'true' polytomies. So a radius of 40 can trivially see through a large polytomy. IQ-TREE does not have true polytomies. Instead it has minimum branch lengths in a birfurcating tree. This means that IQ-TREE SPR moves may not see through large true polytomies, simply because they are represented as randomly-resolved bifurcating trees. 

### 2.2.5 Parsimony using the best ML tree as the starting tree

This uses the output of 5th iteration of IQ-TREE as starting tree.

| Program   | Iteration | Parsimony score | Runtime (seconds)   | SPR radius/rounds | Command |
|-----------|-----------|-----------------|---------------------|-------------------|---------|
|TreeRearrange| 1         | 293862          | 2400.49 (80 threads)| 10/1              | /usr/bin/time build/tree_rearrange_new  -v alignment.vcf -t iqtree_iteration5.treefile -o after-iqtree-iter5.pb<br />matUtils extract -i after-iqtree-iter5.pb -t after-iqtree-iter5.tree |

## 2.3 Optimise starting tree with pseudo-likelihood in FastTreeMP

### 2.3.1 FastTree 

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


### 2.3.2 FastTree with the best MP tree as a starting tree

As in the previous step, prior to running this command, I set `export OMP_NUM_THREADS=3`, and afterwards, I set `unset OMP_NUM_THREADS`.

| Program   | Iteration | Likelihood score| Runtime (seconds) | Parsimony | Command |
|-----------|-----------|-----------------|-------------------|-----------|---------|
| FastTree2 | 1         | -3213087.116    | 221528.63         | 294240    |FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree_mpstart.log -nosupport -intree iqtree_iteration5.treefile alignment_trimmed.fa > fasttree__iqtree5start.tree|

```
# Compute parsimony score using UShER
./usher -t fasttree__iqtree5start.tree -v alignment.vcf -o fasttree__iqtree5start.pb -T 32 2>&1 | tee fasttree__iqtree5start.parsimony 
```


### 2.3.3 Optimize best ML tree for parsimony

Six iterations of FastTree2 (2.3.1) yielded the best log-likelihood. Now run one iteration of matOptimize.

#### 2.3.3.1 matOptimize

| Program   | Iteration | Parsimony | Runtime (seconds) | Command |
|-----------|-----------|-----------|-------------------|---------|
|matOptimize| 1         | 293899    | 8811              |./matOptimize -i fasttree_iteration6.pb -v alignment.vcf -r 100 -m 0.0 -o usher-optimized-fasttree_iteration6.pb -T 32<br />./matUtils extract -i usher-optimized-fasttree_iteration6.pb -t usher-optimized-fasttree_iteration6.tree|

#### 2.3.3.2 treeRearrange

| Program   | Iteration | Parsimony | Runtime (seconds)  | SPR radius/rounds | Command |
|-----------|-----------|-----------|--------------------|-------------------|---------|
|treeRearrange| 1         | 293866    | 988.16 (80 threads)| 10/1              |/usr/bin/time build/tree_rearrange_new  -v alignment.vcf -t usher-optimized-fasttree_iteration6.tree -o after_usher_optimized_fasttree_iter6.pb<br />matUtils extract -i after_usher_optimized_fasttree_iter6.pb -t after_usher_optimized_fasttree_iter6.tree|



---

After running the above experiments, the tree with the lowest parsimony and highest log likelihood was the one optimized by size iterations of FastTree 2 and one iteration of matOptimize. It is available in `output/after_usher_optimized_fasttree_iter6.tree`).