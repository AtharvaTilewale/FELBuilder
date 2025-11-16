#!/usr/bin/env bash
set -e
PYTHON=${PYTHON:-python3}
# Install to a dedicated lib directory
LIB_DIR="/usr/local/lib/felbuilder"
# Symlink goes in /usr/local/bin
BIN_LINK="/usr/local/bin/felbuilder"

# List of all files AND directories needed for the script to run
# This now includes the pyarmor runtime directory
REQUIRED_ITEMS=(
    "fel_pca_cli.py"
    "gromacs_pipeline.py"
    "plot_fel.py"
    "xpm2dat.py"
    "requirements.txt"
    "pyarmor_runtime_000000"
)

usage() {
echo "Usage: $0"
echo "This script installs 'felbuilder' to $BIN_LINK and its libraries to $LIB_DIR."
echo "It requires sudo privileges."
exit 1
}
if [[ "$1" == "--help" ]]; then
usage
fi

echo "Checking for Python 3..."
if ! command -v $PYTHON &> /dev/null
then
    echo "$PYTHON could not be found. Please install Python 3."
    exit 1
fi

echo "Checking for pip..."
if ! $PYTHON -m pip --version &> /dev/null
then
    echo "pip for $PYTHON not found. Please install pip."
    exit 1
fi

echo "Installing FELBuilder CLI to $BIN_LINK (with libraries in $LIB_DIR)..."
echo "This will require sudo privileges."

# Check for all required files and directories before proceeding
for item in "${REQUIRED_ITEMS[@]}"; do
    # Use -e to check for existence (works for both files and directories)
    if [[ ! -e "$item" ]]; then
        echo "Error: Required item '$item' not found in current directory." >&2
        echo "If you have encrypted the files, make sure this script is run" >&2
        echo "from the directory containing the 'dist' folder created by PyArmor," >&2
        echo "or that all items are in the current directory." >&2
        exit 1
    fi
done

# Create the library directory
echo "Creating library directory $LIB_DIR..."
sudo mkdir -p "$LIB_DIR"

# Copy all files and directories
echo "Copying application files and runtime..."
# Use -r to recursively copy directories (like pyarmor_runtime_000000)
sudo cp -r "${REQUIRED_ITEMS[@]}" "$LIB_DIR/"

# Make the main script executable
sudo chmod +x "$LIB_DIR/fel_pca_cli.py"

# Create the symlink in /usr/local/bin
echo "Creating symlink at $BIN_LINK..."
sudo ln -sf "$LIB_DIR/fel_pca_cli.py" "$BIN_LINK"

# --- Install Python Dependencies ---
echo "Installing Python dependencies from requirements.txt..."
# We run pip as sudo to install the packages system-wide
sudo $PYTHON -m pip install -r "$LIB_DIR/requirements.txt"
# --- End Install ---

echo "✔ Installation complete."
echo "You can now run 'felbuilder' from any directory."