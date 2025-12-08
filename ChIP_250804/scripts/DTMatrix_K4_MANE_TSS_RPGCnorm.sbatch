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
  bigwigs/DMSO-NEG-K4-R1-1_S31.RPGC.bw \
  bigwigs/DMSO-NEG-K4-R2-5_S44.RPGC.bw \
  bigwigs/DMSO-NEG-K4-R3-9_S48.RPGC.bw \
  bigwigs/DMSO-POS-K4-R1-2_S41.RPGC.bw \
  bigwigs/DMSO-POS-K4-R2-6_S45.RPGC.bw \
  bigwigs/DMSO-POS-K4-R3-10_S21.RPGC.bw \
  bigwigs/CCS-NEG-K4-R1-3_S42.RPGC.bw \
  bigwigs/CCS-NEG-K4-R2-7_S46.RPGC.bw \
  bigwigs/CCS-NEG-K4-R3-11_S22.RPGC.bw \
  bigwigs/CCS-POS-K4-R1-4_S43.RPGC.bw \
  bigwigs/CCS-POS-K4-R2-8_S47.RPGC.bw \
  bigwigs/CCS-POS-K4-R3-12_S23.RPGC.bw \
  -R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_K4_MANE_TSS_RPGCnorm.gz

plotHeatmap -m results/DTmatrix_K4_MANE_TSS_RPGCnorm.gz \
  --sortUsingSamples 1 2 3 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-K4-R1 DMSO-NEG-K4-R2 DMSO-NEG-K4-R3 \
  DMSO-POS-K4-R11 DMSO-POS-K4-R2 DMSO-POS-K4-R3 \
  CCS-NEG-K4-R1 CCS-NEG-K4-R2 CCS-NEG-K4-R3 \
  CCS-POS-K4-R1 CCS-POS-K4-R2 CCS-POS-K4-R3 \
  --colorMap YlOrBr \
  --regionsLabel "MANE genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_K4_MANE_TSS_RPGCnorm.pdf \
  --plotTitle "K4 ChIPs, DMSO-NEG sorted, RPGC normalised"

plotProfile -m results/DTmatrix_K4_MANE_TSS_RPGCnorm.gz \
  --samplesLabel DMSO-NEG-K4-R1 DMSO-NEG-K4-R2 DMSO-NEG-K4-R3 \
  DMSO-POS-K4-R11 DMSO-POS-K4-R2 DMSO-POS-K4-R3 \
  CCS-NEG-K4-R1 CCS-NEG-K4-R2 CCS-NEG-K4-R3 \
  CCS-POS-K4-R1 CCS-POS-K4-R2 CCS-POS-K4-R3 \
  --regionsLabel "MANE genes" \
  --plotTitle "K4 ChIPs, RPGC normalised" \
  -o plots/Profile_K4_MANE_TSS_RPGCnorm.pdf \
  --perGroup 
