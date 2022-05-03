'''
Computes the number of unique (in FASTA sequence, ignoring gaps/ambiguities) samples in the global phylogeny
python3 count_unique.py < publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta
'''
import sys

d = {}
ct = 0
for line in sys.stdin:
    if '>' in line:
        continue
    d[line.strip().upper()] = True
    ct += 1

by_col = {}
for seq in d:
    for i, char in enumerate(seq):
        if char != 'A' and char != 'C' and char != 'G' and char != 'T':
            continue
        if i in by_col:
            by_col[i].append(char)
        else:
            by_col[i] = [char]

ct = 0
for col in by_col:
    if(len(set(by_col[col])) > 1):
        ct += 1

print(ct)
