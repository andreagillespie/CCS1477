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

computeMatrix reference-point --referencePoint TSS -S \
  bigwigs/DMSO-NEG-H2AZ.merged.RPGC.bw \
  bigwigs/DMSO-POS-H2AZ.merged.RPGC.bw \
  bigwigs/CCS-NEG-H2AZ.merged.RPGC.bw \
  bigwigs/CCS-POS-H2AZ.merged.RPGC.bw \
  -R /dawson_genomics/Projects/CCS1477/ChIP_250612/bed_files/top_expressed_steadystate.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_H2AZ_topExpTSS.gz

plotHeatmap -m results/DTmatrix_H2AZ_topExpTSS.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-H2AZ DMSO-POS-H2AZ \
  CCS-NEG-H2AZ CCS-POS-H2AZ \
  --colorMap RdPu \
  --regionsLabel "top expressed genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_H2AZ_topExpTSS.pdf \
  --plotTitle "H2AZ ChIPs merged, DMSO-NEG sorted"

plotProfile -m results/DTmatrix_H2AZ_topExpTSS.gz \
  --samplesLabel DMSO-NEG-H2AZ DMSO-POS-H2AZ \
  CCS-NEG-H2AZ CCS-POS-H2AZ \
  --regionsLabel "top expressed genes" \
  --plotTitle "H2AZ ChIPs merged" \
  -o plots/Profile_H2AZ_topExpTSS.pdf \
  --perGroup 
