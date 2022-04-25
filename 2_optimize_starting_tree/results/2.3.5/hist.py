import sys
import bte
from matplotlib import pyplot as plt    
import seaborn as sns

tree = bte.MATree("../../output/after_usher_optimized_fasttree_iter6.pb")


d = tree.depth_first_expansion()
num_edges = len(d) - 1
p = tree.get_parsimony_score()
h = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0}
for node in d:
    num_mut = len(node.mutations)
    if num_mut < 6:
        h[num_mut] += 1
    else:
        h[6] += 1
        

x = [0, 1, 2, 3, 4, 5, 6]
y = [h[0], h[1], h[2], h[3], h[4], h[5], h[6]]
y = [v / num_edges for v in y]
b = plt.bar(x=x, height=y)

plt.xlabel("# mutations along branch")
plt.ylabel("proportion of all branches")
plt.xticks(ticks=[0,1,2,3,4,5,6], labels=['0', '1', '2', '3', '4', '5', '>5'])
plt.yticks(ticks=[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0])
plt.savefig('hist.png')