for i in {1..3}
  do
    usher -v ../../input/CUMULATIVE_VCFS/${i}.vcf -t "TREES/iteration_${i}/iter${i}.iq.stoch.denovo.treefile" -c -o "TREES/iteration_${i}/iter${i}.iq.stoch.denovo.pb"
    matUtils extract -i "TREES/iteration_${i}/iter${i}.iq.stoch.denovo.pb" -O -o "TREES/iteration_${i}/iter${i}.iq.stoch.denovo.COLLAPSED.pb" -T 15
    matUtils extract -i "TREES/iteration_${i}/iter${i}.iq.stoch.denovo.COLLAPSED.pb" -t "TREES/iteration_${i}/iter${i}.iq.stoch.denovo.COLLAPSED.nwk" -T 15
done;
