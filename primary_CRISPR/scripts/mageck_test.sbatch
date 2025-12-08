#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --partition=prod_short
#SBATCH --mem-per-cpu=10G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/MAGECKtest%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="MAGECKtest"

module load mageck/0.5.9

sname=`basename $1 _counts.txt`

mageck test -k $1 -t $2 -c $3 -n mageck_results/sample${sname}_${2}_vs_$3 --pdf-report
