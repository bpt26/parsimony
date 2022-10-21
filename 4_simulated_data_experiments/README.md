# Simulated Data Comparisons

In this repository, we test each strategy on simulated data and then compute comparisons to the tree on which each simulation was based, pruned to include only the samples included in that iteration. Included are all scripts used to create trees, as well as the relevant results.

We first used phastSim to simulate an alignment based on the most optimized tree from subrepository 2, in which we ran 6 iterations of FastTree 2 and one iteration of matOptimize.

We then used the previous batches of samples to separate this alignment into batches, as was done in subrepository 3.

**Input**: 
- The "ground truth" phylogeny created in `2_make_starting_tree`, pruned for each iteration to contain only samples from that iteration (`input/GROUND_TRUTH_NEWICKS`).
- Results of the phastSim simulation over the ground truth phylogeny (`input/wholeGenomeSars-cov-2_simulation_output.fasta.xz, input/wholeGenomeSars-cov-2_simulation_output.vcf.xz`)


## Results
# Approaches with 24-hour runtime restrictions (4.1-4.6)
The experiments in 4.1 to 4.6 test both *de novo* and online approaches to tree inference on 50 batches of ~5,000 samples each. The *de novo* approaches infer trees from 50 iterations of increasing size (adding a batch to the list of input samples on each iteration). On each of the 50 iterations of the online approaches, a single batch is added to the existing tree inferred in the previous iteration. These experiments were restricted to a 24-hour runtime, and parameters for programs were chosen with this in mind. 

### 4.1: Online IQ-TREE 2

```
bash makeTrees.sh
bash condenseTrees.sh
Rscript getRFDist.R
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Robinson-Foulds Distance |    
|-----------|-----------------|---------|-----------------|----------|--------------------------|   
| 1 | 4676 | 15 | 0h:1m:25s | 807624 | 42 |    
| 2 | 8902 | 15 | 0h:5m:31s | 2307020 | 126 |    
| 3 | 13241 | 15 | 0h:7m:42s | 4479908 | 229 |    
| 4 | 17941 | 15 | 0h:24m:27s | 7147876 | 343 |    
| 5 | 22012 | 15 | 0h:40m:05s | 9925036 | 460 |    
| 6 | 26486 | 15 | 0h:50m:24s | 12998112 | 572 |    
| 7 | 30989 | 15 | 1h:13m:42s | 17281924 | 686 |    
| 8 | 35323 | 15 | 1h:17m:22s | 20473116 | 861 |    
| 9 | 39621 | 15 | 1h:54m:25s | 25016836 | 1003 |    
| 10 | 43808 | 15 | 2h:08m:38s | 29602628 | 1149 |    
| 11 | 47819 | 15 | 2h:30m:58s | 34483532 | 1251 |    
| 12 | 51899 | 15 | 6h:47m:16s | 40455820 | 1367 |    
| 13 | 56308 | 15 | 8h:04m:43s | 46217860 | 1504 |    
| 14 | 60571 | 15 | 11h:27m:08s | 51767784 | 1590 |    
| 15 | 64666 | 15 | 16h:34m:44s | 56703436 | 1684 |    
| 16 | 69052 | 15 | 13h:34m:53s | 61330824 | 1745 |    
| 17 | 73231 | 15 | 15h:54m:18s | 65960900 | 1801 |    
| 18 | 77399 | 15 | 19h:08m:57s | 70897532 | 1856 |    
| 19 | 81802 | 15 | |  |  |

#### 19th phylogeny took [...]   


### 4.2: *de novo* IQ-TREE 2

```
bash makeTrees.sh
bash condenseTrees.sh
Rscript getIQComp.R
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Robinson-Foulds Distance |    
|-----------|-----------------|---------|-----------------|----------|--------------------------|   
| 1 | 4676 | 15 | 0h:9m:08s | 1154388 |  |    
| 2 | 8902 | 15 | 0h:34m:46s | 3157492 | |    
| 3 | 13241 | 15 | 1h:19m:17s | 6435808 | |    
| 4 | 17941 | 15 | 2h:23m:45s | 9866524 | |    
| 5 | 22012 | 15 | 3h:47m:54s | 13061668 | |    
| 6 | 26486 | 15 | 5h:45m:00s | 17267220 | |    
| 7 | 30989 | 15 | 8h:15m:44s | 22419100 | |    
| 8 | 35323 | 15 | 11h:58m:34s | 26765792 | |    
| 9 | 39621 | 15 | 17h:23m:36s | 33030132 | |    

#### 10th phylogeny took 26h:12m:28s to complete.  

### 4.3: Online FastTree 2

```
bash makeTrees.sh
bash condenseTrees.sh
Rscript getDist.R
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Robinson-Foulds Distance |    
|-----------|-----------------|---------|-----------------|----------|--------------------------|   
| 1 | 4676 | 15 | 0h:40m:35s | 2538940 | 80 |  
| 2 | 8902 | 15 | 1h:46m:24s | 4669020 | 191 |  
| 3 | 13241 | 15 | 2h:53m:58s | 6715244 | 343 |  
| 4 | 17941 | 15 | 4h:04m:47s | 8977476 | 490 |  
| 5 | 22012 | 15 | 5h:29m:07s | 10889648 | 641 |  
| 6 | 26486 | 15 | 6h:39m:44s | 12978872 | 793 |  
| 7 | 30989 | 15 | 8h:44m:13s | 14894400 | 936 |  
| 8 | 35323 | 15 | 11h:08m:16s | 17027900 | 1132 |  
| 9 | 39621 | 15 | 12h:40m:24s | 19379716 | 1321 |  
| 10 | 43808 | 15 | 14h:28m:36s | 21564772 | 1538 |  
| 11 | 47819 | 15 | 16h:17m:04s | 23580132 | 1695 |  
| 12 | 51899 | 15 | 18h:44m:12s | 26107976 | 1842 |  
| 13 | 56308 | 15 | 21h:28m:33s | 28406328 | 1943 |  
| 14 | 60571 | 15 | 23h:29m:50s | 30602148 | 2111 |  

#### 15th phylogeny took 25h:06m:17s to complete.  

### 4.4: *de novo* FastTree 2

```
bash makeTrees.sh
bash condenseTrees.sh
Rscript getDist.R
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Robinson-Foulds Distance |    
|-----------|-----------------|---------|-----------------|----------|--------------------------|   
| 1 | 4676 | 15 | 0h:37m:05s | 2541516 | 93 |  
| 2 | 8902 | 15 | 1h:13m:56s | 4702300 | 241 |  
| 3 | 13241 | 15 | 1h:50m:38s | 6725140 | 430 |  
| 4 | 17941 | 15 | 2h:36m:10s | 8907712 | 623 |  
| 5 | 22012 | 15 | 3h:12m:05s | 10816304 | 832 |  
| 6 | 26486 | 15 | 3h:44m:36s | 12852192 | 1020 |  
| 7 | 30989 | 15 | 4h:26m:52s | 14858788 | 1258 |  
| 8 | 35323 | 15 | 5h:22m:49s | 17033948 | 1456 |  
| 9 | 39621 | 15 | 5h:55m:39s | 19357516 | 1678 |  
| 10 | 43808 | 15 | 6h:46m:44s | 21439508 | 1891 |  
| 11 | 47819 | 15 | 7h:16m:53s | 23438744 | 2127 |  
| 12 | 51899 | 15 | 8h:12m:56s | 25892668 | 2254 |  
| 13 | 56308 | 15 | 9h:10m:00s | 28238700 | 2415 |  
| 14 | 60571 | 15 | 9h:34m:04s | 30349916 | 2590 |  
| 15 | 64666 | 15 | 10h:32m:37s | 32181792 | 2680 |  
| 16 | 69052 | 15 | 11h:21m:31s | 33942220 | 2798 |  
| 17 | 73231 | 15 | 12h:00m:43s | 35664540 | 2874 |  
| 18 | 77399 | 15 | 14h:35m:27s | 37389736 | 2481 |  
| 19 | 81802 | 15 | 17h:50m:25s | 39430500 | 2421 |  
| 20 | 85946 | 15 | 17h:52m:25s | 41161368 | 2521 |  
| 21 | 90062 | 15 | 18h:13m:21s | 42916984 | 2504 |  
| 22 | 94384 | 15 | 18h:43m:45s | 44649896 | 2602 |  
| 23 | 98578 | 15 | 20h:10m:14s | 46467744 | 2655 |  
| 24 | 103052 | 15 | 21h:09m:29s | 48448988 | 2673 |  
| 25 | 107441 | 15 | 22h:25m:30s | 50411448 | 2822 |  

#### 26th phylogeny took 25h:46m:05s to complete.  

### 4.5: Online matOptimize  

```
bash makeTrees.sh
Rscript getDist.R
```

| Iteration | Total Sequences | Robinson-Foulds Distance |      
|-----------|-----------------|--------------------------|    
| 1 | 4676 | 44 |  
| 2 | 8902 | 120 |  
| 3 | 13241 | 219 |  
| 4 | 17941 | 340 |  
| 5 | 22012 | 444 |  
| 6 | 26486 | 570 |  
| 7 | 30989 | 692 |  
| 8 | 35323 | 843 |  
| 9 | 39621 | 981 |  
| 10 | 43808 | 1127 |  
| 11 | 47819 | 1237 |  
| 12 | 51899 | 1346 |  
| 13 | 56308 | 1471 |  
| 14 | 60571 | 1557 |  
| 15 | 64666 | 1657 |  
| 16 | 69052 | 1723 |  
| 17 | 73231 | 1789 |  
| 18 | 77399 | 1835 |  
| 19 | 81802 | 1871 |  
| 20 | 85946 | 1901 |  
| 21 | 90062 | 1936 |  
| 22 | 94384 | 1968 |  
| 23 | 98578 | 1992 |  
| 24 | 103052 | 2039 |  
| 25 | 107441 | 2083 |  
| 26 | 112716 | 2127 |  
| 27 | 116999 | 2176 |  
| 28 | 122802 | 2245 |  
| 29 | 128292 | 2307 |  
| 30 | 133990 | 2377 |  
| 31 | 138764 | 2456 |  
| 32 | 144037 | 2525 |  
| 33 | 149574 | 2611 |  
| 34 | 154358 | 2684 |  
| 35 | 158404 | 2716 |  
| 36 | 162559 | 2768 |  
| 37 | 166621 | 2814 |  
| 38 | 170826 | 2878 |  
| 39 | 176258 | 2951 |  
| 40 | 182077 | 3026 |  
| 41 | 187490 | 3076 |  
| 42 | 192049 | 3136 |  
| 43 | 196853 | 3191 |  
| 44 | 201995 | 3268 |  
| 45 | 207246 | 3359 |  
| 46 | 212424 | 3452 |  
| 47 | 217254 | 3552 |  
| 48 | 223132 | 3640 |  
| 49 | 227555 | 3722 |  
| 50 | 233326 | 3815 |  


### 4.6: *de novo* matOptimize  

```
bash makeTrees.sh  
Rscript getDist.R
```

| Iteration | Total Sequences | Robinson-Foulds Distance |      
|-----------|-----------------|--------------------------|    
| 1 | 4676 | 44 |  
| 2 | 8902 | 115 |  
| 3 | 13241 | 232 |  
| 4 | 17941 | 353 |  
| 5 | 22012 | 468 |  
| 6 | 26486 | 607 |  
| 7 | 30989 | 737 |  
| 8 | 35323 | 875 |  
| 9 | 39621 | 1034 |  
| 10 | 43808 | 1168 |  
| 11 | 47819 | 1288 |  
| 12 | 51899 | 1418 |  
| 13 | 56308 | 1565 |  
| 14 | 60571 | 1696 |  
| 15 | 64666 | 1809 |  
| 16 | 69052 | 1860 |  
| 17 | 73231 | 1907 |  
| 18 | 77399 | 1959 |  
| 19 | 81802 | 2021 |  
| 20 | 85946 | 2055 |  
| 21 | 90062 | 2078 |  
| 22 | 94384 | 2123 |  
| 23 | 98578 | 2135 |  
| 24 | 103052 | 2182 |  
| 25 | 107441 | 2234 |  
| 26 | 112716 | 2304 |  
| 27 | 116999 | 2372 |  
| 28 | 122802 | 2460 |  
| 29 | 128292 | 2569 |  
| 30 | 133990 | 2671 |  
| 31 | 138764 | 2735 |  
| 32 | 144037 | 2860 |  
| 33 | 149574 | 2934 |  
| 34 | 154358 | 3043 |  
| 35 | 158404 | 3034 |  
| 36 | 162559 | 3181 |  
| 37 | 166621 | 3250 |  
| 38 | 170826 | 3353 |  
| 39 | 176258 | 3459 |  
| 40 | 182077 | 3504 |  
| 41 | 187490 | 3549 |  
| 42 | 192049 | 3626 |  
| 43 | 196853 | 3722 |  
| 44 | 201995 | 3821 |  
| 45 | 207246 | 3923 |  
| 46 | 212424 | 4025 |  
| 47 | 217254 | 4120 |  
| 48 | 223132 | 4241 |  
| 49 | 227555 | 4303 |  
| 50 | 233326 | 4408 |  

# Approaches without 24-hour runtime restriction
The following experiments were performed on only the smallest datasets, with iterations of increasing size containing ~4.5k, ~8.9k, and ~13.2k samples. Experiments were allowed to run for up to two weeks. RAxML-NG iterations 2 and 3 did not terminate within this time, so the best tree inferrred so far was chosen for comparison in these cases. We compared *de novo* inference using RAxML-NG, IQ-TREE 2 with stochastic tree search, and matOptimize.

Robinson-Foulds and Quartet distances to the ground truth tree for each iteration are reported.

### 4.7: *de novo* IQ-TREE 2 (with stochastic search)  

```
bash makeTrees.sh  
bash condenseTrees.sh
Rscript getRFDist.R
```


| Iteration | Total Sequences | Robinson-Foulds Distance | Quartet Distance |     
|-----------|-----------------|--------------------------|------------------|    
| 1 | 4676 | 61 | 93783496108 |
| 2 | 8902 | 166 | 14640797480427 |
| 3 | 13241 | 388 | 94158901311645 |

### 4.8: *de novo* RAxML-NG  

```
bash makeTrees.sh  
bash condenseTrees.sh
Rscript getRFDist.R
```


| Iteration | Total Sequences | Robinson-Foulds Distance | Quartet Distance |     
|-----------|-----------------|--------------------------|------------------|    
| 1 | 4676 | 37 | 404336973082 |
| 2 | 8902 | 1212 | 30659616176809 |
| 3 | 13241 | 2889 | 682388159264029 |

 ### 4.9: *de novo* matOptimize
Files in `TREES` are from `4_simulated_data_experiments/4.6/TREES`. Results from the first
three iterations are copied below.
```
Rscript getRFDist.R
```

| Iteration | Total Sequences | Robinson-Foulds Distance | Quartet Distance |     
|-----------|-----------------|--------------------------|------------------|    
| 1 | 4676 | 44 | 25326792228 |
| 2 | 8902 | 115 | 277681159220 |
| 3 | 13241 | 232 | 2585471041580 |
