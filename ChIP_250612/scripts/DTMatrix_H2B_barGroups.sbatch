#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-12:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
  bigwigs/ChIP-D-NEG-1-H2B-25_S142.RPGC.bw \
  bigwigs/ChIP-D-NEG-2-H2B-33_S151.RPGC.bw \
  bigwigs/ChIP-D-NEG-3-H2B-41_S160.RPGC.bw \
  bigwigs/ChIP-D-POS-1-H2B-27_S144.RPGC.bw \
  bigwigs/ChIP-D-POS-2-H2B-35_S153.RPGC.bw \
  bigwigs/ChIP-D-POS-3-H2B-43_S162.RPGC.bw \
  bigwigs/ChIP-C-NEG-1-H2B-29_S146.RPGC.bw \
  bigwigs/ChIP-C-NEG-2-H2B-37_S155.RPGC.bw \
  bigwigs/ChIP-C-NEG-3-H2B-45_S164.RPGC.bw \
  bigwigs/ChIP-C-POS-1-H2B-31_S149.RPGC.bw \
  bigwigs/ChIP-C-POS-2-H2B-39_S157.RPGC.bw \
  bigwigs/ChIP-C-POS-3-H2B-47_S166.RPGC.bw \
  -R ../ChIP_241008/bed_files/INO80E-DMSO-P300_INO80_HA_peak_autoDedup_intersect_homer.bed \
  ../ChIP_241008/bed_files/INO80E-DMSO-P300_INO80_ONLY_peak_autoDedup_intersect_homer.bed \
  ../ChIP_241008/bed_files/INO80E-DMSO-P300_peak_autoDedup_only_homer.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_H2B_barGroups.gz

plotHeatmap -m results/DTmatrix_H2B_barGroups.gz \
  --sortUsingSamples 1 2 3 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-H2B-1 DMSO-NEG-H2B-2 DMSO-NEG-H2B-3 \
  DMSO-POS-H2B-1 DMSO-POS-H2B-2 DMSO-POS-H2B-3 \
  CCS-NEG-H2B-1 CCS-NEG-H2B-2 CCS-NEG-H2B-3 \
  CCS-POS-H2B-1 CCS-POS-H2B-2 CCS-POS-H2B-3 \
  --colorMap BuPu \
  --regionsLabel "P300_INO80_HA" "P300_INO80" "P300" \
  --heatmapHeight 15 \
  -o plots/Heatmap_H2B_barGroups.pdf \
  --plotTitle "H2B ChIPs, DMSO-NEG sorted"

plotProfile -m results/DTmatrix_H2B_barGroups.gz \
  --samplesLabel DMSO-NEG-H2B-1 DMSO-NEG-H2B-2 DMSO-NEG-H2B-3 \
  DMSO-POS-H2B-1 DMSO-POS-H2B-2 DMSO-POS-H2B-3 \
  CCS-NEG-H2B-1 CCS-NEG-H2B-2 CCS-NEG-H2B-3 \
  CCS-POS-H2B-1 CCS-POS-H2B-2 CCS-POS-H2B-3 \
  --regionsLabel "P300_INO80_HA" "P300_INO80" "P300" \
  --plotTitle "H2B ChIPs" \
  -o plots/Profile_H2B_barGroups.pdf \
  --perGroup 
