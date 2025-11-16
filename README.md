![FELBuilder Logo](https://raw.githubusercontent.com/AtharvaTilewale/AtharvaTilewale/refs/heads/main/assets/images/felbuilder/logo/felbuilder_logo_whitebg_2k.png)

# FELBuilder: PCA + Free Energy Landscape (FEL) Analysis Pipeline

FELBuilder is an automated Python tool designed to simplify and streamline Principal Component Analysis (PCA) and Free Energy Landscape (FEL) analysis from Molecular Dynamics (MD) trajectories.  

It wraps GROMACS analysis commands into a single, user-friendly command-line interface (`felbuilder`), taking you from raw simulation files to publication-quality 2D and 3D FEL plots with a single command.

---

## Key Features

- **Single-Command Execution**: Runs the complete PCA–FEL workflow with one command.  
- **Automated Indexing**: Automatically generates a GROMACS index file for Protein + Ligand (using the `-g` flag).  
- **Organized Output**: Consolidates all generated files into a single `FEL_output` directory.  
- **Publication-Quality Plots**: Produces high-quality 2D contour and 3D surface plots using Matplotlib.  
- **Smart Plot-Only Mode**: Optionally skips analysis steps to plot directly from a `.dat` file.  
- **User-Friendly Interface**: Colorful CLI, detailed help menu, and robust error handling for GROMACS operations.  

---

## Requirements

- **GROMACS** ≥ 2021 (must be available in your system `PATH` as `gmx`)  
- **Python** 3.x  
- Required Python packages: `click`, `numpy`, `matplotlib`, `scipy`, `pyarmor`

---

## Installation

1. **Clone the repository**
```bash
git clone https://github.com/AtharvaTilewale/FELBuilder.git
```

2. **Navigate into the directory**
```bash
cd FELBuilder
```


3. **Run the installation script (requires sudo)**
```bash
sudo bash install.sh
```


This script:
- Copies files to `/usr/local/lib/felbuilder`
- Creates a symbolic link to `/usr/local/bin/felbuilder`
- Installs required Python packages system-wide  

After installation, `felbuilder` can be executed from any directory.

---

## Usage

```bash
felbuilder [OPTIONS]
```


### Command-Line Arguments

| Argument | Short | Description | Default |
|-----------|-------|-------------|----------|
| `--structure` | `-s` | Structure file (.pdb, .gro, or .tpr) used as input to GROMACS | Required |
| `--trajectory` | `-f` | Trajectory file (.xtc) from MD simulation | Required |
| `--lsq-group` | `-l` | Least squares fitting group (e.g., Protein, C-alpha, Backbone) | Protein |
| `--cov-group` | `-c` | Covariance group for analysis (e.g., Backbone, C-alpha, MainChain) | Backbone |
| `--lig` | `-g` | Ligand group name (e.g., LIG, ATP) to include in analysis | None |
| `--plot-only` | `-p` | Plot-only mode (skips analysis steps) | False |
| `--dat-file` | `-d` | FEL `.dat` file for plotting or saving | `free_energy.dat` |
| `--help` | `-h` | Show help message and exit | - |

---

## Examples

### 1. Basic PCA and FEL Analysis
Run the full pipeline using default groups:

```bash
felbuilder -s topology.pdb -f traj.xtc
```


### 2. Using Custom GROMACS Groups
Specify custom groups for fitting and covariance:

```bash
felbuilder -s topology.pdb -f traj.xtc -l "C-alpha" -c "Backbone"
```


### 3. Including a Ligand in the Analysis
Combine protein and ligand groups automatically:

```bash
felbuilder -s complex.pdb -f traj.xtc -l Protein -c Backbone -g LIG
```


### 4. Plot Only from Existing Data
Generate plots directly from an existing `.dat` file:

```bash
felbuilder -p -d free_energy.dat
```

If the specified `.dat` file is missing, FELBuilder interactively prompts to generate it.

---

## Output

All files are saved in a new `FEL_output` directory.

| File | Description |
|------|--------------|
| `FEL.png` | Final 2D/3D Free Energy Landscape plot |
| `free_energy.dat` | Data file (columns: PC1, PC2, Energy) used for plotting |
| `index.ndx` | GROMACS index file (if ligand option used) |
| (various `.xvg`, `.xpm`, `.trr`, `.pdb`) | Intermediate GROMACS files from PCA and FEL analysis |

---

## Citation

If you use this tool in your research, please cite the repository and acknowledge the FELBuilder pipeline in your methods section.

---

## License

This project is released under the MIT License. See [LICENSE](LICENSE) for details.

---
