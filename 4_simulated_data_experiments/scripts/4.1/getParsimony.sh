for i in {1..51} ; do
    echo $i
    usher -v ../../input/CUMULATIVE_VCFS/$i.vcf -t TREES/${i}_samples.ml.iqtree.opt.COLLAPSED.nwk -o temp.pb -T 15 2> >(grep parsimony)
done
