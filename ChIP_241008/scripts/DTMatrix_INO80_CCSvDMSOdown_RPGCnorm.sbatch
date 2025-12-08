#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=prod_short

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
bigwigs/INO80E-DMSO-INO80.merged.RPGC.bw bigwigs/INO80E-CCS-INO80.merged.RPGC.bw \
bigwigs/UCHL5-DMSO-INO80.merged.RPGC.bw bigwigs/UCHL5-CCS-INO80.merged.RPGC.bw \
-R bdgdiff_autoDedup/INO80E-INO80-CCSvsDMSO_c3.0_cond2.bed \
bdgdiff_autoDedup/UCHL5-INO80-CCSvsDMSO_c3.0_cond2.bed \
-a 3000 -b 3000 -o results/DTmatrix_INO80_CCSvDMSOdown.gz

plotHeatmap -m results/DTmatrix_INO80_CCSvDMSOdown.gz \
--sortUsingSamples 1 --sortUsing sum \
--samplesLabel INO80E-DMSO-INO80 INO80E-CCS-INO80 UCHL5-DMSO-INO80 UCHL5-CCS-INO80 \
--colorMap Oranges --regionsLabel "INO80E CCSvDMSO down" "UCHL5 CCSvDMSO down" \
-o plots/Heatmap_INO80_CCSvDMSOdown.pdf --plotTitle "INO80 ChIPs, 1 sorted"

plotProfile -m results/DTmatrix_INO80_CCSvDMSOdown.gz \
-out plots/Profile_INO80_CCSvDMSOdown.pdf \
--samplesLabel INO80E-DMSO-INO80 INO80E-CCS-INO80 UCHL5-DMSO-INO80 UCHL5-CCS-INO80 \
--regionsLabel "INO80E CCSvDMSO down" "UCHL5 CCSvDMSO down" \
--plotTitle "INO80 ChIPs" --perGroup 
