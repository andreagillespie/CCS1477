#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
  bigwigs/DMSO-NEG-H2AZac-3_S96.bw \
  bigwigs/DMSO-POS-H2AZac-6_S99.bw \
  bigwigs/CCS-NEG-H2AZac-9_S102.bw \
  bigwigs/CCS-POS-H2AZac-12_S89.bw \
  -R macs/broadpeaks/DMSO-NEG-H2AZ-2_S95_peaks.broadPeak \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_H2AZac_H2AZpeaks.gz

plotHeatmap -m results/DTmatrix_H2AZac_H2AZpeaks.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-H2AZac DMSO-POS-H2AZac CCS-NEG-H2AZac CCS-POS-H2AZac \
  --colorMap Greens \
  --regionsLabel "H2AZ peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_H2AZac_H2AZpeaks.pdf \
  --plotTitle "H2AZac ChIPs, DMSO-NEG sorted"

plotProfile -m results/DTmatrix_H2AZac_H2AZpeaks.gz \
  --samplesLabel DMSO-NEG-H2AZac DMSO-POS-H2AZac CCS-NEG-H2AZac CCS-POS-H2AZac \
  --regionsLabel "H2AZ peaks" \
  --plotTitle "H2AZac ChIPs" \
  -o plots/Profile_H2AZac_H2AZpeaks.pdf \
  --perGroup 
