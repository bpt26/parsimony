curr=$(matUtils summary -i $1.0.pb -T 32 | grep "Parsimony" | awk '{print $4}');
prev=$((curr + 1));
i=0;
while [ $curr -lt $prev ]
do
  prev=$curr;
  j=$((i+1))
  /usr/bin/time -o $1.$i.matOptimize.time -f "%E %M" matOptimize -T 32 -i $1.$i.pb -o $1.$j.pb -s 259200
  curr=$(matUtils summary -i $1.$j.pb -T 32 | grep "Parsimony" | awk '{print $4}');
  i=$j
done;
mv $1.$j.pb $1.opt.pb 