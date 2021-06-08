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
| 1 | 2 | 4676 | 32 | 0h:00m:12s |
| 2 | 1 | 8902 | 32 | 0h:00m:09s |
| 3 | 1 | 13241 | 32 | 0h:00m:23s |
| 4 | 2 | 17941 | 32 | 0h:02m:13s |
| 5 | 3 | 22012 | 32 | 0h:04m:57s |
| 6 | 2 | 26486 | 32 | 0h:04m:30s |
| 7 | 2 | 30989 | 32 | 0h:05m:43s |
| 8 | 2 | 35323 | 32 | 0h:08m:01s |
| 9 | 2 | 39621 | 32 | 0h:09m:34s |
| 10 | 2 | 43808 | 32 | 0h:13m:16s |
| 11 | 2 | 47819 | 32 | 0h:16m:36s |
| 12 | 2 | 51899 | 32 | 0h:19m:27s |
| 13 | 2 | 56308 | 32 | 0h:24m:51s |
| 14 | 2 | 60571 | 32 | 0h:29m:08s |
| 15 | 2 | 64666 | 32 | 0h:35m:24s |
| 16 | 2 | 69052 | 32 | 0h:42m:16s |
| 17 | 3 | 73231 | 32 | 1h:05m:14s |
| 18 | 2 | 77399 | 32 | 0h:50m:45s |
| 19 | 1 | 81802 | 32 | 0h:28m:26s |
| 20 | 1 | 85946 | 32 | 0h:31m:15s |
| 21 | 1 | 90062 | 32 | 0h:33m:13s |
| 22 | 1 | 94384 | 32 | 0h:36m:01s |
| 23 | 2 | 98578 | 32 | 1h:29m:42s |
| 24 | 2 | 103052 | 32 | 1h:34m:02s |
| 25 | 2 | 107441 | 32 | 1h:42m:59s |
| 26 | 2 | 112716 | 32 | 2h:01m:26s |
| 27 | 2 | 116999 | 32 | 2h:09m:25s |
| 28 | 2 | 122802 | 32 | 2h:31m:06s |
| 29 | 2 | 128292 | 32 | 2h:38m:26s |
| 30 | 2 | 133990 | 32 | 2h:55m:41s |
| 31 | 2 | 138764 | 32 | 3h:06m:40s |
| 32 | 2 | 144037 | 32 | 3h:17m:56s |
| 33 | 3 | 149574 | 32 | 5h:34m:14s |
| 34 | 2 | 60571 | 32 | 3h:33m:41s |
| 35 | 2 | 60571 | 32 | 3h:52m:56s |
| 36 | 2 | 60571 | 32 | 3h:46m:16s |
| 37 | 2 | 60571 | 32 | 3h:20m:08s |
| 38 | 2 | 60571 | 32 | 3h:37m:10s |
| 39 | 3 | 60571 | 32 | 6h:01m:20s |
| 40 | 2 | 60571 | 32 | 4h:13m:24s |
| 41 | 2 | 60571 | 32 | 4h:38m:44s |
| 42 | 2 | 60571 | 32 | 4h:39m:43s |
| 43 | 2 | 60571 | 32 | 4h:59m:17s |
| 44 | 2 | 60571 | 32 | 5h:07m:51s |
| 45 | 2 | 60571 | 32 | 4h:47m:17s |
| 46 | 2 | 60571 | 32 | 4h:49m:24s |
| 47 | 2 | 60571 | 32 | 5h:06m:48s |
| 48 | 2 | 60571 | 32 | 5h:18m:51s |
| 49 | 2 | 60571 | 32 | 5h:32m:08s |
| 50 | 2 | 60571 | 32 | 5h:57m:52s |
| 51 | 2 | 60571 | 32 | 6h:13m:35s |
| 52 | 2 | 60571 | 32 | 6h:42m:15s |
| 53 | 3 | 60571 | 32 | 10h:24m:36s |
| 54 | 3 | 60571 | 32 | 10h:56m:37s |
| 55 | 2 | 60571 | 32 | 7h:46m:17s |
| 56 | 3 | 60571 | 32 | 15h:26m:22s |
| 57 | 2 | 60571 | 32 | 14h:44m:58s |
| 58 | 2 | 60571 | 32 | 29h:39:16s |
| 59 | 2 | 60571 | 32 | 27h:33:47s |
| 60 | 2 | 60571 | 32 | 23h:37m:12s |
| 61 | 2 | 60571 | 32 | 16h:22m:31s |
| 62 | 2 | 60571 | 32 | 16h:33m:00s |
| 63 | 2 | 60571 | 32 | 13h:30m:37s |
| 64 | 2 | 60571 | 32 | 14h:10m:14s |
| 65 | 2 | 60571 | 32 | 12h:16m:33s |
| 66 | 2 | 60571 | 32 | 16h:02m:07s |
| 67 | 2 | 60571 | 32 | 13h:37m:22s |
| 68 | 2 | 60571 | 32 | 12h:54m:22s |
| 69 | 1 | 60571 | 32 | 6h:28m:01s |
| 70 | 2 | 60571 | 32 | 14h:03m:30s |
| 71 | 2 | 60571 | 32 | 13h:19m:34s |
| 72 | 2 | 60571 | 32 | 14h:16m:46s |
| 73 | 2 | 60571 | 32 | 13h:43m:34s |
| 74 | 2 | 60571 | 32 | 13h:40m:35s |
| 75 | 1 | 60571 | 32 | 7h:00m:31s |

* Will redo with the updated matOptimize which is proibably much faster
* Should do tree_rearrange with this experiment too

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
| 9 | 39621 | 10 |  |

### IQTREE 2

| Iteration | Total Sequences | Threads | CPU Time | Wall Clock Time |
|-----------|-----------------|---------|----------|-----------------|
| 1 | 4676 | 8 | 4h:21m:33s | 0h:39m:53s |
| 2 | 8902 | 8 | 14h:40m:39s | 2h:11m:34s |
| 3 | 13241 | 8 | 43h:24m:33s | 6h:7m:19s |
| 4 | 17941 | 8 | 19h:35m:53s | 2h:44m:7s |
| 5 | 22012 | 8 | 22h:44m:32s | 3h:28m:47s |
| 6 | 26486 | 8 | 34h:34m:15s | 4h:59m:54s |
| 7 | 30989 | 8 | 49h:4m:56s | 6h:59m:9s |
| 8 | 35323 | 8 | 58h:15m:0s | 9h:8m:31s |
| 9 | 39621 | 8 | 49h:18m:46s | 7h:42m:25s |
| 10 | 43808 | 8 | 59h:39m:18s | 9h:50m:25s |
| 11 | 47819 | 8 | 55h:27m:25s | 9h:16m:45s |
| 12 | 51899 | 8 | 63h:33m:58s | 10h:31m:45s |
| 13 | 56308 | 8 | 97h:32m:33s | 15h:33m:34s |
| 14 | 60571 | 8 | 229h:0m:30s | 33h:31m:48s |

* Note: Currently restarting with more threads at the most recent failure.


## Clean up
```
mkdir KEEP
mv *_samples.fasta KEEP/
tar cfJ batch.fastas.tar.xz KEEP/*
```

