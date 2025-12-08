#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-12:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=prod_med

module load deeptools/3.5.0

computeMatrix scale-regions -S \
bigwigs/INO80E-DMSO-HA-R1-25_S25.RPGC.bw bigwigs/INO80E-DMSO-HA-R2-26_S26.RPGC.bw bigwigs/INO80E-DMSO-HA-R3-27_S27.RPGC.bw \
bigwigs/INO80E-CCS-HA-R1-28_S28.RPGC.bw bigwigs/INO80E-CCS-HA-R2-29_S29.RPGC.bw bigwigs/INO80E-CCS-HA-R3-30_S31.RPGC.bw \
bigwigs/UCHL5-DMSO-HA-R1-31_S32.RPGC.bw bigwigs/UCHL5-DMSO-HA-R2-32_S33.RPGC.bw bigwigs/UCHL5-DMSO-HA-R3-33_S34.RPGC.bw \
bigwigs/UCHL5-CCS-HA-R1-34_S35.RPGC.bw bigwigs/UCHL5-CCS-HA-R2-25_S36.RPGC.bw bigwigs/UCHL5-CCS-HA-R3-36_S37.RPGC.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_HA_MANEgenes.gz

plotHeatmap -m results/DTmatrix_HA_MANEgenes.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel INO80E-DMSO-HA-R1 INO80E-DMSO-HA-R2 INO80E-DMSO-HA-R3 \
INO80E-CCS-HA-R1 INO80E-CCS-HA-R2 INO80E-CCS-HA-R3 \
UCHL5-DMSO-HA-R1 UCHL5-DMSO-HA-R2 UCHL5-DMSO-HA-R3 \
UCHL5-CCS-HA-R1 UCHL5-CCS-HA-R2 UCHL5-CCS-HA-R3 \
--colorMap Purples --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_HA_MANEgenes.pdf --plotTitle "HA ChIPs, 1 sorted"

plotProfile -m results/DTmatrix_HA_MANEgenes.gz -out plots/Profile_HA_MANEgenes.pdf \
--samplesLabel INO80E-DMSO-HA-R1 INO80E-DMSO-HA-R2 INO80E-DMSO-HA-R3 \
INO80E-CCS-HA-R1 INO80E-CCS-HA-R2 INO80E-CCS-HA-R3 \
UCHL5-DMSO-HA-R1 UCHL5-DMSO-HA-R2 UCHL5-DMSO-HA-R3 \
UCHL5-CCS-HA-R1 UCHL5-CCS-HA-R2 UCHL5-CCS-HA-R3 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "HA ChIPs" --perGroup 
