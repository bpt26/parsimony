usher -v ../../input/CUMULATIVE_VCFS/1_with_ref.vcf -t trees/iteration_1/iter1.raxml.denovo.bestTree -o temp.pb -T 30 2> >(grep parsimony)
usher -v ../../input/CUMULATIVE_VCFS/2_with_ref.vcf -t trees/iteration_2/iter2.raxml.denovo.lastTree.STOPPED_AFTER_2_WEEKS -o temp.pb -T 30 2> >(grep parsimony)
usher -v ../../input/CUMULATIVE_VCFS/3_with_ref.vcf -t trees/iteration_3/iter3.raxml.denovo.lastTree.STOPPED_AFTER_2_WEEKS -o temp.pb -T 30 2> >(grep parsimony)
