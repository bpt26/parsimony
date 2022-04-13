# This script converts the branches of a matOptimize tree
# into substitutions per site (from total substitutions)
from ete3 import Tree
import sys

f = sys.argv[1]
t = Tree(f, format=1)

for node in t.get_tree_root():
    node.dist = node.dist / 29903

t.write(outfile=sys.argv[1] + ".scaled", format=1)