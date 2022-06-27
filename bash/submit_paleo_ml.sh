#!/bin/bash
#SBATCH --partition=gelifes
#SBATCH --array=1-420
#SBATCH --time=48:00:00
#SBATCH --mem=1000
#SBATCH --job-name=paleo_ml
#SBATCH --output=logs/%x-%j-array-%a.log

mkdir -p logs
ml R

array_index=$SLURM_ARRAY_TASK_ID
time_slice=$1
methode=${2-lsodes}
optimmethod=${3-subplex}

Rscript --vanilla islandpaleoarea/scripts/paleo_ml.R ${array_index} \
                                                     ${time_slice} \
                                                     ${methode} \
                                                     ${optimmethod}
