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
  bigwigs/ChIP-D-NEG-1-K7-26_S143.RPGC.bw \
  bigwigs/ChIP-D-NEG-2-K7-34_S152.RPGC.bw \
  bigwigs/ChIP-D-NEG-3-K7-42_S161.RPGC.bw \
  bigwigs/ChIP-D-POS-1-K7-28_S145.RPGC.bw \
  bigwigs/ChIP-D-POS-2-K7-36_S154.RPGC.bw \
  bigwigs/ChIP-D-POS-3-K7-44_S163.RPGC.bw \
  bigwigs/ChIP-C-NEG-1-K7-30_S148.RPGC.bw \
  bigwigs/ChIP-C-NEG-2-K7-38_S156.RPGC.bw \
  bigwigs/ChIP-C-NEG-3-K7-46_S165.RPGC.bw \
  bigwigs/ChIP-C-POS-1-K7-32_S150.RPGC.bw \
  bigwigs/ChIP-C-POS-2-K7-40_S159.RPGC.bw \
  bigwigs/ChIP-C-POS-3-K7-48_S167.RPGC.bw \
  -R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_K7_MANE_TSS.gz

plotHeatmap -m results/DTmatrix_K7_MANE_TSS.gz \
  --sortUsingSamples 1 2 3 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-K7-1 DMSO-NEG-K7-2 DMSO-NEG-K7-3 \
  DMSO-POS-K7-1 DMSO-POS-K7-2 DMSO-POS-K7-3 \
  CCS-NEG-K7-1 CCS-NEG-K7-2 CCS-NEG-K7-3 \
  CCS-POS-K7-1 CCS-POS-K7-2 CCS-POS-K7-3 \
  --colorMap YlOrBr \
  --regionsLabel "MANE genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_K7_MANE_TSS.pdf \
  --plotTitle "K7 ChIPs, DMSO-NEG sorted"

plotProfile -m results/DTmatrix_K7_MANE_TSS.gz \
  --samplesLabel DMSO-NEG-K7-1 DMSO-NEG-K7-2 DMSO-NEG-K7-3 \
  DMSO-POS-K7-1 DMSO-POS-K7-2 DMSO-POS-K7-3 \
  CCS-NEG-K7-1 CCS-NEG-K7-2 CCS-NEG-K7-3 \
  CCS-POS-K7-1 CCS-POS-K7-2 CCS-POS-K7-3 \
  --regionsLabel "MANE genes" \
  --plotTitle "K7 ChIPs" \
  -o plots/Profile_K7_MANE_TSS.pdf \
  --perGroup 
