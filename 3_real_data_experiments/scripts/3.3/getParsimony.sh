usher -v ../../input/CUMULATIVE_VCFS/1_with_ref.vcf -t 1_samples.ml.fasttree.gtrg.opt.nwk -o 1_samples.ml.fasttree.gtrg.opt.pb -T 30
usher -v ../../input/CUMULATIVE_VCFS/2_with_ref.vcf -t 2_samples.ml.fasttree.gtrg.opt.nwk -o 2_samples.ml.fasttree.gtrg.opt.pb -T 30
usher -v ../../input/CUMULATIVE_VCFS/3_with_ref.vcf -t 3_samples.ml.fasttree.gtrg.opt.nwk -o 3_samples.ml.fasttree.gtrg.opt.pb -T 30
usher -v ../../input/CUMULATIVE_VCFS/4_with_ref.vcf -t 4_samples.ml.fasttree.gtrg.opt.nwk -o 4_samples.ml.fasttree.gtrg.opt.pb -T 30
usher -v ../../input/CUMULATIVE_VCFS/5_with_ref.vcf -t 5_samples.ml.fasttree.gtrg.opt.nwk -o 5_samples.ml.fasttree.gtrg.opt.pb -T 30
usher -v ../../input/CUMULATIVE_VCFS/6_with_ref.vcf -t 6_samples.ml.fasttree.gtrg.opt.nwk -o 6_samples.ml.fasttree.gtrg.opt.pb -T 30
matUtils summary -i 1_samples.ml.fasttree.gtrg.opt.pb | grep Parsimony
matUtils summary -i 2_samples.ml.fasttree.gtrg.opt.pb | grep Parsimony
matUtils summary -i 3_samples.ml.fasttree.gtrg.opt.pb | grep Parsimony
matUtils summary -i 4_samples.ml.fasttree.gtrg.opt.pb | grep Parsimony
matUtils summary -i 5_samples.ml.fasttree.gtrg.opt.pb | grep Parsimony
matUtils summary -i 6_samples.ml.fasttree.gtrg.opt.pb | grep Parsimony
