#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-08:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
  bigwigs/DMSO-NEG-H2A-1_S94.bw \
  bigwigs/DMSO-POS-H2A-4_S97.bw \
  bigwigs/CCS-NEG-H2A-7_S100.bw \
  bigwigs/CCS-POS-H2A-10_S87.bw \
  -R macs/broadpeaks/DMSO-NEG-H2AZac-3_S96_peaks.broadPeak \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_H2A_H2AZacpeaks.gz

plotHeatmap -m results/DTmatrix_H2A_H2AZacpeaks.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-H2A DMSO-POS-H2A CCS-NEG-H2A CCS-POS-H2A \
  --colorMap Purples \
  --regionsLabel "H2AZac peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_H2A_H2AZacpeaks.pdf \
  --plotTitle "H2A ChIPs, DMSO-NEG sorted"

plotProfile -m results/DTmatrix_H2A_H2AZacpeaks.gz \
  --samplesLabel DMSO-NEG-H2A DMSO-POS-H2A CCS-NEG-H2A CCS-POS-H2A \
  --regionsLabel "H2AZac peaks" \
  --plotTitle "H2A ChIPs" \
  -out plots/Profile_H2A_H2AZacpeaks.pdf \
  --perGroup 
