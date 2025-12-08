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
  bigwigs/DMSO-NEG-K11-R1-13_S24_Dmnorm.bw \
  bigwigs/DMSO-NEG-K11-R2-17_S28_Dmnorm.bw \
  bigwigs/DMSO-NEG-K11-R3-21_S33_Dmnorm.bw \
  bigwigs/DMSO-POS-K11-R1-14_S25_Dmnorm.bw \
  bigwigs/DMSO-POS-K11-R2-18_S29_Dmnorm.bw \
  bigwigs/DMSO-POS-K11-R3-22_S34_Dmnorm.bw \
  bigwigs/CCS-NEG-K11-R1-15_S26_Dmnorm.bw \
  bigwigs/CCS-NEG-K11-R2-19_S30_Dmnorm.bw \
  bigwigs/CCS-NEG-K11-R3-23_S35_Dmnorm.bw \
  bigwigs/CCS-POS-K11-R1-16_S27_Dmnorm.bw \
  bigwigs/CCS-POS-K11-R2-20_S32_Dmnorm.bw \
  bigwigs/CCS-POS-K11-R3-24_S36_Dmnorm.bw \
  -R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_K11_MANE_TSS_Dmnorm.gz

plotHeatmap -m results/DTmatrix_K11_MANE_TSS_Dmnorm.gz \
  --sortUsingSamples 1 2 3 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-K11-R1 DMSO-NEG-K11-R2 DMSO-NEG-K11-R3 \
  DMSO-POS-K11-R1 DMSO-POS-K11-R2 DMSO-POS-K11-R3 \
  CCS-NEG-K11-R1 CCS-NEG-K11-R2 CCS-NEG-K11-R3 \
  CCS-POS-K11-R1 CCS-POS-K11-R2 CCS-POS-K11-R3 \
  --colorMap YlOrBr \
  --regionsLabel "MANE genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_K11_MANE_TSS_Dmnorm.pdf \
  --plotTitle "K11 ChIPs, DMSO-NEG sorted, Dm normalised"

plotProfile -m results/DTmatrix_K11_MANE_TSS_Dmnorm.gz \
  --samplesLabel DMSO-NEG-K11-R1 DMSO-NEG-K11-R2 DMSO-NEG-K11-R3 \
  DMSO-POS-K11-R1 DMSO-POS-K11-R2 DMSO-POS-K11-R3 \
  CCS-NEG-K11-R1 CCS-NEG-K11-R2 CCS-NEG-K11-R3 \
  CCS-POS-K11-R1 CCS-POS-K11-R2 CCS-POS-K11-R3 \
  --regionsLabel "MANE genes" \
  --plotTitle "K11 ChIPs, Dm normalised" \
  -o plots/Profile_K11_MANE_TSS_Dmnorm.pdf \
  --perGroup 
