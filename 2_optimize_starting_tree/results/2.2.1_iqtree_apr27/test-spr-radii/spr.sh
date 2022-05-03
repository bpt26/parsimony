# Create a downsampled tree with 5K samples
matUtils extract -i publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.pb.gz -W 5000 -o starttree.subsamples.5k.pb
# Resolve polytomies
matUtils extract -i starttree.subsamples.5k.pb -R -t resolve.nwk

# Perform parsimony optimization with varying SPR radii
for i in {1..200}; do
	if [[ $(( $i % 10 )) == 0 ]]; then
		echo $i
		./iqtree2-mpi -n 0 -no-ml -m JC -t resolve.nwk -s aln.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius $i --suppress-list-of-sequences -blfix -nt 15 -fast -pre spr$i
	fi
done