# De novo inference with UShER + matOptimize
/usr/bin/time -o iter1.usher.denovo.time -f "%E %M" usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/1_with_ref.includeRef.vcf -o iter1.matOptimize.denovo.0.pb
/usr/bin/time -o iter1.matOptimize.denovo.time -f "%E %M" matOptimize -i iter1.matOptimize.denovo.0.pb -v ../../input/CUMULATIVE_VCFS/1_with_ref.includeRef.vcf -o iter1.matOptimize.denovo.opt.pb -T 14

# Extract the newick tree, resolving polytomies
matUtils extract -i iter1.matOptimize.denovo.opt.pb -R -t iter1.matOptimize.denovo.opt.resolved.nwk

i=2;
for i in {2..3}
  do
    h=$((i-1));
    /usr/bin/time -o "iter${i}.usher.denovo.time" -f "%E %M" usher -t empty.nwk -v "../../input/CUMULATIVE_VCFS/${i}_with_ref.includeRef.vcf" -o "iter${i}.matOptimize.denovo.0.pb" -T 14
    /usr/bin/time -o "iter${i}.matOptimize.denovo.time" -f "%E %M" matOptimize -i "iter${i}.matOptimize.denovo.0.pb" -v "../../input/CUMULATIVE_VCFS/${i}_with_ref.includeRef.vcf" -o "iter${i}.matOptimize.denovo.opt.pb" -T 14
    
    matUtils extract -i "iter${i}.matOptimize.denovo.opt.pb" -R -t "iter${i}.matOptimize.denovo.opt.resolved.nwk"

done;

# Convert branches to substitutions/site
python3 scaleBranchLengths.py iter1.matOptimize.denovo.opt.resolved.nwk
python3 scaleBranchLengths.py iter2.matOptimize.denovo.opt.resolved.nwk
python3 scaleBranchLengths.py iter3.matOptimize.denovo.opt.resolved.nwk