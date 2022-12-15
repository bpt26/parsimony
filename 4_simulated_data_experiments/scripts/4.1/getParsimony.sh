for i in {1..24} ; do
    usher -v ../../CUMULATIVE_VCFS/$i.vcf -t ${i}_samples.ml.iqtree.opt.COLLAPSED.nwk -o temp.pb -T 15 2> >(grep parsimony)
done
