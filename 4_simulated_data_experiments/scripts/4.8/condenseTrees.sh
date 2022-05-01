    usher -v ../../input/CUMULATIVE_VCFS/1.vcf -t "TREES/iteration_1/iter1.raxml.denovo.bestTree" -c -o "TREES/iteration_1/iter1.raxml.denovo.pb"
    matUtils extract -i "TREES/iteration_1/iter1.raxml.denovo.pb" -O -o "TREES/iteration_1/iter1.raxml.denovo.COLLAPSED.pb" -T 15
    matUtils extract -i "TREES/iteration_1/iter1.raxml.denovo.COLLAPSED.pb" -t "TREES/iteration_1/iter1.raxml.denovo.COLLAPSED.nwk" -T 15


    usher -v ../../input/CUMULATIVE_VCFS/2.vcf -t "TREES/iteration_2/iter2.raxml.denovo.lastTree.STOPPED_AFTER_2_WEEKS" -c -o "TREES/iteration_2/iter2.raxml.denovo.pb"
    matUtils extract -i "TREES/iteration_2/iter2.raxml.denovo.pb" -O -o "TREES/iteration_2/iter2.raxml.denovo.COLLAPSED.pb" -T 15
    matUtils extract -i "TREES/iteration_2/iter2.raxml.denovo.COLLAPSED.pb" -t "TREES/iteration_2/iter2.raxml.denovo.COLLAPSED.nwk" -T 15


    usher -v ../../input/CUMULATIVE_VCFS/3.vcf -t "TREES/iteration_3/iter3.raxml.denovo.lastTree.STOPPED_AFTER_2_WEEKS" -c -o "TREES/iteration_3/iter3.raxml.denovo.pb"
    matUtils extract -i "TREES/iteration_3/iter3.raxml.denovo.pb" -O -o "TREES/iteration_3/iter3.raxml.denovo.COLLAPSED.pb" -T 15
    matUtils extract -i "TREES/iteration_3/iter3.raxml.denovo.COLLAPSED.pb" -t "TREES/iteration_3/iter3.raxml.denovo.COLLAPSED.nwk" -T 15
