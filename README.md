Data and Code to reproduce the manuscript

# Emergence of social hierarchies in a society with two competitive groups

The manuscript is available at: https://doi.org/10.1016/j.chaos.2025.116660

## Abstract

Agent-based models describing social interactions among individuals can help to better understand 
emerging macroscopic patterns in societies. One of the topics which is worth tackling is the formation 
of different kinds of hierarchies that emerge in social spaces such as cities. Here we propose 
a Bonabeau-like model by adding a second group of agents. The fundamental particularity of our model 
is that only a pairwise interaction between agents of the opposite group is allowed. Agent fitness can 
thus only change by competition among the two groups, while the total fitness in the society remains 
constant. The main result is that for a broad range of values of the model parameters, the fitness of 
the agents of each group show a decay in time except for one or very few agents which capture almost 
all the fitness in the society. Numerical simulations also reveal a singular shift from egalitarian 
to hierarchical society for each group. This behaviour depends on the control parameter 𝜂, playing the 
role of the inverse of the temperature of the system. Results are invariant with regard to the system 
size, contingent solely on the quantity of agents within each group. Finally, scaling laws are provided 
thus showing a data collapse from different model parameters and they follow a shape which can be related 
to the presence of a phase transition in the model.

## Prerequisites

To run all the code and scripts for this paper, you will need to install:
- Fortran 90
- Gnuplot
- Python

## How to Use the Code

### Fortran 90
1. **Compilation:**
   - Open the terminal in the directory where the `.f90` files are located.
   - Compile the code using the following command:
     ```sh
     gfortran Name.f90 randomgenerator.f90 -o Name.exe
     ```
   - Example for this project:
     ```sh
     gfortran bonabeau_extended.f90 dranxor.f90 -o b.exe
     ```

2. **Execution:**
   - Run the executable by opening the terminal in the directory where the `.exe` file is located and typing:
     ```sh
     ./Name.exe
     ```
   - Example for this project:
     ```sh
     ./b.exe
     ```

### Gnuplot
- To generate most of the figures, run the Gnuplot scripts in the same directories where you have the generated `.dat` files from the Fortran 90 code.
  ```sh
  gnuplot Name.gnu
  ```
- Example for this project:
  ```sh
  gnuplot thermalizationfitness.gnu
  ```
### Python
1. **Installation:**
   - Install Jupyter Notebook if you haven't already:
     ```sh
     pip install notebook
     ```
   - Install the necessary Python packages by running:
     ```sh
     pip install -r requirements.txt
     ```
     (Ensure that you have a `requirements.txt` file listing all the necessary packages, or manually install the required packages as needed.)

2. **Running the Jupyter Notebook:**
   - Open Jupyter Notebook by running the following command in your terminal:
     ```sh
     jupyter notebook
     ```
   - Navigate to the directory containing the notebook file (`.ipynb`) and open it.
   - Execute the cells in the notebook to run the Python code and generate the required outputs.
