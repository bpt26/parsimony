import sys


with open("qdist", "r") as q, open("quartet", "r") as tq:
    qd = {}
    tqd = {}
    while True:
        line = q.readline().strip()
        if not line: break
        num = int(line.split('-->')[1])
        q.readline().strip()
        vals = q.readline().strip().split()
        s = int(vals[3])
        d = int(vals[4])
        r_r = int(vals[1]) - (s+d)
        r_wc = int(vals[2]) - (s+d)
        qd[num] = (r_wc, r_r, s, d)
    while True:
        line = tq.readline().strip()
        if not line: break
        num = int(line.split('-->')[1])
        vals = tq.readline().strip().split()
        nq = int(vals[1]) * 2
        u = int(vals[6])
        tqd[num] = (nq, u)


for i in range(1, 10):
    (r_wc, r_r, s, d) = qd[i]
    (nq, u) = tqd[i]
    raw = (s + (1/3) * (r_r + r_wc + u)) / (nq/2)
    max_score = (s + d + r_r + (1/3)*(r_wc + u)) / (nq/2)
    print((raw - (1/3)) / (max_score - (1/3)))
