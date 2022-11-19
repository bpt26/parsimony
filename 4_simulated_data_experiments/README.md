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

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Robinson-Foulds Distance | Normalized RF Distance |    
|-----------|-----------------|---------|-----------------|----------|--------------------------|--------|   
| 1 | 4676 | 15 | 0h:1m:25s | 807624 | 42 | 0.03716814 |    
| 2 | 8902 | 15 | 0h:5m:31s | 2307020 | 126 | 0.05937795    
| 3 | 13241 | 15 | 0h:7m:42s | 4479908 | 229 | 0.07239962   
| 4 | 17941 | 15 | 0h:24m:27s | 7147876 | 343 | 0.07790143    
| 5 | 22012 | 15 | 0h:40m:05s | 9925036 | 460 | 0.084777   
| 6 | 26486 | 15 | 0h:50m:24s | 12998112 | 572 | 0.08635266   
| 7 | 30989 | 15 | 1h:13m:42s | 17281924 | 686 | 0.08808423   
| 8 | 35323 | 15 | 1h:17m:22s | 20473116 | 861 | 0.09591177   
| 9 | 39621 | 15 | 1h:54m:25s | 25016836 | 1003 | 0.09710524    
| 10 | 43808 | 15 | 2h:08m:38s | 29602628 | 1149 | 0.09899199   
| 11 | 47819 | 15 | 2h:30m:58s | 34483532 | 1251 | 0.09739198   
| 12 | 51899 | 15 | 6h:47m:16s | 40455820 | 1367 | 0.09624727   
| 13 | 56308 | 15 | 8h:04m:43s | 46217860 | 1504 | 0.09604087    
| 14 | 60571 | 15 | 11h:27m:08s | 51767784 | 1590 | 0.09323326   
| 15 | 64666 | 15 | 16h:34m:44s | 56703436 | 1684 | 0.09299757   
| 16 | 69052 | 15 | 13h:34m:53s | 61330824 | 1745 | 0.09121321    
| 17 | 73231 | 15 | 15h:54m:18s | 65960900 | 1801 | 0.0895708   
| 18 | 77399 | 15 | 19h:08m:57s | 70897532 | 1856 | 0.08719346   
| 19 | 81802 | 15 | 16h:58m:10s | 76680096 | 1907 | 0.08488005
| 20 | 85946 | 15 | 16h:07m:43s | 81922040 | 1934 | 0.08171371
| 21 | 90062 | 15 | 19h:54m:22s | 86873152 | 1957 | 0.07925965
| 22 | 94384 | 15 | 20h:24m:54s | 92143860 | 1996 | 0.07747846
| 23 | 98578 | 15 | 20h:35m:47s | 97471060 | 2019 | 0.07559816
| 24 | 103052 | 15 | 20h:38m:06s | 103136268 | 2063 | 0.07429683

#### 25th phylogeny took 25h:03m:35s to complete.


### 4.2: *de novo* IQ-TREE 2

```
bash makeTrees.sh
bash condenseTrees.sh
Rscript getIQComp.R
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Robinson-Foulds Distance | Normalized RF Distance  | 
|-----------|-----------------|---------|-----------------|----------|--------------------------|-----|   
| 1 | 4676 | 15 | 0h:9m:08s | 1154388 | 56 | 0.04938272   
| 2 | 8902 | 15 | 0h:34m:46s | 3157492 | 164 | 0.07656396   
| 3 | 13241 | 15 | 1h:19m:17s | 6435808 | 286 | 0.08411802   
| 4 | 17941 | 15 | 2h:23m:45s | 9866524 | 435 | 0.09742441   
| 5 | 22012 | 15 | 3h:47m:54s | 13061668 | 579 | 0.1052919   
| 6 | 26486 | 15 | 5h:45m:00s | 17267220 | 769 | 0.1139766    
| 7 | 30989 | 15 | 8h:15m:44s | 22419100 | 928 | 0.1171717   
| 8 | 35323 | 15 | 11h:58m:34s | 26765792 | 1161 | 0.1272887   
| 9 | 39621 | 15 | 17h:23m:36s | 33030132 | 1329 | 0.1267525

#### 10th phylogeny took 26h:12m:28s to complete.  

### 4.3: Online FastTree 2

```
bash makeTrees.sh
bash condenseTrees.sh
Rscript getDist.R
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Robinson-Foulds Distance | Normalized RF Distance |   
|-----------|-----------------|---------|-----------------|----------|--------------------------|----|  
| 1 | 4676 | 15 | 0h:40m:35s | 2538940 | 80 | 0.06932409 
| 2 | 8902 | 15 | 1h:46m:24s | 4669020 | 191 | 0.08830328 
| 3 | 13241 | 15 | 2h:53m:58s | 6715244 | 343 | 0.1059623  
| 4 | 17941 | 15 | 4h:04m:47s | 8977476 | 490 | 0.1085031 
| 5 | 22012 | 15 | 5h:29m:07s | 10889648 | 641 | 0.1153915 
| 6 | 26486 | 15 | 6h:39m:44s | 12978872 | 793 | 0.1166348 
| 7 | 30989 | 15 | 8h:44m:13s | 14894400 | 936 | 0.117  
| 8 | 35323 | 15 | 11h:08m:16s | 17027900 | 1132 | 0.1229099 
| 9 | 39621 | 15 | 12h:40m:24s | 19379716 | 1321 | 0.1245639 
| 10 | 43808 | 15 | 14h:28m:36s | 21564772 | 1538 | 0.1290268 
| 11 | 47819 | 15 | 16h:17m:04s | 23580132 | 1695 | 0.1284967  
| 12 | 51899 | 15 | 18h:44m:12s | 26107976 | 1842 | 0.1264936 
| 13 | 56308 | 15 | 21h:28m:33s | 28406328 | 1943 | 0.1213692 
| 14 | 60571 | 15 | 23h:29m:50s | 30602148 | 2111 | 0.1210089  

#### 15th phylogeny took 25h:06m:17s to complete.  

### 4.4: *de novo* FastTree 2

```
bash makeTrees.sh
bash condenseTrees.sh
Rscript getDist.R
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Robinson-Foulds Distance | Normalized RF Distance |    
|-----------|-----------------|---------|-----------------|----------|--------------------------|------|   
| 1 | 4676 | 15 | 0h:37m:05s | 2541516 | 93 | 0.0794193  
| 2 | 8902 | 15 | 1h:13m:56s | 4702300 | 241 | 0.1093963 
| 3 | 13241 | 15 | 1h:50m:38s | 6725140 | 430 | 0.1300665 
| 4 | 17941 | 15 | 2h:36m:10s | 8907712 | 623 | 0.1350531  
| 5 | 22012 | 15 | 3h:12m:05s | 10816304 | 832 | 0.1459137 
| 6 | 26486 | 15 | 3h:44m:36s | 12852192 | 1020 | 0.1464255 
| 7 | 30989 | 15 | 4h:26m:52s | 14858788 | 1258 | 0.1530041 
| 8 | 35323 | 15 | 5h:22m:49s | 17033948 | 1456 | 0.1544336  
| 9 | 39621 | 15 | 5h:55m:39s | 19357516 | 1678 | 0.1545974 
| 10 | 43808 | 15 | 6h:46m:44s | 21439508 | 1891 | 0.1552673 
| 11 | 47819 | 15 | 7h:16m:53s | 23438744 | 2127 | 0.1573108  
| 12 | 51899 | 15 | 8h:12m:56s | 25892668 | 2254 | 0.1514378  
| 13 | 56308 | 15 | 9h:10m:00s | 28238700 | 2415 | 0.1474809  
| 14 | 60571 | 15 | 9h:34m:04s | 30349916 | 2590 | 0.1454403  
| 15 | 64666 | 15 | 10h:32m:37s | 32181792 | 2680 | 0.1420997 
| 16 | 69052 | 15 | 11h:21m:31s | 33942220 | 2798 | 0.1402225 
| 17 | 73231 | 15 | 12h:00m:43s | 35664540 | 2874 | 0.1373542 
| 18 | 77399 | 15 | 14h:35m:27s | 37389736 | 2481 | 0.1140008 
| 19 | 81802 | 15 | 17h:50m:25s | 39430500 | 2421 | 0.1058916  
| 20 | 85946 | 15 | 17h:52m:25s | 41161368 | 2521 | 0.1044887 
| 21 | 90062 | 15 | 18h:13m:21s | 42916984 | 2504 | 0.09970534 
| 22 | 94384 | 15 | 18h:43m:45s | 44649896 | 2602 | 0.09914647 
| 23 | 98578 | 15 | 20h:10m:14s | 46467744 | 2655 | 0.09757084 
| 24 | 103052 | 15 | 21h:09m:29s | 48448988 | 2673 | 0.09461612  
| 25 | 107441 | 15 | 22h:25m:30s | 50411448 | 2822 | 0.09599292 

#### 26th phylogeny took 25h:46m:05s to complete.  

### 4.5: Online matOptimize  

```
bash makeTrees.sh
Rscript getDist.R
```

| Iteration | Total Sequences | Robinson-Foulds Distance | Normalized RF Distance |     
|-----------|-----------------|--------------------------|-----|    
| 1 | 4676 | 44 | 0.03900709  
| 2 | 8902 | 120 | 0.05671078  
| 3 | 13241 | 219 | 0.06936965  
| 4 | 17941 | 340 | 0.07727273 
| 5 | 22012 | 444 | 0.0818886
| 6 | 26486 | 570 | 0.08599879  
| 7 | 30989 | 692 | 0.0887407 
| 8 | 35323 | 843 | 0.09399041 
| 9 | 39621 | 981 | 0.09506735 
| 10 | 43808 | 1127 | 0.09716355 
| 11 | 47819 | 1237 | 0.09633206 
| 12 | 51899 | 1346 | 0.09477538  
| 13 | 56308 | 1471 | 0.0939756 
| 14 | 60571 | 1557 | 0.09134644 
| 15 | 64666 | 1657 | 0.09153179
| 16 | 69052 | 1723 | 0.09006325 
| 17 | 73231 | 1789 | 0.08894745 
| 18 | 77399 | 1835 | 0.08617856 
| 19 | 81802 | 1871 | 0.08326287
| 20 | 85946 | 1901 | 0.08028889  
| 21 | 90062 | 1936 | 0.07836788 
| 22 | 94384 | 1968 | 0.07635602 
| 23 | 98578 | 1992 | 0.0745509 
| 24 | 103052 | 2039 | 0.07340077 
| 25 | 107441 | 2083 | 0.07211355 
| 26 | 112716 | 2127 | 0.07018181 
| 27 | 116999 | 2176 | 0.0691584 
| 28 | 122802 | 2245 | 0.06781863 
| 29 | 128292 | 2307 | 0.06670522 
| 30 | 133990 | 2377 | 0.06582846 
| 31 | 138764 | 2456 | 0.06545493 
| 32 | 144037 | 2525 | 0.06459287 
| 33 | 149574 | 2611 | 0.0640689 
| 34 | 154358 | 2684 | 0.06364714 
| 35 | 158404 | 2716 | 0.06245401 
| 36 | 162559 | 2768 | 0.06168658 
| 37 | 166621 | 2814 | 0.06101474
| 38 | 170826 | 2878 | 0.06052576
| 39 | 176258 | 2951 | 0.05999309 
| 40 | 182077 | 3026 | 0.05939156 
| 41 | 187490 | 3076 | 0.05870453 
| 42 | 192049 | 3136 | 0.05848128  
| 43 | 196853 | 3191 | 0.05804457 
| 44 | 201995 | 3268 | 0.05746641 
| 45 | 207246 | 3359 | 0.05727293 
| 46 | 212424 | 3452 | 0.05723001 
| 47 | 217254 | 3552 | 0.05726815 
| 48 | 223132 | 3640 | 0.05670135 
| 49 | 227555 | 3722 | 0.05668768 
| 50 | 233326 | 3815 | 0.05642907 


### 4.6: *de novo* matOptimize  

```
bash makeTrees.sh  
Rscript getDist.R
```

| Iteration | Total Sequences | Robinson-Foulds Distance | Normalized RF Distance |     
|-----------|-----------------|--------------------------|----|   
| 1 | 4676 | 44 | 0.03900709  
| 2 | 8902 | 115 | 0.05432215  
| 3 | 13241 | 232 | 0.07318612 
| 4 | 17941 | 353 | 0.07977401 
| 5 | 22012 | 468 | 0.08590308 
| 6 | 26486 | 607 | 0.09101814 
| 7 | 30989 | 737 | 0.09392124 
| 8 | 35323 | 875 | 0.09708199 
| 9 | 39621 | 1034 | 0.09965305 
| 10 | 43808 | 1168 | 0.1000514 
| 11 | 47819 | 1288 | 0.09973672 
| 12 | 51899 | 1418 | 0.09921634 
| 13 | 56308 | 1565 | 0.09935877 
| 14 | 60571 | 1696 | 0.09886907 
| 15 | 64666 | 1809 | 0.09924837 
| 16 | 69052 | 1860 | 0.09662338 
| 17 | 73231 | 1907 | 0.09425196 
| 18 | 77399 | 1959 | 0.09147794 
| 19 | 81802 | 2021 | 0.08942082 
| 20 | 85946 | 2055 | 0.08630465 
| 21 | 90062 | 2078 | 0.08365539 
| 22 | 94384 | 2123 | 0.08189007 
| 23 | 98578 | 2135 | 0.07947735 
| 24 | 103052 | 2182 | 0.0781071 
| 25 | 107441 | 2234 | 0.07690189  
| 26 | 112716 | 2304 | 0.07558559 
| 27 | 116999 | 2372 | 0.07494944 
| 28 | 122802 | 2460 | 0.07387831 
| 29 | 128292 | 2569 | 0.07383669 
| 30 | 133990 | 2671 | 0.07351848 
| 31 | 138764 | 2735 | 0.07247145 
| 32 | 144037 | 2860 | 0.07269954 
| 33 | 149574 | 2934 | 0.07154353 
| 34 | 154358 | 3043 | 0.07170967  
| 35 | 158404 | 3034 | 0.06939298 
| 36 | 162559 | 3181 | 0.07041817 
| 37 | 166621 | 3250 | 0.07000086 
| 38 | 170826 | 3353 | 0.07001608 
| 39 | 176258 | 3459 | 0.06981532 
| 40 | 182077 | 3504 | 0.06829877 
| 41 | 187490 | 3549 | 0.067286 
| 42 | 192049 | 3626 | 0.06717303  
| 43 | 196853 | 3722 | 0.06724238 
| 44 | 201995 | 3821 | 0.06673187 
| 45 | 207246 | 3923 | 0.06643635 
| 46 | 212424 | 4025 | 0.06629771 
| 47 | 217254 | 4120 | 0.06600872
| 48 | 223132 | 4241 | 0.06565117 
| 49 | 227555 | 4303 | 0.06514663 
| 50 | 233326 | 4408 | 0.06482734

# Approaches without 24-hour runtime restriction
The following experiments were performed on only the smallest datasets, with iterations of increasing size containing ~4.5k, ~8.9k, and ~13.2k samples. Experiments were allowed to run for up to two weeks. RAxML-NG iterations 2 and 3 did not terminate within this time, so the best tree inferrred so far was chosen for comparison in these cases. We compared *de novo* inference using RAxML-NG, IQ-TREE 2 with stochastic tree search, and matOptimize.

Robinson-Foulds and Quartet distances to the ground truth tree for each iteration are reported.

### 4.7: *de novo* IQ-TREE 2 (with stochastic search)  

```
bash makeTrees.sh  
bash condenseTrees.sh
Rscript getRFDist.R
```


| Iteration | Total Sequences | Robinson-Foulds Distance | Normalized RF Distance | Quartet Distance |     
|-----------|-----------------|--------------------------|------------------|----|    
| 1 | 4676 | 61 | 0.05374449 | 93783496108 |
| 2 | 8902 | 166 | 0.07742537 | 14640797480427 |
| 3 | 13241 | 388 | 0.1184371 | 94158901311645 |

### 4.8: *de novo* RAxML-NG  

```
bash makeTrees.sh  
bash condenseTrees.sh
Rscript getRFDist.R
```


| Iteration | Total Sequences | Robinson-Foulds Distance | Normalized RF Distance | Quartet Distance |     
|-----------|-----------------|--------------------------|------------------|----|    
| 1 | 4676 | 37 | 0.03288889 | 404336973082 |
| 2 | 8902 | 1212 | 0.5804598 | 30659616176809 |
| 3 | 13241 | 2889 | 0.9014041 | 682388159264029 |

 ### 4.9: *de novo* matOptimize
Files in `TREES` are from `4_simulated_data_experiments/4.6/TREES`. Results from the first
three iterations are copied below.
```
Rscript getRFDist.R
```

| Iteration | Total Sequences | Robinson-Foulds Distance | Normalized RF Distance | Quartet Distance |     
|-----------|-----------------|--------------------------|------------------|-----|    
| 1 | 4676 | 44 | 0.03900709 | 25326792228 |
| 2 | 8902 | 115 | 0.05432215 | 277681159220 |
| 3 | 13241 | 232 | 0.07318612 | 2585471041580 |
