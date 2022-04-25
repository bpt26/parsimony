for i in {1..200}; do
	if [[ $(( $i % 10 )) == 0 ]]; then
		echo $i
		./iqtree2-mpi -n 0 -no-ml -m JC -t resolve.nwk -s aln.fa -parsimony-spr 100 -parsimony-nni 100 -spr-radius $i --suppress-list-of-sequences -blfix -nt 15 -fast -pre spr$i
	fi
done
