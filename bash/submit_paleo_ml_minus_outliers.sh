#!/bin/bash
#SBATCH --partition=regular
#SBATCH --array=1-45
#SBATCH --time=2-23:55:00
#SBATCH --mem=1000
#SBATCH --cpus-per-task=6
#SBATCH --job-name=paleo_ml_minus_outliers
#SBATCH --output=logs/%x-%j-array-%a.log
# islandpaleoarea: Paleo-Area Influence on Island Evolutionary Models
# Copyright (C) 2022 Pedro Santos Neves
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# Example job using defaults
# sbatch islandpaleoarea/bash/submit_paleo_ml.sh 1
# Example job using non-default arguments
# sbatch islandpaleoarea/bas/submit_paleo_ml.sh 1 lsoda simplex

mkdir -p logs
ml R

array_index=$SLURM_ARRAY_TASK_ID
time_slice=$1
methode=${2-lsodes}
optimmethod=${3-subplex}

Rscript --vanilla islandpaleoarea/scripts/paleo_ml_minus_outliers.R ${array_index} \
${time_slice} \
${methode} \
${optimmethod}
