# incrementally add samples

In this directory, we separate the files from our data-set by the date that the sample was taken. We then organize these dates into batches, such that each batch contains roughly 4,000 samples. The goal here is to model the phylogenetic data accumulation that occurred over the course of the pandemic, using both parsimony- and ML-based strategies.

#### First, download metadata file that contains dates for each sample, sort the samples by date, and create VCFs and MSAs for each batch.
```
wget https://hgwdev.gi.ucsc.edu/~angie/UShER_SARS-CoV-2/2021/03/18/public-2021-03-18.metadata.tsv.gz  
python getMetadata.py  
mkdir BATCH_SAMPLES/
python getBatches.py  
mkdir BATCH_VCFs/
bash getVCFs.sh
mkdir BATCH_FASTAS/
python makeFastas.py
```

#### Test UShER and matUtils tree-building and optimization:
```
mkdir INCREMENTAL_PBS/
bash makeTreesMatOptimizeParsimony.sh # This script adds each batch in order, optimizing after each step with matOptimize, and logging each optimization step.
```

#### After 50 batches have finished, extract trees and compress files:
```
parallel -j 12 < extractTrees.sh  
tar cfJ opt.pbs.tar.xz *.opt.pb  
tar cfJ opt.nwk.tar.xz *.opt.nwk  
```

#### Test ML optimization via several programs:
```
bash makeTreesFastTreeML.sh # This script binarizes the starting trees and calls FastTree to optimize, logging each step.
bash makeTreesRaxmlML.sh # Binarizes starting trees and calls RaxML-NG to optimize.
bash makeTreesIQTreeML.sh # Binarizes starting trees and calls IQ-TREE 2 to optimize.
```

#### Clean up
```
mkdir KEEP
mv *_samples.fasta KEEP/
tar cfJ batch.fastas.tar.xz KEEP/*
```

