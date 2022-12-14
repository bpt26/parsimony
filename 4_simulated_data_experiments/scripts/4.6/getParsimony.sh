for i in {1..51} ; do
    echo $i
    usher -v ../../CUMULATIVE_VCFS/$i.vcf -t TREES/$i.opt.COLLAPSED.nwk -o temp.pb -T 15 2> >(grep parsimony)
done
