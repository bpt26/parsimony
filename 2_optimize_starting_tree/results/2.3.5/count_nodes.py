'''
Count the nodes in the global phylogeny
python3 count_nodes.py after_usher_optimized_fasttree_iter6.tree
'''
import sys
from ete3 import Tree


t = Tree(sys.argv[1])

ct = 0
for node in t.traverse('postorder'):
    if node.is_leaf():
        ct += 1

print(ct)
    
