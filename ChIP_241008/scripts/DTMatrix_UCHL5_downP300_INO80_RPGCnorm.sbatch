#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
bigwigs/UCHL5-DMSO-P300.merged.RPGC.bw bigwigs/UCHL5-CCS-P300.merged.RPGC.bw \
bigwigs/UCHL5-DMSO-INO80.merged.RPGC.bw bigwigs/UCHL5-CCS-INO80.merged.RPGC.bw \
-R bdgdiff/UCHL5-P300-CCSvsDMSO_c3.0_cond2.bed \
bdgdiff/UCHL5-INO80-CCSvsDMSO_c3.0_cond2.bed \
-a 3000 -b 3000 -o results/DTmatrix_UCHL5_downP300_INO80.gz

plotHeatmap -m results/DTmatrix_UCHL5_downP300_INO80.gz \
--sortUsingSamples 1 3 \
--sortUsing sum \
--samplesLabel UCHL5-DMSO-P300 UCHL5-CCS-P300 UCHL5-DMSO-INO80 UCHL5-CCS-INO80 \
--colorMap Greens Greens Oranges Oranges \
--regionsLabel "UCHL5 CCSvDMSO P300 down" "UCHL5 CCSvDMSO INO80 down" \
-o plots/Heatmap_UCHL5_downP300_INO80.pdf --plotTitle "UCHL5 CCSvDMSO, 1&3 sorted"

plotProfile -m results/DTmatrix_UCHL5_downP300_INO80.gz \
-out plots/Profile_UCHL5_downP300_INO80.pdf \
--samplesLabel UCHL5-DMSO-P300 UCHL5-CCS-P300 UCHL5-DMSO-INO80 UCHL5-CCS-INO80 \
--regionsLabel "UCHL5 CCSvDMSO P300 down" "UCHL5 CCSvDMSO INO80 down" \
--plotTitle "UCHL5 CCSvDMSO, 1&3 sorted" --perGroup 
