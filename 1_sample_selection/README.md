# sample selection

#### First, download files that we will use to make our starting tree.
```
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.pb
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.vcf.xz 
unxz publicMsa.2021-03-18.masked.vcf.xz 
gzip publicMsa.2021-03-18.masked.vcf  
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.fa.xz  
unxz publicMsa.2021-03-18.masked.fa.xz  
gzip publicMsa.2021-03-18.masked.fa  
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.nwk  
wget https://raw.githubusercontent.com/W-L/ProblematicSites_SARS-CoV2/master/problematic_sites_sarsCov2.vcf
```

These files consist entirely of public sequences using scripts from [this repository](https://github.com/roblanf/sarscov2phylo). Also included in this directory is `wuhan.ref.fa`, which contains the [SARS-CoV-2 reference sequence](https://github.com/yatisht/usher/blob/master/test/NC_045512v2.fa), masked to N at all problematic sites.

#### Retain only samples with 28kb of nt at positions where reference is non-N. VCF does not contain all sites, so use MSA.

```
matUtils summary -i publicMsa.2021-03-18.masked.pb -s samples.tsv
python getFaCount.py # outputs count for each sample in bases conditional on that position not being N in ref, and .fa of those with counts >28000  
awk '$2 >= 28000 {print}' sample_to_count.txt  | wc -l  
# 387737  
wc -l 28000_samples.fa  
# 775474 (2*387737)  
gzip 28000_samples.fa
```

#### Retain only samples with fewer than 2 characters that are not ['A','C','G','T','N','-'] and prune these from the .pb.
```
python getTable.py  
awk '$4 < 2 {print}' 28000_samples.tsv | wc -l  
# 367744  
awk '$4 < 2 {print}' 28000_samples.tsv | cut -f1 > retain_samples.txt  
matUtils extract -i publicMsa.2021-03-18.masked.pb --samples retain_samples.txt -o publicMsa.2021-03-18.pruned.pb  
gzip publicMsa.2021-03-18.pruned.pb # in sample_selection directory   
xz 28000_samples_less_than_2_ambiguities.fa # in sample_selection directory     
```

#### Use UShER to make our starting tree.
```
faToVcf -maskSites=problematic_sites_sarsCov2.vcf 28000_samples_less_than_2_ambiguities.fa 28000_samples_less_than_2_ambiguities.vcf
usher -v 28000_samples_less_than_2_ambiguities.vcf -t empty.nwk -o 28000_samples_less_than_2_ambiguities.save.pb
# empty.nwk is a custom "tree" containing the first sample from the .vcf.
matUtils extract -i publicMsa.2021-03-18.masked.retain_samples.save.pb -t publicMsa.2021-03-18.masked.retain_samples.save.nwk
gzip publicMsa.2021-03-18.masked.retain_samples.save.*
```
