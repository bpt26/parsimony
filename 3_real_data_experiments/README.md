# Real data experiments

This folder contains scripts and results used to test *de novo* and online approaches to tree inference with various programs.



# Setup

We first separate the samples from our starting tree (`1_make_starting_tree`) by the date that the sample was taken. We then organize these dates into batches, such that each batch contains roughly 5,000 samples. The goal here is to model the phylogenetic data accumulation that occurred over the course of the pandemic.

To prepare the input files, first, download metadata file that contains dates for each sample, sort the samples by date, and create VCFs and MSAs for each batch:
```
wget https://hgwdev.gi.ucsc.edu/~angie/UShER_SARS-CoV-2/2021/03/18/public-2021-03-18.metadata.tsv.gz
mv public-2021-03-18.metadata.tsv.gz input
python3 scripts/setup/getMetadata.py  
mkdir input/BATCH_SAMPLES/
python3 scripts/setup/getBatches.py  
mkdir input/BATCH_FASTAS/  
mkdir input/AGGREGATE_FASTAS/  
python3 scripts/setup/makeFastas.py  
bash scripts/setup/catBatches.sh  
mkdir input/CUMULATIVE_VCFS/  
bash scripts/setup/getVCFs.sh  
```

# Results

The below tables summarize the results of each experiment we performed.

# Approaches with 24-hour runtime restrictions (3.1-3.6)
The experiments in 3.1 to 3.6 test both *de novo* and online approaches to tree inference on 50 batches of ~5,000 samples each. The *de novo* approaches infer trees from 50 iterations of increasing size (adding a batch to the list of input samples on each iteration). On each of the 50 iterations of the online approaches, a single batch is added to the existing tree inferred in the previous iteration. These experiments were restricted to a 24-hour runtime, and parameters for programs were chosen with this in mind. 

**Notes on parameters for IQ-TREE 2 and FastTree 2**:

In experiments 3.1 and 3.2, IQ-TREE 2 was run with `-n 0` which indicates that no stochastic tree search should be performed. Stochastic search is costly in time, so for the 24-hour restricted runs we elected to omit it. For online IQ-TREE 2, a starting topology (the existing tree + new samples added by UShER) for each round is passed to IQ-TREE 2, from which it will perform NNI moves to maximize likelihood. For *de novo* IQ-TREE 2, a starting parsimony tree is chosen (by IQ-TREE) which is then optimized.

Similarly, FastTree 2 (experiments 3.3 and 3.4) was run with zero rounds of nearest-neighbor interchange (`-nni 0`) and two SPR rounds (`-spr 2 -sprlength 1000`) due to runtime considerations.

We also evaluated *de novo* methods using their full capabilities in experimnents 3.7 and 3.8, eliminating the 24-hour restriction on runtime.


## 3.1: Online IQ-TREE 2
```
cd scripts/3.1
bash makeTrees.sh  
bash getLikelihoods.sh  
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk |  
|-----------|-----------------|---------|-----------------|----------|-----------|-------|  
| 1 | 4676 | 15 | 0h:6m:03s | 5614208 | 3035 | -76832.294 |
| 2 | 8902 | 15 | 0h:20m:45s | 15318600 | 5548 | -106938.729 |
| 3 | 13241 | 15 | 0h:39m:26s | 28480068 | 8086 | -137306.286 |
| 4 | 17941 | 15 | 1h:36m:06s | 42748200 | 10923 | -171206.771 |
| 5 | 22012 | 15 | 1h:50m:40s | 56677064 | 13393 | -200665.566 |
| 6 | 26486 | 15 | 3h:29m:28s | 72230988 | 16195 | -234130.859  |
| 7 | 30989 | 15 | 6h:51m:07s | 87787036 | 19041 | -267980.002 |
| 8 | 35323 | 15 | 7h:01m:55s | 103261908 | 22107 | -304478.743 |
| 9 | 39621 | 15 | 13h:21m:24s | 120020092 | 25585 | -345499.874 |
| 10 | 43808 | 15 | 16h:30m:50s | 136299984 | 28864 | -384210.771 |
| 11 | 47819 | 15 | 21h:14m:44s | 152072076 | 32060 | -421677.146 |

#### 12th phylogeny required 24h:29m:48s to complete. 

## 3.2: *de novo* IQ-TREE 2

```
cd scripts/3.2
bash makeTrees.sh  
bash getParsimony.sh  
bash getLikelihoods.sh    
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk |  
|-----------|-----------------|---------|-----------------|----------|-----------|-------|
| 1 | 4676 | 15 | 0h:28m:57s | 6916096 | 3022 | -76693.571 |  
| 2 | 8902 | 15 | 1h:55m:26s | 18575472 | 5524 | -106704.839 |  
| 3 | 13241 | 15 | 4h:44m:23s | 33758528 | 8062 | -137083.559 |  
| 4 | 17941 | 15 | 9h:37m:33s | 51548112 | 10905 | -171090.515 |  
| 5 | 22012 | 15 | 13h:53m:50s | 67422184 | 13387 | -200737.415 |  

#### 6th phylogeny required 25h:29m:15s to complete.  

## 3.3: Online FastTree2  

```
cd scripts/3.3
bash makeTrees.sh  
bash getParsimony.sh  
bash getLikelihoods.sh    
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk |  
|-----------|-----------------|---------|-----------------|----------|-----------|-------|
| 1 | 4676 | 15 | 1h:20m:41s | 5172368 | 3022 | -76697.194 |  
| 2 | 8902 | 15 | 3h:48m:01s | 9684048 | 5546 | -106914.685 |  
| 3 | 13241 | 15 | 7h:27m:36s | 14797776 | 8111 | -137578.065 |  
| 4 | 17941 | 15 | 12h:44m:46s | 20388776 | 10969 | -171710.289 |  
| 5 | 22012 | 15 | 18h:16m:01s | 25124716 | 13462 | -201423.321 |  
| 6 | 26486 | 15 | 23h:50m:08s | 30258796 | 16290 | -235177.396 |  

#### 7th phylogeny required 29h:08m:42s to complete.   

## 3.4: *de novo* FastTree2

```
cd scripts/3.4
bash makeTrees.sh  
bash getParsimony.sh  
bash getLikelihoods.sh    
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk |  
|-----------|-----------------|---------|-----------------|----------|-----------|-------|  
| 1 | 4676 | 15 | 1h:24m:44s | 5177660 | 3022 | -76720.160 |  
| 2 | 8902 | 15 | 2h:40m:06s | 9662804 | 5530 | -106750.638 |  
| 3 | 13241 | 15 | 4h:29m:58s | 14710344 | 8076 | -137199.783 |  
| 4 | 17941 | 15 | 6h:31m:03s | 20209160 | 10917 | -171159.976 |  
| 5 | 22012 | 15 | 8h:06m:11s | 24933880 | 13410 | -200846.113 |  
| 6 | 26486 | 15 | 9h:56m:32s | 30010824 | 16222 | -234408.096 |  
| 7 | 30989 | 15 | 11h:42m:19s | 35066004 | 19073 | -268303.551 |  
| 8 | 35323 | 15 | 13h:42m:33s | 40165740 | 22143 | -304852.007 |  
| 9 | 39621 | 15 | 15h:42m:41s | 45235280 | 25630 | -345975.913 |  
| 10 | 43808 | 15 | 17h:46m:56s | 50092604 | 28906 | -384665.970 |  
| 11 | 47819 | 15 | 18h:58m:35s | 54813852 | 32103 | -422116.453 |  
| 12 | 51899 | 15 | 21h:41m:57s | 59518580 | 36416 | -471962.130 |  

#### 13th phylogeny required 28h:22m:06s to complete.     

## 3.5: Online matOptimize

```
cd scripts/3.5
bash makeTrees.sh  
bash getLikelihoods.sh    
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk |  
|-----------|-----------------|---------|-----------------|----------|-----------|-------|  
| 1 | 4676 | 15 | 0h:0m:02s | 50764 | 3018 | -76642.465 |  
| 2 | 8902 | 15 | 0h:0m:01s | 70600 | 5518 | -106604.965 |  
| 3 | 13241 | 15 | 0h:0m:02s | 96260 | 8050 | -136901.680 |  
| 4 | 17941 | 15 | 0h:0m:02s | 135440 | 10879 | -170712.546 |  
| 5 | 22012 | 15 | 0h:0m:02s | 146704 | 13347 | -200155.962 |  
| 6 | 26486 | 15 | 0h:0m:06s | 147812 | 16130 | -233414.277 |  
| 7 | 30989 | 15 | 0h:0m:07s | 185820 | 18953 | -267023.909 |  
| 8 | 35323 | 15 | 0h:0m:06s | 193468 | 21999 | -303299.168 |  
| 9 | 39621 | 15 | 0h:0m:07s | 266976 | 25467 | -344201.567 |  
| 10 | 43808 | 15 | 0h:0m:07s | 256912 | 28728 | -382739.303 |  
| 11 | 47819 | 15 | 0h:0m:09s | 282704 | 31908 | -420037.406 |  
| 12 | 51899 | 15 | 0h:0m:18s | 314832 | 36187 | -469547.974 |  
| 13 | 56308 | 15 | 0h:0m:10s | 337916 | 39988 | -513861.017 |  
| 14 | 60571 | 15 | 0h:0m:10s | 360816 | 43563 | -555477.182 |  
| 15 | 64666 | 15 | 0h:0m:12s | 381572 | 46707 | -591966.025 |  
| 16 | 69052 | 15 | 0h:0m:11s | 411856 | 49643 | -625977.169 |  
| 17 | 73231 | 15 | 0h:0m:12s | 416132 | 52394 | -658031.141 |  
| 18 | 77399 | 15 | 0h:0m:12s | 433868 | 55165 | -690398.871 |  
| 19 | 81802 | 15 | 0h:0m:13s | 464740 | 58533 | -729415.730 |  
| 20 | 85946 | 15 | 0h:0m:13s | 502760 | 61491 | -763858.601 |  
| 21 | 90062 | 15 | 0h:0m:14s | 514568 | 64081 | -794075.560 |  
| 22 | 94384 | 15 | 0h:0m:15s | 535300 | 66770 | -825532.478 |  
| 23 | 98578 | 15 | 0h:0m:15s | 541244 | 69257 | -854984.403 |  
| 24 | 103052 | 15 | 0h:0m:16s | 560416 | 72044 | -887852.579 |  
| 25 | 107441 | 15 | 0h:0m:15s | 587556 | 74921 | -921752.635 |  
| 26 | 112716 | 15 | 0h:0m:17s | 635492 | 78154 | -960006.912 |  
| 27 | 116999 | 15 | 0h:0m:16s | 633656 | 81258 | -996374.517 |  
| 28 | 122802 | 15 | 0h:0m:17s | 663708 | 85273 | -1043678.812 |  
| 29 | 128292 | 15 | 0h:0m:17s | 686668 | 88835 | -1085805.209 |  
| 30 | 133990 | 15 | 0h:0m:18s | 700704 | 92983 | -1134693.830 |  
| 31 | 138764 | 15 | 0h:0m:18s | 735256 | 96683 | -1178169.689 |  
| 32 | 144037 | 15 | 0h:0m:19s | 770488 | 100782 | -1226074.325 |  
| 33 | 149574 | 15 | 0h:0m:20s | 810148 | 105099 | -1276850.423 |  
| 34 | 154358 | 15 | 0h:0m:21s | 842232 | 108700 | -1319203.060 |  
| 35 | 158404 | 15 | 0h:0m:21s | 896812 | 112329 | -1361506.588 |  
| 36 | 162559 | 15 | 0h:0m:31s | 907896 | 115488 | -1398723.287 |  
| 37 | 166621 | 15 | 0h:0m:22s | 939908 | 119020 | -1439625.760 |  
| 38 | 170826 | 15 | 0h:1m:36s | 915484 | 122953 | -1485120.760 |  
| 39 | 176258 | 15 | 0h:0m:24s | 982540 | 127179 | -1534469.110 |  
| 40 | 182077 | 15 | 0h:0m:24s | 1038376 | 131279 | -1582740.420 |  
| 41 | 187490 | 15 | 0h:0m:25s | 1071932 | 134837 | -1624608.088 |  
| 42 | 192049 | 15 | 0h:0m:26s | 1103708 | 137995 | -1661767.963 |  
| 43 | 196853 | 15 | 0h:1m:26s | 1076460 | 141873 | -1706870.337 |  
| 44 | 201995 | 15 | 0h:0m:27s | 1169336 | 148114 | -1778556.729 |  
| 45 | 207246 | 15 | 0h:0m:27s | 1207444 | 152925 | -1834709.083 |  
| 46 | 212424 | 15 | 0h:0m:28s | 1230004 | 158330 | -1897583.265 |  
| 47 | 217254 | 15 | 0h:0m:29s | 1282764 | 163671 | -1959449.590 |  
| 48 | 223132 | 15 | 0h:1m:36s | 1284016 | 170082 | -2033943.378 |  
| 49 | 227555 | 15 | 0h:0m:30s | 1358084 | 174729 | -2087730.079 |  
| 50 | 233326 | 15 | 0h:0m:32s | 1414540 | 180265 | -2152422.824 |  

## 3.6: *de novo* UShER+matOptimize

```
cd scripts/3.6
bash makeTrees.sh  
bash getLikelihoods.sh    
```

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk (JC) |  
|-----------|-----------------|---------|-----------------|----------|-----------|-------|  
| 1 | 4676 | 15 | 0h:0m:8s | 51780 | 3018 |  |  
| 2 | 8902 | 15 | 0h:0m:30s | 74160 | 5518 |  |  
| 3 | 13241 | 15 | 0h:1m:23s | 104032 | 8049 |  |  
| 4 | 17941 | 15 | 0h:2m:57s | 133172 | 10880 |  |  
| 5 | 22012 | 15 | 0h:4m:58s | 162736 | 13346 |  |  
| 6 | 26486 | 15 | 0h:7m:29s | 162600 | 16129 | -233397.444 |  
| 7 | 30989 | 15 | 0h:11m:3s | 196204 | 18953 | -267015.995 |  
| 8 | 35323 | 15 | 0h:23m:5s | 212592 | 21998 | -303280.512 |  
| 9 | 39621 | 15 | 0h:29m:57s | 241588 | 25463 | -344147.161 |  
| 10 | 43808 | 15 | 0h:36m:4s | 264020 | 28722 | -382664.230 |  
| 11 | 47819 | 15 | 0h:42m:57s | 300528 | 31903 | -419980.479 |  
| 12 | 51899 | 15 | 0h:49m:15s | 309856 | 36187 | -469547.660 |  
| 13 | 56308 | 15 | 0h:56m:16s | 344536 | 39961 | -513585.334 |  
| 14 | 60571 | 15 | 1h:11m:58s | 356364 | 43529 | -555127.622 |  
| 15 | 64666 | 15 | 1h:17m:32s | 371568 | 46673 | -591627.071 |  
| 16 | 69052 | 15 | 1h:30m:33s | 420204 | 49608 | -625627.361 |  
| 17 | 73231 | 15 | 1h:34m:59s | 429444 | 52356 | -657645.142 |  
| 18 | 77399 | 15 | 1h:15m:51s | 464596 | 55128 | -690030.451 |  
| 19 | 81802 | 15 | 1h:32m:18s | 501360 | 58496 | -729031.096 |  
| 20 | 85946 | 15 | 1h:41m:10s | 513748 | 61453 | -763476.169 |  
| 21 | 90062 | 15 | 1h:42m:21s | 518164 | 64048 | -793735.691 |  
| 22 | 94384 | 15 | 1h:48m:31s | 517900 | 66729 | -825120.421 |  
| 23 | 98578 | 15 | 2h:0m:38s | 554772 | 69216 | -854563.480 |  
| 24 | 103052 | 15 | 2h:12m:54s | 582136 | 72003 | -887439.842 |  
| 25 | 107441 | 15 | 2h:27m:22s | 591476 | 74883 | -921375.548 |  
| 26 | 112716 | 15 | 2h:44m:35s | 659672 | 78114 | -959594.733 |  
| 27 | 116999 | 15 | 3h:0m:12s | 631284 | 81220 | -996009.062 |  
| 28 | 122802 | 15 | 3h:20m:49s | 685656 | 85230 | -1043277.304 |  
| 29 | 128292 | 15 | 3h:43m:23s | 674476 | 88788 | -1085340.721 |  
| 30 | 133990 | 15 | 4h:11m:17s | 723516 | 92933 | -1134191.599 |  
| 31 | 138764 | 15 | 4h:25m:22s | 742496 | 96633 | -1177675.154 |  
| 32 | 144037 | 15 | 4h:53m:38s | 790260 | 100732 | -1225594.155 |  
| 33 | 149574 | 15 | 5h:28m:23s | 814748 | 105049 | -1276357.680 |  
| 34 | 154358 | 15 | 5h:56m:48s | 865920 | 108649 | -1318705.010 |  
| 35 | 158404 | 15 | 6h:23m:52s | 846160 | 112274 | -1360960.202 |  
| 36 | 162559 | 15 | 6h:43m:21s | 909492 | 115434 | -1398170.426 |  
| 37 | 166621 | 15 | 7h:13m:17s | 962480 | 118967 | -1439090.839 |  
| 38 | 170826 | 15 | 7h:37m:38s | 967924 | 122894 | -1484539.802 |  
| 39 | 176258 | 15 | 8h:15m:37s | 996416 | 127119 | -1533871.115 |  
| 40 | 182077 | 15 | 8h:56m:14s | 1036268 | 131218 | -1582127.725 |  
| 41 | 187490 | 15 | 10h:3m:39s | 1078252 | 134773 | -1623971.846 |  
| 42 | 192049 | 15 | 10h:5m:54s | 1077868 | 137930 | -1661143.658 |  
| 43 | 196853 | 15 | 10h:39m:7s | 1101264 | 141809 | -1706226.545 |  
| 44 | 201995 | 15 | 11h:29m:34s | 1167844 | 148046 | -1777880.851 |  
| 45 | 207246 | 15 | 12h:17m:48s | 1191056 | 152855 | -1834027.875 |  
| 46 | 212424 | 15 | 14h:20m:28s | 1242528 | 158255 | -1896854.156 |  
| 47 | 217254 | 15 | 13h:32m:42s | 1279624 | 163591 | -1958672.569 |  
| 48 | 223132 | 15 | 14h:21m:58s | 1312700 | 169999 | -2033130.142 |  
| 49 | 227555 | 15 | 14h:52m:55s | 1339592 | 174640 | -2086849.998 |  
| 50 | 233326 | 15 | 16h:24m:19s | 1430116 | 180168 | -2151471.509 |  

# Approaches without 24-hour runtime restriction
The following experiments were performed on only the smallest datasets, with iterations of increasing size containing ~4.5k, ~8.9k, and ~13.2k samples. Experiments were allowed to run for up to two weeks. RAxML-NG iterations 2 and 3 did not terminate within this time, so the best tree inferrred so far was chosen for comparison in these cases. We compared *de novo* inference using RAxML-NG, IQ-TREE 2 with stochastic tree search, and matOptimize.

IQ-TREE 2 finished all iterations, so we used the model and parameters estimated by IQ-TREE 2 in each iteration to compute log likelihoods for all three inference methods. We also computed log likelihoods under the model chosen by RAxML-NG for the first iteration, but could not do so for the second and third because they did not terminate within two weeks (and so did not report model parameters).

## 3.7: *de novo* IQ-TREE 2 (with stochastic search)

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk (under IQ-TREE model) | LogLk (under RAxML-NG model) |
|-----------|-----------------|---------|-----------------|----------|-----------|-------|-------|
| 1 | 4677 | 14 | 9h:36m:52s | 6905184 | 3015 | -73828.271 | -73801.935 |
| 2 | 8903 | 14 | 43h:23m:55s | 18661208 | 5514 | -101460.659 | -- |
| 3 | 13242 | 14 | 118h:30m:01s | 34853980 | 8055| -129153.960 |--  |

## 3.8: *de novo* RAxML-NG
To choose the number of threads for this experiment, we specified `--threads auto{15}`, letting RAxML-NG choose a good number of threads/workers for each run. The first iteration chose `2 workers x 7 threads`, so we used 14 threads as a comparable option for the IQ-TREE 2 and matOptimize runs in experiment 3.7 and 3.9. Iterations 2 and 3 were terminated after 14 days, and the reported values are for the best tree inferred up to that point.

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk (under IQ-TREE model) | LogLk (under RAxML-NG model) |
|-----------|-----------------|---------|-----------------|----------|-----------|-------|-------|
| 1 | 4677 | 2 workers x 7 threads | 226h:42m:58s | 7248184 | 3012| -73782.289 | -73756.246 |
| 2 | 8903 | 2 workers x 7 threads | >14 days| -- |7749 | -121827.457 | -- |
| 3 | 13242 |1 worker x 15 threads | >14 days | -- |13902 | -181677.923 | -- |

## 3.9 *de novo* UShER + matOptimize

| Iteration | Total Sequences | Threads | Wall Clock Time | RAM (kB) | Parsimony | LogLk (under IQ-TREE model) | LogLk (under RAxML-NG model) |
|-----------|-----------------|---------|-----------------|----------|-----------|-------|-------|
| 1 | 4677 |  14 | 0h:0m:35s | 44292 |  3016 | -73780.756 | -73754.894 |
| 2 | 8903 |  14 | 0h:2m:19s | 62164 |  5519 | -101394.239 | -- |
| 3 | 13242 | 14 | 0h:5m:40s | 91040 |  8049 | -128935.044 | -- |

