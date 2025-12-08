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

computeMatrix reference-point --referencePoint TSS -S \
  bigwigs/DMSO-NEG-H2AZac_H2AZ_LFC.bw \
  bigwigs/DMSO-POS-H2AZac_H2AZ_LFC.bw \
  bigwigs/CCS-NEG-H2AZac_H2AZ_LFC.bw \
  bigwigs/CCS-POS-H2AZac_H2AZ_LFC.bw \
  -R /dawson_genomics/Projects/CCS1477/ChIP_250612/bed_files/top_expressed_steadystate.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_H2AZac_H2AZ_LFC_topExpTSS.gz \
  --numberOfProcessors max 

# unclustered heatmap sorted by steady state
plotHeatmap -m results/DTmatrix_H2AZac_H2AZ_LFC_topExpTSS.gz \
  -out plots/Heatmap_RP_H2AZac_H2AZ_LFC_topExpTSS.pdf \
  --colorMap BrBG \
  --samplesLabel DMSO-NEG DMSO-POS CCS-NEG CCS-POS \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --regionsLabel "top expressed genes" \
  --heatmapHeight 15 \
  --plotTitle "H2AZac/H2AZ LFC, DMSO-NEG sorted" \
  -min -3 -max 3
  
plotProfile -m results/DTmatrix_H2AZac_H2AZ_LFC_topExpTSS.gz \
  --samplesLabel DMSO-NEG DMSO-POS CCS-NEG CCS-POS \
  --regionsLabel "top expressed genes" \
  --plotTitle "HH2AZac/H2AZ LFC" \
  -o plots/Profile_H2AZac_H2AZ_LFC_topExpTSS.pdf \
  --perGroup 
