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
bigwigs/INO80E-DMSO-P300.merged.RPGC.bw bigwigs/INO80E-CCS-P300.merged.RPGC.bw \
bigwigs/INO80E-DMSO-INO80.merged.RPGC.bw bigwigs/INO80E-CCS-INO80.merged.RPGC.bw \
-R bdgdiff/INO80E-P300-CCSvsDMSO_c3.0_cond2.bed \
bdgdiff/INO80E-INO80-CCSvsDMSO_c3.0_cond2.bed \
-a 3000 -b 3000 -o results/DTmatrix_INO80E_downP300_INO80.gz

plotHeatmap -m results/DTmatrix_INO80E_downP300_INO80.gz \
--sortUsingSamples 1 3 \
--sortUsing sum \
--samplesLabel INO80E-DMSO-P300 INO80E-CCS-P300 INO80E-DMSO-INO80 INO80E-CCS-INO80 \
--colorMap Greens Greens Oranges Oranges \
--regionsLabel "INO80E CCSvDMSO P300 down" "INO80E CCSvDMSO INO80 down" \
-o plots/Heatmap_INO80E_downP300_INO80.pdf --plotTitle "INO80E CCSvDMSO, 1&3 sorted"

plotProfile -m results/DTmatrix_INO80E_downP300_INO80.gz \
-out plots/Profile_INO80E_downP300_INO80.pdf \
--samplesLabel INO80E-DMSO-P300 INO80E-CCS-P300 INO80E-DMSO-INO80 INO80E-CCS-INO80 \
--regionsLabel "INO80E CCSvDMSO P300 down" "INO80E CCSvDMSO INO80 down" \
--plotTitle "INO80E CCSvDMSO, 1&3 sorted" --perGroup 
