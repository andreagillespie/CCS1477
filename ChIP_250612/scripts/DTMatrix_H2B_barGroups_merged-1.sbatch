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
  bigwigs/DMSO-NEG-H2B.merged.RPGC.bw \
  bigwigs/DMSO-POS-H2B.merged.RPGC.bw \
  bigwigs/CCS-NEG-H2B.merged.RPGC.bw \
  bigwigs/CCS-POS-H2B.merged.RPGC.bw \
  -R ../ChIP_241008/bed_files/INO80E-DMSO-P300_INO80_HA_peak_autoDedup_intersect_homer.bed \
  ../ChIP_241008/bed_files/INO80E-DMSO-P300_INO80_ONLY_peak_autoDedup_intersect_homer.bed \
  ../ChIP_241008/bed_files/INO80E-DMSO-P300_peak_autoDedup_only_homer.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_H2B_barGroups_merged-1.gz

plotHeatmap -m results/DTmatrix_H2B_barGroups_merged-1.gz \
  --sortUsingSamples 1 2 3 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-H2B \
  DMSO-POS-H2B \
  CCS-NEG-H2B \
  CCS-POS-H2B \
  --colorMap BuPu \
  --regionsLabel "P300_INO80_HA" "P300_INO80" "P300" \
  --heatmapHeight 15 \
  -o plots/Heatmap_H2B_barGroups_merged-1.pdf \
  --plotTitle "H2B ChIPs merged, DMSO-NEG sorted"

plotProfile -m results/DTmatrix_H2B_barGroups_merged-1.gz \
  --samplesLabel DMSO-NEG-H2B \
  DMSO-POS-H2B \
  CCS-NEG-H2B \
  CCS-POS-H2B \
  --regionsLabel "P300_INO80_HA" "P300_INO80" "P300" \
  --plotTitle "H2B ChIPs merged" \
  -o plots/Profile_H2B_barGroups_merged-1.pdf \
  --perGroup 
