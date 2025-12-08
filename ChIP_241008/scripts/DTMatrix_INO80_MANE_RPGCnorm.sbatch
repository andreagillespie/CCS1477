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
bigwigs/INO80E-DMSO-INO80-R1-13_S12.RPGC.bw bigwigs/INO80E-DMSO-INO80-R2-14_S13.RPGC.bw bigwigs/INO80E-DMSO-INO80-R3-15_S14.RPGC.bw \
bigwigs/INO80E-CCS-INO80-R1-16_S15.RPGC.bw bigwigs/INO80E-CCS-INO80-R2-17_S16.RPGC.bw bigwigs/INO80E-CCS-INO80-R3-18_S17.RPGC.bw \
bigwigs/UCHL5-DMSO-INO80-R1-19_S18.RPGC.bw bigwigs/UCHL5-DMSO-INO80-R2-20_S20.RPGC.bw bigwigs/UCHL5-DMSO-INO80-R3-21_S21.RPGC.bw \
bigwigs/UCHL5-CCS-INO80-R1-22_S22.RPGC.bw bigwigs/UCHL5-CCS-INO80-R2-23_S23.RPGC.bw bigwigs/UCHL5-CCS-INO80-R3-24_S24.RPGC.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_INO80_MANEgenes.gz

plotHeatmap -m results/DTmatrix_INO80_MANEgenes.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel INO80E-DMSO-INO80-R1 INO80E-DMSO-INO80-R2 INO80E-DMSO-INO80-R3 \
INO80E-CCS-INO80-R1 INO80E-CCS-INO80-R2 INO80E-CCS-INO80-R3 \
UCHL5-DMSO-INO80-R1 UCHL5-DMSO-INO80-R2 UCHL5-DMSO-INO80-R3 \
UCHL5-CCS-INO80-R1 UCHL5-CCS-INO80-R2 UCHL5-CCS-INO80-R3 \
--colorMap Oranges --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_INO80_MANEgenes.pdf --plotTitle "INO80 ChIPs, 1 sorted"

plotProfile -m results/DTmatrix_INO80_MANEgenes.gz -out plots/Profile_INO80_MANEgenes.pdf \
--samplesLabel INO80E-DMSO-INO80-R1 INO80E-DMSO-INO80-R2 INO80E-DMSO-INO80-R3 \
INO80E-CCS-INO80-R1 INO80E-CCS-INO80-R2 INO80E-CCS-INO80-R3 \
UCHL5-DMSO-INO80-R1 UCHL5-DMSO-INO80-R2 UCHL5-DMSO-INO80-R3 \
UCHL5-CCS-INO80-R1 UCHL5-CCS-INO80-R2 UCHL5-CCS-INO80-R3 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "INO80 ChIPs" --perGroup 
