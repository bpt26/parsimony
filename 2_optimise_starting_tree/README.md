# 2_optimise_starting_tree

The point here is to take the starting tree that we used to filter the data, and optimise it as rigorously as possible with two methods: likelihood and parsimony.


## 2.1 Set up the starting tree and the alignment

```
# Copy over the starting tree and the full alignment

cp ../1_sample_selection/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta.xz alignment.fa.xz
xz -d alignment.fa.xz
cp ../1_sample_selection/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.nwk starting.tree


```


## 2.2 Optimise starting tree with parsimony in IQ-TREE and/or UShER

```
# Optimization using UShER (matOptimize)

# 1. Provide input MAT and VCF for round 1 using 32 threads for atmost 259200 seconds (72 hours)
./matOptimize -i publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -v publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf.gz -o usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -T 32 -s 259200

# 2. Two more rounds of optimization using 32 threads, after which the parsimony score was found to converge (note same input and output pb)
./matOptimize -i usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -v publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf.gz -o usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -T 32 -s 259200
./matOptimize -i usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -v publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf.gz -o usher-optimized-publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -T 32 -s 259200
```

## 2.3 Optimise starting tree with pseudo-likelihood in FastTreeMP

```
export OMP_NUM_THREADS=3
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree1.log -nosupport -intree starting.tree alignment.fa > iteration1.tree
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log fasttree2.log -nosupport -intree iteration1.tree alignment.fa > iteration2.tree
unset OMP_NUM_THREADS
```


## 2.4 Clean up

```
xz -e alignment.fa
```
