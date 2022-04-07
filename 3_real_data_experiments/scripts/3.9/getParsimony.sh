usher -v ../../input/CUMULATIVE_VCFS/1_with_ref.vcf -t trees/iteration_1/iter1.matOptimize.denovo.opt.resolved.nwk -o temp.pb -T 30 2> >(grep parsimony)
usher -v ../../input/CUMULATIVE_VCFS/2_with_ref.vcf -t trees/iteration_2/iter2.matOptimize.denovo.opt.resolved.nwk -o temp.pb -T 30 2> >(grep parsimony)
usher -v ../../input/CUMULATIVE_VCFS/3_with_ref.vcf -t trees/iteration_3/iter3.matOptimize.denovo.opt.resolved.nwk -o temp.pb -T 30 2> >(grep parsimony)
