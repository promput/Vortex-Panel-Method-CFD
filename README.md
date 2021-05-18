# Vortex-Panel-Method-CFD (protoype)
In this project I have utilize vortex panel, Thwaites, and Statford Method to create a computational fluid dynamic model over any 2 dimensional airfoil. This project is part of my ME163 aerodynamic project at UC Berkeley. This project is able to find the following.
1. separation points and stagnation points in an arbitrary airfoil.
2. Cp, Cl, and Cd graph.
3. numerical stall angle.

### To Run
There are 4 example_project.mat files above that show different functionality of the project.
1. Copied the code from the example file or preferable new code.
2. Place the file in the functions directory.
3. Run the file.

### Output:
There are two project report of the result graph file as report1.pdf and report2.pdf.

### Functions Explanations:
In the directory called "functions", there are more multiple Matlab functions present. They can be categorized as followed.
1. airfoil_.m and make_.m: the function that starts with this prefix is an airfoil generators.
2. math_. and tool_.m: the function that starts with this prefix is mathematical and iterative operations.
3. method_.m: the function that starts with this prefix is the theoretical method and procedures of finding the result.
4. plot_.m: the function that starts with this prefix create representation of the output on Matlab plot.