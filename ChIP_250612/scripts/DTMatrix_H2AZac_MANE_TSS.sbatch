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

computeMatrix reference-point --referencePoint TSS -S \
  bigwigs/ChIP-D-NEG-2-H2AZac-2_S147.RPGC.bw bigwigs/ChIP-D-NEG-3-H2AZac-14_S130.RPGC.bw \
  bigwigs/ChIP-D-POS-2-H2AZac-5_S171.RPGC.bw bigwigs/ChIP-D-POS-3-H2AZac-17_S133.RPGC.bw \
  bigwigs/ChIP-C-NEG-2-H2AZac-8_S174.RPGC.bw bigwigs/ChIP-C-NEG-3-H2AZac-20_S137.RPGC.bw \
  bigwigs/ChIP-C-POS-2-H2AZac-11_S127.RPGC.bw bigwigs/ChIP-C-POS-3-H2AZac-23_S140.RPGC.bw \
  -R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_H2AZac_MANE_TSS.gz

plotHeatmap -m results/DTmatrix_H2AZac_MANE_TSS.gz \
  --sortUsingSamples 1 2 \
  --sortUsing sum \
  --samplesLabel DMSO-NEG-H2AZac-2 DMSO-NEG-H2AZac-3 DMSO-POS-H2AZac-2 DMSO-POS-H2AZac-3 \
  CCS-NEG-H2AZac-2 CCS-NEG-H2AZac-3 CCS-POS-H2AZac-2 CCS-POS-H2AZac-3 \
  --colorMap PuBu \
  --regionsLabel "MANE genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_H2AZac_MANE_TSS.pdf \
  --plotTitle "H2AZac ChIPs, DMSO-NEG sorted"

plotProfile -m results/DTmatrix_H2AZac_MANE_TSS.gz \
  --samplesLabel DMSO-NEG-H2AZac-2 DMSO-NEG-H2AZac-3 DMSO-POS-H2AZac-2 DMSO-POS-H2AZac-3 \
  CCS-NEG-H2AZac-2 CCS-NEG-H2AZac-3 CCS-POS-H2AZac-2 CCS-POS-H2AZac-3 \
  --regionsLabel "MANE genes" \
  --plotTitle "H2AZac ChIPs" \
  -o plots/Profile_H2AZac_MANE_TSS.pdf \
  --perGroup 
