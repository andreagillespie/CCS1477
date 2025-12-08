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
bigwigs/INO80E-DMSO-HA.merged.RPGC.bw bigwigs/INO80E-CCS-HA.merged.RPGC.bw \
bigwigs/UCHL5-DMSO-HA.merged.RPGC.bw bigwigs/UCHL5-CCS-HA.merged.RPGC.bw \
-R bdgdiff_autoDedup/INO80E-HA-CCSvsDMSO_c3.0_cond2.bed \
-a 3000 -b 3000 -o results/DTmatrix_HA_CCSvDMSOdown.gz

plotHeatmap -m results/DTmatrix_HA_CCSvDMSOdown.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel INO80E-DMSO-HA INO80E-CCS-HA UCHL5-DMSO-HA UCHL5-CCS-HA \
--colorMap Purples --regionsLabel "INO80E CCSvDMSO down" --heatmapHeight 5 \
-o plots/Heatmap_HA_CCSvDMSOdown.pdf --plotTitle "HA ChIPs, 1 sorted"

plotProfile -m results/DTmatrix_HA_CCSvDMSOdown.gz -out plots/Profile_HA_CCSvDMSOdown.pdf \
--samplesLabel INO80E-DMSO-HA INO80E-CCS-HA UCHL5-DMSO-HA UCHL5-CCS-HA \
--regionsLabel "INO80E CCSvDMSO down" \
--plotTitle "HA ChIPs" --perGroup 
