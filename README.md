# Emergence of social hierarchies in a society with two competitive classes

## Abstract
Agent based models describing social interactions among individuals can help to better understand
emerging macroscopic patterns in societies. One of the topics which is worth tackling is the formation
of different kinds of hierarchies that emerge in social spaces such as cities. Here we propose a
Bonabeau-like model by adding a second class of agents. The fundamental particularity of our model
is that only a pairwise interaction between agents of the opposite class is allowed. Agent fitness can
thus only change by competition among the two classes, while the total fitness in the society remains
constant. The main result is that for a broad range of values of the model parameters, the fitness of
the agents of each class show a decay in time except for one or very few agents which capture almost
all the fitness in the society. Numerical simulations also reveal a singular behaviour from egalitarian
to hierarchical society for each class. This behaviour depends on the control parameter 𝜂, playing the
role of the inverse of the temperature of the system. Results are invariant with regard to the system’s
size, contingent solely on the quantity of agents within each class. Finally, a couple of scaling laws
are provided thus showing a data collapse from different model parameters and they follow a shape
which can be related to the presence of a phase transition in the model.

### Prerequisites

Instal Fortran 90, Gnuplot and Python to Run all the Code and Scripts of this paper.

### How to use the code:

* Fortran90:
  * To compile, open the terminal at the route of the .f90 and write:
  ```sh
  gfortran Name.f90 randomgenerator.f90 -o Name.exe
  ```
  In our work: gfortran bonabeau_extended.f90 dranxor.f90 -o b.exe
  * To execute, open the terminal at the route of the .exe and write:
  ```sh
  name.exe
  ```
  In our work: b.exe  
* GnuPlot: to generate almost all the Figures, run the scripts on the same routes you will have the generated files.dat of the previous command in Fortran 90.
  ```sh
  gnuplot name.gnu
  ```
  Example: gnuplot thermalizationfitness.gnu
