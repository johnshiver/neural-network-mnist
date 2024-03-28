#!/bin/zsh

ENV_NAME="neural-networks-mnist"
ENV_FILE="environment.yml"

# Function to initialize Conda in the script environment
initialize_conda() {
    __conda_setup="$('/Users/jshiver/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/jshiver/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/jshiver/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/jshiver/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
}

# Function to create a new Conda environment
create_env() {
    echo "Creating environment '$ENV_NAME' from '$ENV_FILE'..."
    conda env create -n "$ENV_NAME" -f "$ENV_FILE"
}

# Function to activate a Conda environment
activate_env() {
    echo "Activating environment '$ENV_NAME'..."
    conda activate "$ENV_NAME"
}

# Function to deactivate a Conda environment
deactivate_env() {
    echo "Deactivating environment '$ENV_NAME'..."
    conda deactivate
}

# Function to update a Conda environment with dependencies
update_deps() {
    echo "Updating environment '$ENV_NAME' with dependencies from '$ENV_FILE'..."
    conda env update -n "$ENV_NAME" -f "$ENV_FILE"
}

# Display usage information
usage() {
    echo "Usage: $0 [-c | -a | -u]"
    echo "  -c  Create the Conda environment"
    echo "  -a  Activate the Conda environment"
    echo "  -d  Deactivate the Conda environment"
    echo "  -u  Update the Conda environment"
    exit 1
}

# Ensure that we have the required commands
if [ $# -eq 0 ]; then
    usage
fi

initialize_conda

while getopts ":cadu" opt; do
    case ${opt} in
        c )
            create_env
            ;;
        a )
            activate_env
            ;;
        d )
            deactivate_env 
            ;;
        u )
            update_deps
            ;;
        \? )
            usage
            ;;
    esac
done
