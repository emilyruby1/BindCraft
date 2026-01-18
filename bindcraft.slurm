#!/bin/bash
#SBATCH --account=def-biozahed
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --mem=42gb
#SBATCH --time=72:00:00
#SBATCH --output=bindcraft_%A.log

# Initialize Conda environment
CONDA_BASE=$(conda info --base)
source ${CONDA_BASE}/bin/activate ${CONDA_BASE}/envs/BindCraft
export LD_LIBRARY_PATH=${CONDA_BASE}/lib

# Set paths to your JSON files
SETTINGS="/project/def-biozahed/emruby/BindCraft/settings_target/6Y5F.json"
FILTERS="/project/def-biozahed/emruby/BindCraft/settings_filters/relaxed_filters.json"
ADVANCED="/project/def-biozahed/emruby/BindCraft/settings_advanced/default_4stage_multimer.json"

# Get the directory of this script
SCRIPT_DIR=$(dirname "$0")

# Run BindCraft
echo "Running the BindCraft pipeline"
python -u "${SCRIPT_DIR}/bindcraft.py" --settings "${SETTINGS}" --filters "${FILTERS}" --advanced "${ADVANCED}"

