# Make starting tree

This folder contains scripts to create a starting tree for subsequent analyses. Final results (and some intermediate files) of the below steps are included in the `output` directory of this folder.

**Input**: Samples and VCFs from the [daily-updated SARS-CoV-2 database](https://academic.oup.com/mbe/article/38/12/5819/6361626) as of March 18, 2021

**Output**: `output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.pb.gz` (the filtered bifurcating starting tree created with UShER)


---
### Tl;dr

The file you are likely most interested in is:

`output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta.xz`

You can decompress it like this:

`xz -d publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta`

This file contains 364,428 SARS-CoV-2 sequences that are in the public domain. The idea is that it will be useful for testing and benchmarking various inference methods.

One thing to note is that this file also contains a reference sequence used by UShER to create the protobuffer. For many application you might want to remove this sequence as follows:

```
echo "NC_045512v2" > exclude.txt
faSomeRecords publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta exclude.txt publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta_noreference.fa -exclude
```

If you're using this file for methods development, do note of course that there are currently around 10 million SARS-CoV-2 genomes in GISAID. So you should probably consider that any method you develop will likely have to scale to datasets many times bigger than this public dataset in the relatively near future. 

---

## Steps to reproduce

### Prepare input files
Some files are already included in the `input` folder. Download the rest of the files that we will use to make our starting tree.
```
cd input
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.pb
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.vcf.xz 
unxz publicMsa.2021-03-18.masked.vcf.xz 
gzip publicMsa.2021-03-18.masked.vcf  
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.fa.xz  
unxz publicMsa.2021-03-18.masked.fa.xz  
gzip publicMsa.2021-03-18.masked.fa  
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.nwk  
```

These files consist entirely of public sequences using scripts from [this repository](https://github.com/roblanf/sarscov2phylo). Also included in this directory is `wuhan.ref.fa`, which contains the [SARS-CoV-2 reference sequence](https://github.com/yatisht/usher/blob/master/test/NC_045512v2.fa), masked to N at all problematic sites.

### Filter incomplete/ambiguous samples
Retain only samples with at least 28kb of nt at positions where reference is non-N. VCF does not contain all sites, so use MSA.

```
cd .. && mkdir tmp
matUtils summary -i input/publicMsa.2021-03-18.masked.pb -s tmp/samples.tsv
python3 scripts/getFaCount.py # outputs count for each sample in bases conditional on that position not being N in ref, and .fa of those with counts >28000  (takes ~30 minutes)
awk '$2 >= 28000 {print}' tmp/sample_to_count.txt  | wc -l  
# 385753
cat tmp/28000_samples.fa | grep ">" | wc -l # 385753
```

#### Retain only samples with fewer than 2 characters that are not ['A','C','G','T','N','-'] and prune these from the .pb.
```
python scripts/getTable.py  
awk '$4 < 2 {print}' tmp/28000_samples.tsv | wc -l  
# 366492  
awk '$4 < 2 {print}' tmp/28000_samples.tsv | cut -f1 > tmp/retain_samples.txt  
wc -l tmp/retain_samples.txt  
# 366492  
matUtils extract -i input/publicMsa.2021-03-18.masked.pb --samples tmp/retain_samples.txt -o tmp/publicMsa.2021-03-18.pruned.pb  
gzip tmp/publicMsa.2021-03-18.pruned.pb
```

### Construct the tree
Use UShER to make our starting tree.
```
cat input/wuhan.ref.fa tmp/28000_samples_less_than_2_ambiguities.fa > tmp/28000_samples_less_than_2_ambiguities_with_ref.fa  
faToVcf -maskSites=input/problematic_sites_sarsCov2.v4.vcf tmp/28000_samples_less_than_2_ambiguities_with_ref.fa tmp/28000_samples_less_than_2_ambiguities.vcf  
python scripts/checkSites.py # Ensures that problematic sites are masked and output VCF without them. Prints message if problematic site is found.  
usher -v tmp/fixedVCF.vcf -t input/empty.nwk -o tmp/publicMsa.2021-03-18.masked.retain_samples.save.pb
# empty.nwk is a custom "tree" containing the first sample from the .vcf.
```

Remove high parsimony samples from the tree.
```
matUtils extract -i tmp/publicMsa.2021-03-18.masked.retain_samples.save.pb -a 6 -o tmp/temp.pb
matUtils extract -i tmp/temp.pb -b 30 -o tmp/temp2.pb
matUtils extract -i tmp/temp2.pb -a 6 -o tmp/temp.pb
# Once no additional samples have been removed by parsimony score filters, we can save this tree.
mv tmp/temp.pb output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb
matUtils extract -i output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -t output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.nwk
matUtils extract -i output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -v output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf
xz output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf
matUtils summary -i output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -s output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.tsv
python makeFa.py
xz output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta
```

Binarize tree (resolve polytomies by creating internal nodes with branch length 0). Necessary for compatibility with downstream programs.
```
matUtils extract -i output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -R -o output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.pb
matUtils extract -i output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.pb -t output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.nwk
gzip output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.*
```

The final starting bifurcating (resolved) MAT excluding incomplete and ambiguous sequences and pruned of high parsimony samples is at `output/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.pb.gz`. The multifurcating (collapsed) MAT is also in `output` along with Newick files for both trees.