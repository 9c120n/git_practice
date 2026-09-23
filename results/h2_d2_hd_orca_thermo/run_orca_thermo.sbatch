#!/bin/bash
#SBATCH --job-name=h2d2hd-thermo
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=32core_partition
#SBATCH --time=01:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
# maestro: raw
set -euo pipefail
module load orca/v6.0.1
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
for molecule in h2 d2 hd; do
  /appl/share/orca_6_0_1_linux_x86-64_shared_openmpi416/orca "${molecule}.inp" > "${molecule}.out"
done
