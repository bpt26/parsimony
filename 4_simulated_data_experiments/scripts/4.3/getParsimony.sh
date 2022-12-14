for i in {1..15} ; do
    usher -v ../../CUMULATIVE_VCFS/$i.vcf -t TREES/${i}_samples.ml.fasttree.gtrg.opt.COLLAPSED.nwk -o temp.pb -T 15 2> >(grep parsimony)
done
