# 2_optimise_starting_tree

The point here is to take the starting tree that we used to filter the data, and optimise it as rigorously as possible with two methods: likelihood and parsimony.


## 2.1 Set up the starting tree and the alignment

```
# Copy over the starting tree and the full alignment

cp ../1_sample_selection/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta.xz alignment.fa.xz
xz -d alignment.fa.xz
cp ../1_sample_selection/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.nwk.gz starting.tree.gz
gunzip starting.tree.gz


# exclude unwanted ref seq from alignment
echo "NC_045512v2" > exclude.txt
faSomeRecords alignment.fa exclude.txt alignment_trimmed.fa -exclude


```


## 2.2 Optimise starting tree with parsimony in IQ-TREE and/or UShER

```
# Optimisation with IQ-TREE (note that this is IQ-TREE from 27 Apr 2021 on the dev branch)

iqtree -n 0 -no-ml-dist -m JC -t starting.tree -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -parsimony-tbr 100 -spr-radius 20 -tbr-radius 20 --suppress-list-of-sequences -nt 100 -fast -pre iqtree_iteration1

iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration1.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -parsimony-tbr 100 -spr-radius 40 -tbr-radius 20 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration2

iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration2.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 60 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration3

iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration3.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 80 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration4

iqtree -n 0 -no-ml-dist -m JC -t iqtree_iteration4.treefile -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius 100 --suppress-list-of-sequences -blfix -nt 100 -fast -pre iqtree_iteration5


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

| Program   | Iteration | Parsimony score | Runtime (seconds) |
|-----------|-----------|-----------------|-------------------|
| UShER     | 0         | 296248          | NA                |
| UShER     | 1         | 294476          | 24358             |
| UShER     | 2         | 294353          | 24203             |
| UShER     | 3         | 294343          | 23241             |
| UShER     | 4         | 294307          | 71972             |
| IQ-TREE   | 0         | 296247          | NA                |
| IQ-TREE   | 1         | 294719          | 46311*            |
| IQ-TREE   | 2         | 294519          | 11324*            |
| IQ-TREE   | 3         | 294411          | 21459             |
| IQ-TREE   | 4         | 294330          | 48675             |
| IQ-TREE   | 5         | 294250          | 112034            |

* longer because I forgot to switch of ml branch length optimisation, and/or because it had TBR moves in as well (which never helped so I turned off)
The other IQ-TREE times increase because I was tentatively increasing the SPR radius. I think one can usually expect that a single run with a larger SPR radius is sufficient (each attempts 100 rounds of SPR or until no further improvements are found)

NB - the difference between UShER and IQ-TREE may at first seem a little odd. Why don't both get the same parsimony score when they have the same SPR radius. There are two differences. First, UShER is doing one round (if I undersood correctly) of SPR moves, and IQ-TREE is doing 100. This should make UShER worse. But UShER gets a *better* score than IQ-TREE with a radius of 40 (294307 vs. 294519). The other difference is that UShER has 'true' polytomies. So a radius of 40 can trivially see through a large polytomy. IQ-TREE does not have true polytomies. Instead it has minimum branch lengths. This means that IQ-TREE SPR moves may not see through large true polytomies, simply because they are represented as randomly-resolved bifurcating trees. 

This leads me to suspect that UShER should be able to do much better than IQ-TREE if we set the radius to 100, since IQ-TREE's score with a radius of 100 is still a little better than UShER's with a radius of 40. 

## 2.3 Optimise starting tree with pseudo-likelihood in FastTreeMP

```
export OMP_NUM_THREADS=3
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree1.log -nosupport -intree starting.tree alignment_trimmed.fa > fasttree_iteration1.tree
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree2.log -nosupport -intree fasttree_iteration1.tree alignment_trimmed.fa > fasttree_iteration2.tree
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree3.log -nosupport -intree fasttree_iteration2.tree alignment_trimmed.fa > fasttree_iteration3.tree
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree4.log -nosupport -intree fasttree_iteration2.tree alignment_trimmed.fa > fasttree_iteration4.tree
unset OMP_NUM_THREADS
```

| Program   | Iteration | Likelihood score| Runtime (seconds) | Parsimony |
|-----------|-----------|-----------------|-------------------|-----------|
| FastTree2 | 1         | -3216096.685    | 154416.68         | 294556    |
| FastTree2 | 2         | -3214132.001    | 139342.44         | 294369    |
| FastTree2 | 3         | -3213128.398    | 160561.60         | 294275    |
| FastTree2 | 4         | -3212658.998    | 154413.03         | 294216    |



## 2.4 Clean up

```
xz -e alignment.fa
```
