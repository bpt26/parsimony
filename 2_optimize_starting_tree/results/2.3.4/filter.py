import sys

names = []
with open('s.tsv') as f:
    f.readline()
    for line in f:
        name = line.strip().split()[0]
        names.append(name)
while True:
    line = sys.stdin.readline().strip()
    if not line:
        break
    if '>' in line:
        if line[1:] in names:
            print(line)
            print(sys.stdin.readline().strip())

