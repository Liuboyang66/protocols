#step1.map.sh
minimap_miniasm/220111/minimap2-master/minimap2 -t 24 -x map-pb inputgenome.fa Manis_hifi.fa >Manis_hifi.paf

#step2.stat.sh
purge_dups-1.2.5/bin/pbcstat Manis_hifi.paf
purge_dups-1.2.5/bin/calcuts PB.stat > cutoffs 2>calcults.log
python/3.8.6/bin/python3.8 purge_dups-1.2.5/scripts/hist_plot.py -c cutoffs PB.stat PB.cov.png

#step3.map.sh
purge_dups-1.2.5/bin/split_fa inputgenome.fa >genome.split
minimap_miniasm/220111/minimap2-master/minimap2 -t 24 -x asm10 -DP genome.split genome.split > genome.split.self.paf

#step4.purge.sh
purge_dups-1.2.5/bin/purge_dups -2 -T cutoffs -c PB.base.cov genome.split.self.paf > dups.bed 2> purge_dups.log
purge_dups-1.2.5/bin/get_seqs dups.bed inputgenome.fa
