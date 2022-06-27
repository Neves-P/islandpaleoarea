#!/bin/bash
#SBATCH --partition=gelifes
#SBATCH --array=1-420
#SBATCH --time=48:00:00
#SBATCH --mem=1000


ml R

array_index=$SLURM_ARRAY_TASK_ID
time_slice=$1
methode=$2
optimmethod=$3

Rscript --vanilla scripts/paleo_ml.R ${array_index} \
                                     ${time_slice} \
                                     ${methode} \
                                     ${optimmethod}
