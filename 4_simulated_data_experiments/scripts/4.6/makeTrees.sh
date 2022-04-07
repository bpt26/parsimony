# de novo matOptimize
usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/1.vcf -o 1.pb
/usr/bin/time -o 1.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/1.vcf -i 1.pb -o 1.opt.pb -T 5
matUtils extract -i 1.opt.pb -t 1.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/2.vcf -o 2.pb
/usr/bin/time -o 2.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/2.vcf -i 2.pb -o 2.opt.pb -T 5
matUtils extract -i 2.opt.pb -t 2.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/3.vcf -o 3.pb
/usr/bin/time -o 3.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/3.vcf -i 3.pb -o 3.opt.pb -T 5
matUtils extract -i 3.opt.pb -t 3.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/4.vcf -o 4.pb
/usr/bin/time -o 4.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/4.vcf -i 4.pb -o 4.opt.pb -T 5
matUtils extract -i 4.opt.pb -t 4.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/5.vcf -o 5.pb
/usr/bin/time -o 5.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/5.vcf -i 5.pb -o 5.opt.pb -T 5
matUtils extract -i 5.opt.pb -t 5.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/6.vcf -o 6.pb
/usr/bin/time -o 6.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/6.vcf -i 6.pb -o 6.opt.pb -T 5
matUtils extract -i 6.opt.pb -t 6.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/7.vcf -o 7.pb
/usr/bin/time -o 7.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/7.vcf -i 7.pb -o 7.opt.pb -T 5
matUtils extract -i 7.opt.pb -t 7.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/8.vcf -o 8.pb
/usr/bin/time -o 8.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/8.vcf -i 8.pb -o 8.opt.pb -T 5
matUtils extract -i 8.opt.pb -t 8.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/9.vcf -o 9.pb
/usr/bin/time -o 9.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/9.vcf -i 9.pb -o 9.opt.pb -T 5
matUtils extract -i 9.opt.pb -t 9.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/10.vcf -o 10.pb
/usr/bin/time -o 10.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/10.vcf -i 10.pb -o 10.opt.pb -T 5
matUtils extract -i 10.opt.pb -t 10.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/11.vcf -o 11.pb
/usr/bin/time -o 11.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/11.vcf -i 11.pb -o 11.opt.pb -T 5
matUtils extract -i 11.opt.pb -t 11.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/12.vcf -o 12.pb
/usr/bin/time -o 12.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/12.vcf -i 12.pb -o 12.opt.pb -T 5
matUtils extract -i 12.opt.pb -t 12.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/13.vcf -o 13.pb
/usr/bin/time -o 13.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/13.vcf -i 13.pb -o 13.opt.pb -T 5
matUtils extract -i 13.opt.pb -t 13.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/14.vcf -o 14.pb
/usr/bin/time -o 14.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/14.vcf -i 14.pb -o 14.opt.pb -T 5
matUtils extract -i 14.opt.pb -t 14.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/15.vcf -o 15.pb
/usr/bin/time -o 15.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/15.vcf -i 15.pb -o 15.opt.pb -T 5
matUtils extract -i 15.opt.pb -t 15.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/16.vcf -o 16.pb
/usr/bin/time -o 16.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/16.vcf -i 16.pb -o 16.opt.pb -T 5
matUtils extract -i 16.opt.pb -t 16.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/17.vcf -o 17.pb
/usr/bin/time -o 17.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/17.vcf -i 17.pb -o 17.opt.pb -T 5
matUtils extract -i 17.opt.pb -t 17.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/18.vcf -o 18.pb
/usr/bin/time -o 18.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/18.vcf -i 18.pb -o 18.opt.pb -T 5
matUtils extract -i 18.opt.pb -t 18.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/19.vcf -o 19.pb
/usr/bin/time -o 19.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/19.vcf -i 19.pb -o 19.opt.pb -T 5
matUtils extract -i 19.opt.pb -t 19.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/20.vcf -o 20.pb
/usr/bin/time -o 20.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/20.vcf -i 20.pb -o 20.opt.pb -T 5
matUtils extract -i 20.opt.pb -t 20.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/21.vcf -o 21.pb
/usr/bin/time -o 21.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/21.vcf -i 21.pb -o 21.opt.pb -T 5
matUtils extract -i 21.opt.pb -t 21.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/22.vcf -o 22.pb
/usr/bin/time -o 22.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/22.vcf -i 22.pb -o 22.opt.pb -T 5
matUtils extract -i 22.opt.pb -t 22.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/23.vcf -o 23.pb
/usr/bin/time -o 23.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/23.vcf -i 23.pb -o 23.opt.pb -T 5
matUtils extract -i 23.opt.pb -t 23.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/24.vcf -o 24.pb
/usr/bin/time -o 24.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/24.vcf -i 24.pb -o 24.opt.pb -T 5
matUtils extract -i 24.opt.pb -t 24.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/25.vcf -o 25.pb
/usr/bin/time -o 25.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/25.vcf -i 25.pb -o 25.opt.pb -T 5
matUtils extract -i 25.opt.pb -t 25.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/26.vcf -o 26.pb
/usr/bin/time -o 26.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/26.vcf -i 26.pb -o 26.opt.pb -T 5
matUtils extract -i 26.opt.pb -t 26.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/27.vcf -o 27.pb
/usr/bin/time -o 27.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/27.vcf -i 27.pb -o 27.opt.pb -T 5
matUtils extract -i 27.opt.pb -t 27.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/28.vcf -o 28.pb
/usr/bin/time -o 28.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/28.vcf -i 28.pb -o 28.opt.pb -T 5
matUtils extract -i 28.opt.pb -t 28.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/29.vcf -o 29.pb
/usr/bin/time -o 29.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/29.vcf -i 29.pb -o 29.opt.pb -T 5
matUtils extract -i 29.opt.pb -t 29.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/30.vcf -o 30.pb
/usr/bin/time -o 30.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/30.vcf -i 30.pb -o 30.opt.pb -T 5
matUtils extract -i 30.opt.pb -t 30.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/31.vcf -o 31.pb
/usr/bin/time -o 31.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/31.vcf -i 31.pb -o 31.opt.pb -T 5
matUtils extract -i 31.opt.pb -t 31.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/32.vcf -o 32.pb
/usr/bin/time -o 32.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/32.vcf -i 32.pb -o 32.opt.pb -T 5
matUtils extract -i 32.opt.pb -t 32.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/33.vcf -o 33.pb
/usr/bin/time -o 33.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/33.vcf -i 33.pb -o 33.opt.pb -T 5
matUtils extract -i 33.opt.pb -t 33.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/34.vcf -o 34.pb
/usr/bin/time -o 34.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/34.vcf -i 34.pb -o 34.opt.pb -T 5
matUtils extract -i 34.opt.pb -t 34.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/35.vcf -o 35.pb
/usr/bin/time -o 35.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/35.vcf -i 35.pb -o 35.opt.pb -T 5
matUtils extract -i 35.opt.pb -t 35.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/36.vcf -o 36.pb
/usr/bin/time -o 36.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/36.vcf -i 36.pb -o 36.opt.pb -T 5
matUtils extract -i 36.opt.pb -t 36.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/37.vcf -o 37.pb
/usr/bin/time -o 37.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/37.vcf -i 37.pb -o 37.opt.pb -T 5
matUtils extract -i 37.opt.pb -t 37.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/38.vcf -o 38.pb
/usr/bin/time -o 38.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/38.vcf -i 38.pb -o 38.opt.pb -T 5
matUtils extract -i 38.opt.pb -t 38.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/39.vcf -o 39.pb
/usr/bin/time -o 39.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/39.vcf -i 39.pb -o 39.opt.pb -T 5
matUtils extract -i 39.opt.pb -t 39.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/40.vcf -o 40.pb
/usr/bin/time -o 40.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/40.vcf -i 40.pb -o 40.opt.pb -T 5
matUtils extract -i 40.opt.pb -t 40.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/41.vcf -o 41.pb
/usr/bin/time -o 41.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/41.vcf -i 41.pb -o 41.opt.pb -T 5
matUtils extract -i 41.opt.pb -t 41.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/42.vcf -o 42.pb
/usr/bin/time -o 42.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/42.vcf -i 42.pb -o 42.opt.pb -T 5
matUtils extract -i 42.opt.pb -t 42.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/43.vcf -o 43.pb
/usr/bin/time -o 43.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/43.vcf -i 43.pb -o 43.opt.pb -T 5
matUtils extract -i 43.opt.pb -t 43.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/44.vcf -o 44.pb
/usr/bin/time -o 44.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/44.vcf -i 44.pb -o 44.opt.pb -T 5
matUtils extract -i 44.opt.pb -t 44.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/45.vcf -o 45.pb
/usr/bin/time -o 45.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/45.vcf -i 45.pb -o 45.opt.pb -T 5
matUtils extract -i 45.opt.pb -t 45.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/46.vcf -o 46.pb
/usr/bin/time -o 46.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/46.vcf -i 46.pb -o 46.opt.pb -T 5
matUtils extract -i 46.opt.pb -t 46.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/47.vcf -o 47.pb
/usr/bin/time -o 47.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/47.vcf -i 47.pb -o 47.opt.pb -T 5
matUtils extract -i 47.opt.pb -t 47.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/48.vcf -o 48.pb
/usr/bin/time -o 48.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/48.vcf -i 48.pb -o 48.opt.pb -T 5
matUtils extract -i 48.opt.pb -t 48.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/49.vcf -o 49.pb
/usr/bin/time -o 49.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/49.vcf -i 49.pb -o 49.opt.pb -T 5
matUtils extract -i 49.opt.pb -t 49.opt.nwk

usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/50.vcf -o 50.pb
/usr/bin/time -o 50.scratch_matopt.time -f "%E %M" matOptimize -v ../../input/CUMULATIVE_VCFS/50.vcf -i 50.pb -o 50.opt.pb -T 5
matUtils extract -i 50.opt.pb -t 50.opt.nwk
