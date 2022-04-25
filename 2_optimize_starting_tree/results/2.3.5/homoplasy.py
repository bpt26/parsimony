'''
Compute the number of sites that that display a mutation occurring on 
> 1 branches and > 10 branches
'''
import sys

sites = {}
sys.stdin.readline()
for line in sys.stdin:
    splt = line.strip().split()
    mut = splt[0]
    occ = int(splt[1])
    ref = mut[0]
    alt = mut[-1]
    pos = mut[1:-1]
    if pos in sites:
        sites[pos].append(occ)
    else:
        sites[pos] = [occ]

count_gt_1 = 0
for site in sites:
    for occ in sites[site]:
        if occ > 1:
            count_gt_1 += 1
            break

print(count_gt_1)

count_gt_10 = 0
for site in sites:
    for occ in sites[site]:
        if occ > 10:
            count_gt_10 += 1
            break

print(count_gt_10)
