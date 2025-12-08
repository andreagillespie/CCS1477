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
  bigwigs/ChIP-D-NEG-2-H2A-1_S136.RPGC.bw bigwigs/ChIP-D-NEG-3-H2A-13_S129.RPGC.bw \
  bigwigs/ChIP-D-POS-2-H2A-4_S169.RPGC.bw bigwigs/ChIP-D-POS-3-H2A-16_S132.RPGC.bw \
  bigwigs/ChIP-C-NEG-2-H2A-7_S173.RPGC.bw bigwigs/ChIP-C-NEG-3-H2A-19_S135.RPGC.bw \
  bigwigs/ChIP-C-POS-2-H2A-10_S126.RPGC.bw bigwigs/ChIP-C-POS-3-H2A-22_S139.RPGC.bw \
  -R ../ChIP_241008/bed_files/INO80E-DMSO-P300_INO80_HA_peak_autoDedup_intersect_homer.bed \
  ../ChIP_241008/bed_files/INO80E-DMSO-P300_INO80_ONLY_peak_autoDedup_intersect_homer.bed \
  ../ChIP_241008/bed_files/INO80E-DMSO-P300_peak_autoDedup_only_homer.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_H2A_barGroups.gz

plotHeatmap -m results/DTmatrix_H2A_barGroups.gz \
  --sortUsingSamples 1 2 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-H2A-2 DMSO-NEG-H2A-3 DMSO-POS-H2A-2 DMSO-POS-H2A-3 \
  CCS-NEG-H2A-2 CCS-NEG-H2A-3 CCS-POS-H2A-2 CCS-POS-H2A-3 \
  --colorMap gist_heat_r \
  --regionsLabel "P300_INO80_HA" "P300_INO80" "P300" \
  --heatmapHeight 15 \
  -o plots/Heatmap_H2A_barGroups.pdf \
  --plotTitle "H2A ChIPs, DMSO-NEG sorted"

plotProfile -m results/DTmatrix_H2A_barGroups.gz \
  --samplesLabel DMSO-NEG-H2A-2 DMSO-NEG-H2A-3 DMSO-POS-H2A-2 DMSO-POS-H2A-3 \
  CCS-NEG-H2A-2 CCS-NEG-H2A-3 CCS-POS-H2A-2 CCS-POS-H2A-3 \
  --regionsLabel "P300_INO80_HA" "P300_INO80" "P300" \
  --plotTitle "H2A ChIPs" \
  -o plots/Profile_H2A_barGroups.pdf \
  --perGroup 
