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

## Results

### matOptimize

| Iteration | Rounds of Optimization | Total Sequences | Threads | Wall Clock Time |
|-----------|------------------------|-----------------|---------|-----------------|
| 1 | 2 | 4676 | 32 | 0h:00m:00s |
| 2 | 1 | 8902 | 32 | 0h:00m:00s |
| 3 | 1 | 13241 | 32 | 0h:00m:00s |
| 4 | 2 | 17941 | 32 | 0h:00m:03s |
| 5 | 3 | 22012 | 32 | 0h:00m:10s |
| 6 | 2 | 26486 | 32 | 0h:00m:12s |
| 7 | 2 | 30989 | 32 | 0h:00m:14s |
| 8 | 2 | 35323 | 32 | 0h:00m:16s |
| 9 | 2 | 39621 | 32 | 0h:00m:18s |
| 10 | 2 | 43808 | 32 | 0h:00m:21s |
| 11 | 1 | 47819 | 32 | 0h:00m:12s |
| 12 | 2 | 51899 | 32 | 0h:00m:26s |
| 13 | 2 | 56308 | 32 | 0h:00m:30s |
| 14 | 2 | 60571 | 32 | 0h:00m:33s |
| 15 | 2 | 64666 | 32 | 0h:00m:37s |
| 16 | 2 | 69052 | 32 | 0h:00m:41s |
| 17 | 3 | 73231 | 32 | 0h:01m:06s |
| 18 | 2 | 77399 | 32 | 0h:00m:48s |
| 19 | 1 | 81802 | 32 | 0h:00m:26s |
| 20 | 1 | 85946 | 32 | 0h:00m:29s |
| 21 | 1 | 90062 | 32 | 0h:00m:31s |
| 22 | 1 | 94384 | 32 | 0h:00m:33s |
| 23 | 2 | 98578 | 32 | 0h:01m:48s |
| 24 | 2 | 103052 | 32 | 0h:01m:57s |
| 25 | 2 | 107441 | 32 | 0h:02m:30s |
| 26 | 2 | 112716 | 32 | 0h:02m:48s |
| 27 | 2 | 116999 | 32 | 0h:03m:03s |
| 28 | 2 | 122802 | 32 | 0h:03m:15s |
| 29 | 2 | 128292 | 32 | 0h:04m:25s |
| 30 | 2 | 133990 | 32 | 0h:05m:18s |
| 31 | 2 | 138764 | 32 | 0h:05m:42s |
| 32 | 2 | 144037 | 32 | 0h:06m:07s |
| 33 | 2 | 149574 | 32 | 0h:06m:45s |
| 34 | 3 | 154358 | 32 | 0h:10m:49s |
| 35 | 2 | 158404 | 32 | 0h:08m:1s |
| 36 | 2 | 162559 | 32 | 0h:08m:26s |
| 37 | 2 | 166621 | 32 | 0h:09m:25s |
| 38 | 3 | 170826 | 32 | 0h:14m:20s |
| 39 | 3 | 176258 | 32 | 0h:15m:15s |
| 40 | 3 | 182077 | 32 | 0h:16m:20s |
| 41 | 3 | 187490 | 32 | 0h:16m:56s |
| 42 | 2 | 192049 | 32 | 0h:11m:39s |
| 43 | 2 | 196853 | 32 | 0h:12m:11s |
| 44 | 2 | 201995 | 32 | 0h:12m:42s |
| 45 | 3 | 207246 | 32 | 0h:19m:57s |
| 46 | 2 | 212424 | 32 | 0h:13m:55s |
| 47 | 2 | 217254 | 32 | 0h:14m:21s |
| 48 | 3 | 223132 | 32 | 0h:23m:30s |
| 49 | 2 | 227555 | 32 | 0h:15m:57s |
| 50 | 2 | 233326 | 32 | 0h:16m:7s |

### FastTreeMP

| Iteration | Total Sequences | Threads | Wall Clock Time |
|-----------|-----------------|---------|-----------------|
| 1 | 4676 | 3 | 0h:56m:50s |
| 2 | 8902 | 3 | 1h:21m:56s |
| 3 | 13241 | 3 | 2h:49m:53s |
| 4 | 17941 | 3 | 3h:59m:28s |
| 5 | 22012 | 3 | 4h:33m:13s |
| 6 | 26486 | 10 | 6h:26m:6s |
| 7 | 30989 | 10 | 5h:28m:2s |
| 8 | 35323 | 10 | 7h:0m:14s |
| 9 | 39621 | 10 | 8h:51m:3s |
| 10 | 43808 | 10 | 8h:18m:35s |
| 11 | 47819 | 10 | 9h:10m:37s |
| 12 | 51899 | 10 | 13h:40m:10s |
| 13 | 56308 | 10 | 14h:58m:9s |
| 14 | 60571 | 10 | 17h:34m:12s |
| 15 | 64666 | 10 | 20h:45m:26s |
| 16 | 69052 | 10 | 23h:36m:00s |
| 17 | 73231 | 16 | 20h:43m:59s |
| 18 | 77399 | 16 | 20h:16m:06s |
| 19 | 81802 | 16 | 21h:07m:10s |
| 20 | 85946 | 16 | 19h:54m:26s |
| 21 | 90062 | 16 | 18h:35m:16s |
| 22 | 94384 | 16 | 22h:20m:16s |
| 23 | 98578 | 16 | 27h:32m:47s |

* Did not continue as the final run took more than one day to complete.

### IQTREE 2

| Iteration | Total Sequences | Threads | CPU Time | Wall Clock Time | RAM Requirement |
|-----------|-----------------|---------|----------|-----------------|-----------------|
| 1 | 4676 | 8 | 4h:21m:33s | 0h:39m:53s | 4771 MB |
| 2 | 8902 | 8 | 14h:40m:39s | 2h:11m:34s | 13197 MB |
| 3 | 13241 | 8 | 43h:24m:33s | 6h:7m:19s | 23987 MB |
| 4 | 17941 | 8 | 19h:35m:53s | 2h:44m:7s | 36334 MB |
| 5 | 22012 | 8 | 22h:44m:32s | 3h:28m:47s | 48472 MB |
| 6 | 26486 | 8 | 34h:34m:15s | 4h:59m:54s | 62005 MB |
| 7 | 30989 | 8 | 49h:4m:56s | 6h:59m:9s | 75543 MB |
| 8 | 35323 | 8 | 58h:15m:0s | 9h:8m:31s | 89021 MB |
| 9 | 39621 | 8 | 49h:18m:46s | 7h:42m:25s | 103693 MB |
| 10 | 43808 | 8 | 59h:39m:18s | 9h:50m:25s | 117915 MB |
| 11 | 47819 | 8 | 55h:27m:25s | 9h:16m:45s | 131615 MB |
| 12 | 51899 | 8 | 63h:33m:58s | 10h:31m:45s | 146499 MB |
| 13 | 56308 | 8 | 97h:32m:33s | 15h:33m:34s | 160814 MB |
| 14 | 60571 | 32 | 3517h:28m:24s | 152h:42m:53s | 174432 MB |

* Did not continue as the final run took more than one day to complete.

### RAXML-NG

| Iteration | Total Sequences | Threads | Wall Clock Time |
|-----------|-----------------|---------|-----------------|
| 1 | 4676 | 24 | 240h+ |


* The initial run was killed after 240 hours of wall-clock time.


## Clean up
```
mkdir KEEP
mv *_samples.fasta KEEP/
tar cfJ batch.fastas.tar.xz KEEP/*
```

