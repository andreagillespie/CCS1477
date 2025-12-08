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

module purge
module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
  bigwigs/INO80E-DMSO-P300.merged.RPGC.bw bigwigs/INO80E-CCS-P300.merged.RPGC.bw \
  bigwigs/INO80E-DMSO-INO80.merged.RPGC.bw bigwigs/INO80E-CCS-INO80.merged.RPGC.bw \
  bigwigs/INO80E-DMSO-HA.merged.RPGC.bw bigwigs/INO80E-CCS-HA.merged.RPGC.bw \
  -R bed_files/INO80E-DMSO-P300_INO80_HA_peak_autoDedup_promoters.bed \
  bed_files/INO80E-DMSO-P300_INO80_ONLY_peak_autoDedup_promoters.bed \
  bed_files/INO80E-DMSO-P300_peak_autoDedup_promoters.bed \
  -a 3000 -b 3000 -o results/DTmatrix_3marks_3barplotlists_promoters.gz

plotHeatmap -m results/DTmatrix_3marks_3barplotlists_promoters.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel INO80E-DMSO-P300 INO80E-CCS-P300 INO80E-DMSO-INO80 \
  INO80E-CCS-INO80 INO80E-DMSO-HA INO80E-CCS-HA \
  --colorMap Greens Greens Oranges Oranges Purples Purples \
  --regionsLabel "P300_INO80_HA promoter peaks" \
  "P300_INO80_ONLY promoter peaks" "P300 promoter peaks" \
  -o plots/Heatmap_3marks_3barplotlists_promoters.pdf \
  --plotTitle "bar groups promoter peaks, 1 sorted"

plotProfile -m results/DTmatrix_3marks_3barplotlists_promoters.gz \
  -out plots/Profile_3marks_3barplotlists_promoters.pdf \
  --samplesLabel INO80E-DMSO-P300 INO80E-CCS-P300 INO80E-DMSO-INO80 \
  INO80E-CCS-INO80 INO80E-DMSO-HA INO80E-CCS-HA \
  --regionsLabel "P300_INO80_HA promoter peaks" \
  "P300_INO80_ONLY promoter peaks" "P300 promoter peaks" \
  --plotTitle "bar groups promoter peaks" \
  --perGroup 
