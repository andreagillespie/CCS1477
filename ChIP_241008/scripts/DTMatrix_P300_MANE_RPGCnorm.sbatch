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
bigwigs/INO80E-DMSO-P300-R1-1_S19.RPGC.bw bigwigs/INO80E-DMSO-P300-R2-2_S30.RPGC.bw bigwigs/INO80E-DMSO-P300-R3-3_S41.RPGC.bw \
bigwigs/INO80E-CCS-P300-R1-4_S42.RPGC.bw bigwigs/INO80E-CCS-P300-R2-5_S43.RPGC.bw bigwigs/INO80E-CCS-P300-R3-6_S44.RPGC.bw \
bigwigs/UCHL5-DMSO-P300-R1-7_S45.RPGC.bw bigwigs/UCHL5-DMSO-P300-R2-8_S46.RPGC.bw bigwigs/UCHL5-DMSO-P300-R3-9_S47.RPGC.bw \
bigwigs/UCHL5-CCS-P300-R1-10_S9.RPGC.bw bigwigs/UCHL5-CCS-P300-R2-11_S10.RPGC.bw bigwigs/UCHL5-CCS-P300-R3-12_S11.RPGC.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_P300_MANEgenes.gz

plotHeatmap -m results/DTmatrix_P300_MANEgenes.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel INO80E-DMSO-P300-R1 INO80E-DMSO-P300-R2 INO80E-DMSO-P300-R3 \
INO80E-CCS-P300-R1 INO80E-CCS-P300-R2 INO80E-CCS-P300-R3 \
UCHL5-DMSO-P300-R1 UCHL5-DMSO-P300-R2 UCHL5-DMSO-P300-R3 \
UCHL5-CCS-P300-R1 UCHL5-CCS-P300-R2 UCHL5-CCS-P300-R3 \
--colorMap Greens --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_P300_MANEgenes.pdf --plotTitle "P300 ChIPs, 1 sorted"

plotProfile -m results/DTmatrix_P300_MANEgenes.gz -out plots/Profile_P300_MANEgenes.pdf \
--samplesLabel INO80E-DMSO-P300-R1 INO80E-DMSO-P300-R2 INO80E-DMSO-P300-R3 \
INO80E-CCS-P300-R1 INO80E-CCS-P300-R2 INO80E-CCS-P300-R3 \
UCHL5-DMSO-P300-R1 UCHL5-DMSO-P300-R2 UCHL5-DMSO-P300-R3 \
UCHL5-CCS-P300-R1 UCHL5-CCS-P300-R2 UCHL5-CCS-P300-R3 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "P300 ChIPs" --perGroup 
