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
bigwigs/INO80E-DMSO-P300.merged.RPGC.bw bigwigs/INO80E-CCS-P300.merged.RPGC.bw \
bigwigs/UCHL5-DMSO-P300.merged.RPGC.bw bigwigs/UCHL5-CCS-P300.merged.RPGC.bw \
-R bdgdiff_autoDedup/INO80E-P300-CCSvsDMSO_c3.0_cond2.bed \
bdgdiff_autoDedup/UCHL5-P300-CCSvsDMSO_c3.0_cond2.bed \
-a 3000 -b 3000 -o results/DTmatrix_P300_CCSvDMSOdown.gz

plotHeatmap -m results/DTmatrix_P300_CCSvDMSOdown.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel INO80E-DMSO-P300 INO80E-CCS-P300 UCHL5-DMSO-P300 UCHL5-CCS-P300 \
--colorMap Greens --regionsLabel "INO80E CCSvDMSO down" "UCHL5 CCSvDMSO down" \
-o plots/Heatmap_P300_CCSvDMSOdown.pdf --plotTitle "P300 ChIPs, 1 sorted"

plotProfile -m results/DTmatrix_P300_CCSvDMSOdown.gz -out plots/Profile_P300_CCSvDMSOdown.pdf \
--samplesLabel INO80E-DMSO-P300 INO80E-CCS-P300 UCHL5-DMSO-P300 UCHL5-CCS-P300 \
--regionsLabel "INO80E CCSvDMSO down" "UCHL5 CCSvDMSO down" \
--plotTitle "P300 ChIPs" --perGroup 
