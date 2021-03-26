# parsimony

# March 25  
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.fa.xz  
unxz publicMsa.2021-03-18.masked.fa  
gzip publicMsa.2021-03-18.masked.fa  
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.nwk  
wget https://hgwdev.gi.ucsc.edu/~angie/publicMsa/publicMsa.2021-03-18.masked.pb  
usher -t publicMsa.2021-03-18.nwk -v publicMsa.2021-03-18.masked.vcf -o publicMsa.2021-03-18.remake.pb # make pb to ensure no inclusion of masked sites  


matUtils extract -i publicMsa.2021-03-18.remake.pb -A mutation_paths.txt  
python readPathLens.py mutation_paths.txt  
wc -l samples_prune.txt # converged when this file is empty  
&#35; 3860   
matUtils extract -i publicMsa.2021-03-18.remake.pb --samples samples_prune.txt --prune -o extract1.pb  
matUtils extract -i extract1.pb -A mutation_paths.txt  
python readPathLens.py mutation_paths.txt  
wc -l samples_prune.txt  
&#35; 1 # this is the internal node 86112. we will prune using -b option:  
matUtils extract -i extract1.pb -b 30 -o extract2.pb  
matUtils extract -i extract2.pb -A mutation_paths.txt  
python readPathLens.py mutation_paths.txt  
wc -l samples_prune.txt  
&#35; 0 samples_prune.txt  
matUtils summary -i extract2.pb -s final_samples.tsv # get list of samples in final tree  


&#35; now, ensure that for each of these samples, must have at least 28kb of nt at positions where ref is non-N  
&#35; vcf is 29111 sites long, but only 251 Ns in wuhan ref sequence, meaning a few hundred non-N sites excluded from VCF. so we must use MSA  
python getFaCount.py # outputs count for each sample in bases conditional on that position not being N in reference, and .fa of those >28000  
awk '$2 >= 28000 {print}' sample_to_count.txt  | wc -l  
&#35; 384621  
wc -l 28000_samples.fa  
&#35; 769242 (2*384621)  
gzip 28000_samples.fa
