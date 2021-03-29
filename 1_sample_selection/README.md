# sample selection

#### First, download files and create MAT using UShER. This ensures that the MAT used in these experiments is derived directly from the masked VCF and MSA.
```
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.fa.xz  
unxz publicMsa.2021-03-18.masked.fa  
gzip publicMsa.2021-03-18.masked.fa  
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.nwk  
usher -t publicMsa.2021-03-18.nwk -v publicMsa.2021-03-18.masked.vcf -o publicMsa.2021-03-18.remake.pb # make pb to ensure no inclusion of masked sites
```

These files consist entirely of public sequences using scripts from [this repository](https://github.com/roblanf/sarscov2phylo).

#### Remove long terminal branches (maximum length 6) and very long internal branches (max length 30). Repeat this process, recalculating parsimony scores after each round, until convergence.
```
# Get mutation paths for each sample in our tree.
matUtils extract -i publicMsa.2021-03-18.remake.pb -A mutation_paths.txt  
# Count the number of mutations at each node. 
# If an internal node has parsimony ≥ 30 or a leaf has parsimony ≥ 6, output to samples_prune.txt.
python readPathLens.py mutation_paths.txt  
wc -l samples_prune.txt # converged when this file is empty
# 3860   
# Build subtree by pruning all but 430204 samples.
matUtils extract -i publicMsa.2021-03-18.remake.pb --samples samples_prune.txt --prune -o extract1.pb  # prune 3860 samples

# Get mutation paths for newly pruned tree, and repeat the process.
matUtils extract -i extract1.pb -A mutation_paths.txt  
python readPathLens.py mutation_paths.txt  
# This time, our samples_prune.txt file has only one entry. This is the internal node 86112, which we can prune using the -b option in matUtils.
wc -l samples_prune.txt  
# 1 
# Build subtree by pruning all but 430202 samples.
matUtils extract -i extract1.pb -b 30 -o extract2.pb  # prune node 86112 and descendent

# Repeat the process one more time. In this round, we find that our samples_prune.txt file is empty.
# This means that no internal node has parsimony ≥ 30 and no leaf has parsimony ≥ 6.
matUtils extract -i extract2.pb -A mutation_paths.txt  
python readPathLens.py mutation_paths.txt  
wc -l samples_prune.txt  
# 0 samples_prune.txt
matUtils summary -i extract2.pb -s final_samples.tsv # get list of samples in final tree  
```

#### Retain only samples with 28kb of nt at positions where reference is non-N. VCF does not contain all sites, so use MSA.
```
python getFaCount.py # outputs count for each sample in bases conditional on that position not being N in ref, and .fa of those with counts >28000  
awk '$2 >= 28000 {print}' sample_to_count.txt  | wc -l  
# 384621  
wc -l 28000_samples.fa  
# 769242 # This is 2*384621, and this file contains two lines for each sample: a header and a sequence.  
# Compress the .fasta file.
xz 28000_samples.fa 
```

#### Retain only samples with fewer than 2 characters that are not ['A','C','G','T','N','-'] and prune these from the .pb.
```
python getTable.py  
awk '$4 < 2 {print}' 28000_samples.tsv | wc -l  
# 364834  
awk '$4 < 2 {print}' 28000_samples.tsv | cut -f1 > retain_samples.txt  
matUtils extract -i publicMsa.2021-03-18.remake.pb --samples retain_samples.txt -o publicMsa.2021-03-18.pruned.pb  
gzip publicMsa.2021-03-18.pruned.pb # in sample_selection directory   
xz 28000_samples_less_than_2_ambiguities.fa # in sample_selection directory   
matUtils extract -i publicMsa.2021-03-18.pruned.pb -t publicMsa.2021-03-18.pruned.nwk  
```
