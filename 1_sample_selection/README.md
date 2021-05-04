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
# 385753
gzip -dc 28000_samples.fa.gz | grep ">" | wc -l  
# 385753
gzip 28000_samples.fa
```

#### Retain only samples with fewer than 2 characters that are not ['A','C','G','T','N','-'] and prune these from the .pb.
```
python getTable.py  
awk '$4 < 2 {print}' 28000_samples.tsv | wc -l  
# 366492  
awk '$4 < 2 {print}' 28000_samples.tsv | cut -f1 > retain_samples.txt  
wc -l retain_samples.txt  
# 366492  
matUtils extract -i publicMsa.2021-03-18.masked.pb --samples retain_samples.txt -o publicMsa.2021-03-18.pruned.pb  
gzip publicMsa.2021-03-18.pruned.pb # in sample_selection directory   
xz 28000_samples_less_than_2_ambiguities.fa # in sample_selection directory     
```

#### Use UShER to make our starting tree.
```
cat wuhan.ref.fa 28000_samples_less_than_2_ambiguities.fa > 28000_samples_less_than_2_ambiguities_with_ref.fa  
faToVcf -maskSites=problematic_sites_sarsCov2.vcf 28000_samples_less_than_2_ambiguities_with_ref.fa 28000_samples_less_than_2_ambiguities.vcf  
python checkSites.py # Ensures that problematic sites are masked and output VCF without them. Prints message if problematic site is found.  
usher -v fixedVCF.vcf -t empty.nwk -o publicMsa.2021-03-18.masked.retain_samples.save.pb
# empty.nwk is a custom "tree" containing the first sample from the .vcf.
```

#### Remove high parsimony samples from the tree.
```
matUtils extract -i publicMsa.2021-03-18.masked.retain_samples.save.pb -a 6 -o temp.pb
matUtils extract -i temp.pb -b 30 -o temp2.pb
matUtils extract -i temp2.pb -a 6 -o temp.pb
# Once no additional samples have been removed by parsimony score filters, we can save this tree.
mv temp.pb publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb
matUtils extract -i publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -t publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.nwk
matUtils extract -i publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -v publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf
xz publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.vcf
matUtils summary -i publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -s publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.tsv
python makeFa.py
xz publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta
```

#### Binarize tree
```
matUtils extract -i publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb -R -o publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.pb
matUtils extract -i publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.pb -t publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.nwk
gzip publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.binary.*

