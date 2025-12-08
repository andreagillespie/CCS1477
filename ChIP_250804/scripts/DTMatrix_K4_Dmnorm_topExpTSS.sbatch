#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint TSS -S \
  bigwigs/DMSO-NEG-K4.merged.Dmnorm.bw \
  bigwigs/DMSO-POS-K4.merged.Dmnorm.bw \
  bigwigs/CCS-NEG-K4.merged.Dmnorm.bw \
  bigwigs/CCS-POS-K4.merged.Dmnorm.bw \
  -R /dawson_genomics/Projects/CCS1477/ChIP_250612/bed_files/top_expressed_steadystate.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_K4_Dmnorm_topExpTSS.gz

plotHeatmap -m results/DTmatrix_K4_Dmnorm_topExpTSS.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-K4 DMSO-POS-K4 \
  CCS-NEG-K4 CCS-POS-K4 \
  --colorMap bone_r \
  --regionsLabel "top expressed genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_K4_Dmnorm_topExpTSS.pdf \
  --plotTitle "K4 ChIPs merged, spike-in normalised, DMSO-NEG sorted"

plotProfile -m results/DTmatrix_K4_Dmnorm_topExpTSS.gz \
  --samplesLabel DMSO-NEG-K4 DMSO-POS-K4 \
  CCS-NEG-K4 CCS-POS-K4 \
  --regionsLabel "top expressed genes" \
  --plotTitle "K4 ChIPs merged, spike-in normalised" \
  -o plots/Profile_K4_Dmnorm_topExpTSS.pdf \
  --perGroup 
