# sample selection

#### First, download files and create MAT using UShER. This ensures that the MAT used in these experiments is derived directly from the masked VCF and MSA.
```
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.fa.xz  
unxz publicMsa.2021-03-18.masked.fa  
gzip publicMsa.2021-03-18.masked.fa  
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.nwk  
usher -t publicMsa.2021-03-18.nwk -v publicMsa.2021-03-18.masked.vcf -o publicMsa.2021-03-18.remake.pb # *make pb to ensure no inclusion of masked sites* 
```

These files consist entirely of public sequences using scripts from [this repository](https://github.com/roblanf/sarscov2phylo).

#### Remove long terminal branches (maximum length 6) and very long internal branches (max length 30). Repeat this process, recalculating parsimony scores after each round, until convergence.
```
matUtils extract -i publicMsa.2021-03-18.remake.pb -A mutation_paths.txt  
python readPathLens.py mutation_paths.txt  
wc -l samples_prune.txt # *converged when this file is empty*  
&#35; *3860*   
matUtils extract -i publicMsa.2021-03-18.remake.pb --samples samples_prune.txt --prune -o extract1.pb  
matUtils extract -i extract1.pb -A mutation_paths.txt  
python readPathLens.py mutation_paths.txt  
wc -l samples_prune.txt  
&#35; 1 # *this is the internal node 86112. we will prune using -b option:*  
matUtils extract -i extract1.pb -b 30 -o extract2.pb  
matUtils extract -i extract2.pb -A mutation_paths.txt  
python readPathLens.py mutation_paths.txt  
wc -l samples_prune.txt  
&#35; *0 samples_prune.txt*  
matUtils summary -i extract2.pb -s final_samples.tsv # *get list of samples in final tree*  
```

#### Retain only samples with 28kb of nt at positions where reference is non-N. VCF does not contain all sites, so use MSA.
```
python getFaCount.py # *outputs count for each sample in bases conditional on that position not being N in ref, and .fa of those with counts >28000*  
awk '$2 >= 28000 {print}' sample_to_count.txt  | wc -l  
&#35; 384621  
wc -l 28000_samples.fa  
&#35; 769242 (2*384621)  
xz 28000_samples.fa
```

#### Retain only samples with fewer than 2 characters that are not ['A','C','G','T','N','-'] and prune these from the .pb.
```
python getTable.py  
awk '$4 < 2 {print}' 28000_samples.tsv | wc -l  
&#35; 364834  
awk '$4 < 2 {print}' 28000_samples.tsv | cut -f1 > retain_samples.txt  
matUtils extract -i publicMsa.2021-03-18.remake.pb --samples retain_samples.txt -o publicMsa.2021-03-18.pruned.pb  
gzip publicMsa.2021-03-18.pruned.pb # in sample_selection directory   
xz 28000_samples_less_than_2_ambiguities.fa # in sample_selection directory   
matUtils extract -i publicMsa.2021-03-18.pruned.pb -t publicMsa.2021-03-18.pruned.nwk  
```
