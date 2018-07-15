GOAT based Implementation of quantum gates in Spin systems

email : bilalriaz at live dot com

Gradients are computed analytically, whereas Hessians are approximated using MATLAB's built-in (fminunc) BFGS type optimization .

Structure of Code is described below:

1. main.m is the main script, which initilizes global stucture self, which holds all the variables of optimization, it acts as base for all the calculations carried out in the optimization process.

2. Evolution.m is the vectorized dynamical evolution of system and dynamical gradients, which solved using Runge-Kutta type integrator, it is invoked from Computations.m

3. Computations.m converts vectorized evolution to matrices and returns unitary evolution operator along with its derivatives with respect to control parameters.

4. Cost.m uses outputs from computations.m to compute infidelity and gradients

5. outfun.m is ouput function to store infidelity and state.

5. Remaining functions are used to plot and analyze results.

Here is flowchart of our implementation:

![](https://github.com/Bilal092/GOAT-QuantumControl/blob/master/GOAT.JPG)

This implementation is inspired from:

https://link.aps.org/doi/10.1103/PhysRevLett.120.150401
