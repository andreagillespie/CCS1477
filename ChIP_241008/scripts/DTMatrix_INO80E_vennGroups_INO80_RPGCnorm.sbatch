#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=prod_med

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
bigwigs/INO80E-DMSO-INO80.merged.RPGC.bw bigwigs/INO80E-CCS-INO80.merged.RPGC.bw \
-R bed_files/INO80E-DMSO-P300_INO80_HA_peak_autoDedup_intersect_homer.bed \
bed_files/INO80E-DMSO-P300_INO80_ONLY_peak_autoDedup_intersect_homer.bed \
bed_files/INO80E-DMSO-INO80_peak_autoDedup_only_homer.bed \
bed_files/INO80E-DMSO-P300_peak_autoDedup_only_homer.bed \
bed_files/INO80E-DMSO-INO80_HA_ONLY_peak_autoDedup_intersect_homer.bed \
-a 3000 -b 3000 -o results/DTmatrix_INO80E_vennGroups_INO80.gz

plotProfile -m results/DTmatrix_INO80E_vennGroups_INO80.gz \
-out plots/Profile_INO80E_vennGroups_INO80.pdf \
--samplesLabel INO80E-DMSO-INO80 INO80E-CCS-INO80 \
--regionsLabel "INO80E-DMSO-P300_INO80_HA_autoDedup" \
"INO80E-DMSO-P300_INO80_only_autoDedup" "INO80E-DMSO-INO80_only_autoDedup" \
"INO80E-DMSO-P300_only_autoDedup" "INO80E-DMSO-INO80_HA_only_autoDedup" \
--plotTitle "venn groups" --perGroup 
