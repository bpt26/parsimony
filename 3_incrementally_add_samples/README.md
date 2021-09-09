# incrementally add samples

In this directory, we separate the files from our data-set by the date that the sample was taken. We then organize these dates into batches, such that each batch contains roughly 4,000 samples. The goal here is to model the phylogenetic data accumulation that occurred over the course of the pandemic, using both parsimony- and ML-based strategies.

## Setup

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

# Results

Redone on openStack instances to ensure equal footing for time and data usage.

Currently running on root@public-tree:/mnt/PARSIMONY_REAL_DATA/ :

## Iterative IQ-TREE 2

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk (FT) | LogLk (IQ) |
|-----------|-----------------|---------|-----------------|----------|-----------|------------|------------|
| 1 | 4676 | 15 | 0h:XXXm:XXXs | XXX | 3450 | -81861.230 | -76785.808 |
| 2 | 8902 | 15 | 0h:15m:01s | 15315600 | 6207 | -115623.102 | -106814.412 |
| 3 | 13241 | 15 | 0h:49m:33s | 28480724 | 8895 | -150283.072 | -137242.499 |
| 4 | 17941 | 15 | 1h:41m:58s | 42748864 | 11778 | -188785.919 | -171191.606 |
| 5 | 22012 | 15 | 1h:59m:52s | 56679020 | 14284 | -222151.740 | -200744.488 |
| 6 | 26486 | 15 | 3h:06m:25s | 72230184 | 17057 | -259529.404 | -234099.578 |
| 7 | 30989 | 15 | 5h:08m:46s | 87786328 | 19803 | XXX | -267889.672 |
| 8 | 35323 | 15 | 6h:28m:18s | 103261896 | 22770 | XXX | -304247.326 |
| 9 | 39621 | 15 | 8h:00m:14s | 120021168 | 26169 | XXX | -345265.616 |
| 10 | 43808 | 15 | 7h:37m:48s | 136283756 | 29358 | XXX | XXX |
| 11 | 47819 | 15 | 9h:09m:30s | 152076244 | 32492 | XXX | XXX |
| 12 | 51899 | 15 | 0h:XXXm:XXXs | XXX | | XXX | XXX |


## Iterative FastTree2

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk (FT) | LogLk (IQ) |
|-----------|-----------------|---------|-----------------|----------|-----------|------------|------------|
| 1 | 4676 | 15 | 0h:51m:35s | 1081716 | 3664 | -81569.037 | -76682.633 |
| 2 | 8902 | 15 | 2h:43m:36s | 2099676 | 6705 | -115149.557 | -106696.088 |
| 3 | 13241 | 15 | 4h:15m:47s | 3185540 | 9758 | -149608.904 | -137119.963 |
| 4 | 17941 | 15 | 10h:57m:33s | 4481752 | 13170 | XXX | XXX |
| 5 | 22012 | 15 | 14h:43m:17s | 5550836 | 16103 | XXX | XXX |
| 6 | 26486 | 15 | 12h:02m:29s | 6531484 | 19225 | XXX | XXX |
| 7 | 30989 | 15 | 11h:31m:45s | 7616044 | 22299 | XXX | XXX |
| 8 | 35323 | 15 | XXX | XXX | | XXX | XXX |

## Iterative matOptimize

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk (FT) | LogLk (IQ) |
|-----------|-----------------|---------|-----------------|----------|-----------|------------|------------|
| 1 | 4676 | 15 | XXX | XXX | 3438 | -76125.904 | -76712.635 |
| 2 | 8902 | 15 | XXX | XXX | 6193 | -105301.409 | -106736.717 |
| 3 | 13241 | 15 | XXX | XXX | 8876 | -134460.419 | -137154.586 |
| 4 | 17941 | 15 | XXX | XXX | 11759 | -166881.393 | -171091.472 |
| 5 | 22012 | 15 | XXX | XXX | 14263 | -194960.652 | -200618.989 |
| 6 | 26486 | 15 | XXX | XXX | 17033 | -226532.726 | -233915.281 |
| 7 | 30989 | 15 | XXX | XXX | 19771 | -258530.528 | -267631.562 |
| 8 | 35323 | 15 | XXX | XXX | 22735 | -292760.826 | -303950.225 |
| 9 | 39621 | 15 | XXX | XXX | 26124 | -331221.302 | -344871.380 |
| 10 | 43808 | 15 | XXX | XXX | 29304 | -367320.623 | -383426.103 |
| 11 | 47819 | 15 | XXX | XXX | 32430 | -402116.635 | -420759.417 |
| 12 | 51899 | 15 | XXX | XXX | 36691 | -447980.710 | -470343.935 |
| 13 | 56308 | 15 | XXX | XXX | 40472 | -488857.863 | |
| 14 | 60571 | 15 | XXX | XXX | 44040 | -527310.958 | |
| 15 | 64666 | 15 | XXX | XXX | 47190 | XXX | | 
| 16 | 69052 | 15 | XXX | XXX | 50132 | XXX | | 
| 17 | 73231 | 15 | XXX | XXX | 52859 | XXX | | 
| 18 | 77399 | 15 | XXX | XXX | 55633 | XXX | | 
| 19 | 81802 | 15 | XXX | XXX | 59032 | XXX | | 
| 20 | 85946 | 15 | XXX | XXX | 62035 | XXX | | 
| 21 | 90062 | 15 | XXX | XXX | 64694 | XXX | | 
| 22 | 94384 | 15 | XXX | XXX | 67481 | XXX | | 
| 23 | 98578 | 15 | XXX | XXX | 70073 | XXX | | 
| 24 | 103052 | 15 | XXX | XXX | 72930 | XXX | | 
| 25 | 107441 | 15 | XXX | XXX | 75883 | XXX | | 
| 26 | 112716 | 15 | XXX | XXX | 79187 | XXX | | 
| 27 | 116999 | 15 | XXX | XXX | 82320 | XXX | | 
| 28 | 122802 | 15 | XXX | XXX | 86315 | XXX | | 
| 29 | 128292 | 15 | XXX | XXX | 89877 | XXX | | 
| 30 | 133990 | 15 | XXX | XXX | 93987 | XXX | | 
| 31 | 138764 | 15 | XXX | XXX | 97657 | XXX | | 
| 32 | 144037 | 15 | XXX | XXX | 101735 | XXX | | 
| 33 | 149574 | 15 | XXX | XXX | 106038 | XXX | | 
| 34 | 154358 | 15 | XXX | XXX | 109618 | XXX | | 
| 35 | 158404 | 15 | XXX | XXX | 113252 | XXX | | 
| 36 | 162559 | 15 | XXX | XXX | 116418 | XXX | | 
| 37 | 166621 | 15 | XXX | XXX | 119945 | XXX | | 
| 38 | 170826 | 15 | XXX | XXX | 123928 | XXX | | 
| 39 | 176258 | 15 | XXX | XXX | 128217 | XXX | | 
| 40 | 182077 | 15 | XXX | XXX | 132370 | XXX | | 
| 41 | 187490 | 15 | XXX | XXX | 136019 | XXX | | 
| 42 | 192049 | 15 | XXX | XXX | 139229 | XXX | | 
| 43 | 196853 | 15 | XXX | XXX | 143208 | XXX | | 
| 44 | 201995 | 15 | XXX | XXX | 149578 | XXX | | 
| 45 | 207246 | 15 | XXX | XXX | 154485 | XXX | | 
| 46 | 212424 | 15 | XXX | XXX | 159974 | XXX | | 
| 47 | 217254 | 15 | XXX | XXX | 165392 | XXX | | 
| 48 | 223132 | 15 | XXX | XXX | 171816 | XXX | | 
| 49 | 227555 | 15 | XXX | XXX | 176514 | XXX | | 
| 50 | 233326 | 15 | XXX | XXX | 182075 | XXX | | 

## Non-Iterative matOptimize

Currently running on root@fasttree:/mnt/FROM_SCRATCH :

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk (FT) | LogLk (IQ) |
|-----------|-----------------|---------|-----------------|----------|-----------|------------|------------|
| 1 | 4676 | 15 | XXX | XXX | 3438 | XXX | -76714.884 |
| 2 | 8902 | 15 | XXX | XXX | 6193 | XXX | -106771.327 |
| 3 | 13241 | 15 | XXX | XXX | 8877 | XXX | -137179.148 |
| 4 | 17941 | 15 | XXX | XXX | 11757 | XXX | -171107.534 |
| 5 | 22012 | 15 | XXX | XXX | 14262 | XXX | -200743.191 |
| 6 | 26486 | 15 | XXX | XXX | 17033 | XXX | -234137.959 |
| 7 | 30989 | 15 | XXX | XXX | 19770 | XXX | -267885.309 |
| 8 | 35323 | 15 | XXX | XXX | 22731 | XXX | -304140.908 |
| 9 | 39621 | 15 | XXX | XXX | 26126 | XXX | -345098.303 |
| 10 | 43808 | 15 | XXX | XXX | 29309 | XXX | XXX |
| 11 | 47819 | 15 | XXX | XXX | 32434 | XXX | XXX |
| 12 | 51899 | 15 | XXX | XXX | 36694 | XXX | XXX |
| 13 | 56308 | 15 | XXX | XXX | 40480 | XXX | |
| 14 | 60571 | 15 | XXX | XXX | 44047 | XXX | |
| 15 | 64666 | 15 | XXX | XXX | 47196 | XXX | | 
| 16 | 69052 | 15 | XXX | XXX | 50135 | XXX | | 
| 17 | 73231 | 15 | XXX | XXX | 52866 | XXX | | 
| 18 | 77399 | 15 | XXX | XXX | 55641 | XXX | | 
| 19 | 81802 | 15 | XXX | XXX | 59042 | XXX | | 
| 20 | 85946 | 15 | XXX | XXX | 62048 | XXX | | 
| 21 | 90062 | 15 | XXX | XXX | 64700 | XXX | | 
| 22 | 94384 | 15 | XXX | XXX | 67483 | XXX | | 
| 23 | 98578 | 15 | XXX | XXX | 70079 | XXX | | 
| 24 | 103052 | 15 | XXX | XXX | 72937 | XXX | | 
| 25 | 107441 | 15 | XXX | XXX | 75892 | XXX | | 
| 26 | 112716 | 15 | XXX | XXX | 79197 | XXX | | 
| 27 | 116999 | 15 | XXX | XXX | 82332 | XXX | | 
| 28 | 122802 | 15 | XXX | XXX | 86328 | XXX | | 
| 29 | 128292 | 15 | XXX | XXX | 89888 | XXX | | 
| 30 | 133990 | 15 | XXX | XXX | 94006 | XXX | | 
| 31 | 138764 | 15 | XXX | XXX | 97673 | XXX | | 
| 32 | 144037 | 15 | XXX | XXX | 101756 | XXX | | 
| 33 | 149574 | 15 | XXX | XXX | 106057 | XXX | | 
| 34 | 154358 | 15 | XXX | XXX | 109639 | XXX | | 
| 35 | 158404 | 15 | XXX | XXX | 113272 | XXX | | 
| 36 | 162559 | 15 | XXX | XXX | 116439 | XXX | | 
| 37 | 166621 | 15 | XXX | XXX | 119965 | XXX | | 
| 38 | 170826 | 15 | XXX | XXX | 123949 | XXX | | 
| 39 | 176258 | 15 | XXX | XXX | 128236 | XXX | | 
| 40 | 182077 | 15 | XXX | XXX | 132387 | XXX | | 
| 41 | 187490 | 15 | XXX | XXX | 136039 | XXX | | 
| 42 | 192049 | 15 | XXX | XXX | 139255 | XXX | | 
| 43 | 196853 | 15 | XXX | XXX | 143233 | XXX | | 
| 44 | 201995 | 15 | XXX | XXX | 149601 | XXX | | 
| 45 | 207246 | 15 | XXX | XXX | 154512 | XXX | | 
| 46 | 212424 | 15 | XXX | XXX | 159997 | XXX | | 
| 47 | 217254 | 15 | XXX | XXX | 165420 | XXX | | 
| 48 | 223132 | 15 | XXX | XXX | 171842 | XXX | | 
| 49 | 227555 | 15 | XXX | XXX | 176540 | XXX | | 
| 50 | 233326 | 15 | XXX | XXX | 182097 | XXX | | 


## Unoptimized UShER

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk (FT) | LogLk (IQ) |
|-----------|-----------------|---------|-----------------|----------|-----------|------------|------------|
| 1 | 4676 | 15 | XXX | XXX | 3464 | XXX | -76909.606 |
| 2 | 8902 | 15 | XXX | XXX | 6247 | XXX | -107309.132 |
| 3 | 13241 | 15 | XXX | XXX | 8992 | XXX | -137665.493 |
| 4 | 17941 | 15 | XXX | XXX | 11866 | XXX | -182943.119 |
| 5 | 22012 | 15 | XXX | XXX | 14410 | XXX | -217030.341 |
| 6 | 26486 | 15 | XXX | XXX | 17191 | XXX | -253701.534 |
| 7 | 30989 | 15 | XXX | XXX | 19982 | XXX | -289203.828 |
| 8 | 35323 | 15 | XXX | XXX | 22877 | XXX | -326908.362 |
| 9 | 39621 | 15 | XXX | XXX | 26310 | XXX | -368810.577 |
| 10 | 43808 | 15 | XXX | XXX | 29467 | | |
| 11 | 47819 | 15 | XXX | XXX | 32654 | | |
| 12 | 51899 | 15 | XXX | XXX | 36957 | | |
| 13 | 56308 | 15 | XXX | XXX | 40782 | | |
| 14 | 60571 | 15 | XXX | XXX | 44374 | | |
| 15 | 64666 | 15 | XXX | XXX | 47572 | | |
| 16 | 69052 | 15 | XXX | XXX | 50530 | | |
| 17 | 73231 | 15 | XXX | XXX | 53266 | | |
| 18 | 77399 | 15 | XXX | XXX | 56086 | | |
| 19 | 81802 | 15 | XXX | XXX | 59443 | | |
| 20 | 85946 | 15 | XXX | XXX | 62452 | | |
| 21 | 90062 | 15 | XXX | XXX | 65124 | | |
| 22 | 94384 | 15 | XXX | XXX | 67951 | | |
| 23 | 98578 | 15 | XXX | XXX | 70587 | | |
| 24 | 103052 | 15 | XXX | XXX | 73474 | | |
| 25 | 107441 | 15 | XXX | XXX | 76427 | | |
| 26 | 112716 | 15 | XXX | XXX | 79741 | | |
| 27 | 116999 | 15 | XXX | XXX | 82877 | | |
| 28 | 122802 | 15 | XXX | XXX | 86884 | | |
| 29 | 128292 | 15 | XXX | XXX | 90474 | | |
| 30 | 133990 | 15 | XXX | XXX | 94594 | | |
| 31 | 138764 | 15 | XXX | XXX | 98262 | | |
| 32 | 144037 | 15 | XXX | XXX | 102358 | | |
| 33 | 149574 | 15 | XXX | XXX | 106694 | | |
| 34 | 154358 | 15 | XXX | XXX | 110304 | | |
| 35 | 158404 | 15 | XXX | XXX | 113971 | | |
| 36 | 162559 | 15 | XXX | XXX | 117148 | | |
| 37 | 166621 | 15 | XXX | XXX | 120711 | | |
| 38 | 170826 | 15 | XXX | XXX | 125003 | | |
| 39 | 176258 | 15 | XXX | XXX | 129045 | | |
| 40 | 182077 | 15 | XXX | XXX | 133217 | | |
| 41 | 187490 | 15 | XXX | XXX | 136817 | | |
| 42 | 192049 | 15 | XXX | XXX | 140091 | | |
| 43 | 196853 | 15 | XXX | XXX | 144059 | | |
| 44 | 201995 | 15 | XXX | XXX | 150448 | | |
| 45 | 207246 | 15 | XXX | XXX | 155378 | | |
| 46 | 212424 | 15 | XXX | XXX | 160899 | | |
| 47 | 217254 | 15 | XXX | XXX | 166352 | | |
| 48 | 223132 | 15 | XXX | XXX | 172807 | | |
| 49 | 227555 | 15 | XXX | XXX | 177495 | | |
| 50 | 233326 | 15 | XXX | XXX | 183098 | | |

## RAXML-NG

| Iteration | Total Sequences | Threads | Wall Clock Time |
|-----------|-----------------|---------|-----------------|
| 1 | 4676 | 24 | 240h+ |


* The initial run was killed after 240 hours of wall-clock time.


# Clean up
```
mkdir KEEP
mv *_samples.fasta KEEP/
tar cfJ batch.fastas.tar.xz KEEP/*
```

