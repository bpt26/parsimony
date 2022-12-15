for i in {1..3} ; do
    usher -v ../../CUMULATIVE_VCFS/$i.vcf -t TREES/iteration_${i}/iter${i}.iq.stoch.denovo.COLLAPSED.nwk -o temp.pb -T 15 2> >(grep parsimony)
done
