#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=24G
#SBATCH --time=0-16:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_GeneRegion"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module purge
module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
  bigwigs/DMSO-NEG-K7_H2AZ_LFC.bw \
  bigwigs/DMSO-POS-K7_H2AZ_LFC.bw \
  bigwigs/CCS-NEG-K7_H2AZ_LFC.bw \
  bigwigs/CCS-POS-K7_H2AZ_LFC.bw \
  -R ../ChIP_241008/bed_files/INO80E-DMSO-P300_INO80_HA_peak_autoDedup_intersect_homer.bed \
  ../ChIP_241008/bed_files/INO80E-DMSO-P300_INO80_ONLY_peak_autoDedup_intersect_homer.bed \
  ../ChIP_241008/bed_files/INO80E-DMSO-P300_peak_autoDedup_only_homer.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_K7_H2AZ_LFC.gz \
  --numberOfProcessors max 

# unclustered heatmap sorted by steady state
plotHeatmap -m results/DTmatrix_K7_H2AZ_LFC.gz \
  -out plots/Heatmap_RP_K7_H2AZ_LFC.pdf \
  --colorMap PiYG \
  --samplesLabel DMSO-NEG DMSO-POS CCS-NEG CCS-POS \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --regionsLabel "P300_INO80_HA" "P300_INO80" "P300" \
  --heatmapHeight 15 \
  --plotTitle "K7/H2AZ LFC" \
  -min -1 -max 1
  
plotProfile -m results/DTmatrix_K7_H2AZ_LFC.gz \
  --samplesLabel DMSO-NEG DMSO-POS CCS-NEG CCS-POS \
  --regionsLabel "P300_INO80_HA" "P300_INO80" "P300" \
  --plotTitle "HK7/H2AZ LFC" \
  -o plots/Profile_K7_H2AZ_LFC.pdf \
  --perGroup 
