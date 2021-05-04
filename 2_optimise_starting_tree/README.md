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

iqtree -n 0 -no-ml-dist -m JC -t iteration1.tree -s alignment_trimmed.fa -parsimony-spr 100 -parsimony-nni 100 -parsimony-tbr 100 -spr-radius 20 -tbr-radius 20 --suppress-list-of-sequences -nt 100 -fast -pre iqtree_iteration2


# Optimization using UShER (matOptimize)

# 1. Provide input MAT and VCF for round 1 using 32 threads for atmost 259200 seconds (72 hours)
./matOptimize -i publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -v publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf.gz -o usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -T 32 -s 259200

# 2. Two more rounds of optimization using 32 threads, after which the parsimony score was found to converge (note same input and output pb)
./matOptimize -i usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -v publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf.gz -o usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -T 32 -s 259200
./matOptimize -i usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -v publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf.gz -o usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -T 32 -s 259200
```

| Iteration | Parsimony score | Runtime (seconds) |
|-----------|-----------------|-------------------|
| 0         | 297562          | N/A               |
| 1         | 295405          | 24085             |
| 2         | 295349          | 24574             |
| 3         | 295342          | 23966             |



| Program   | Iteration | Parsimony score | Runtime (seconds) |
|-----------|-----------|-----------------|-------------------|
| UShER     | 0         | 297562          | N/A               |
| UShER     | 1         | 295405          | 24085             |
| UShER     | 2         | 295349          | 24574             |
| UShER     | 3         | 295342          | 23966             |
| IQ-TREE   | 0         | 296247          |              	  |
| IQ-TREE   | 1         | 294719          |                   |


These parsimony scores are obviously being calculated differently. Not quite sure what the differences are, but we will cross-run the two trees in the opposite pieces of software to delve into it...

* Best UShER tree parsimony score in IQ-TREE: 
* Best IQ-TREE tree parsimony score in UShER:


## 2.3 Optimise starting tree with pseudo-likelihood in FastTreeMP

```
export OMP_NUM_THREADS=3
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree1.log -nosupport -intree starting.tree alignment_trimmed.fa > fasttree_iteration1.tree
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree2.log -nosupport -intree fasttree_iteration1.tree alignment_trimmed.fa > fasttree_iteration2.tree
unset OMP_NUM_THREADS
```

NB: this will take a while. The SPR moves are going slow... maybe a week or so...


## 2.4 Clean up

```
xz -e alignment.fa
```
