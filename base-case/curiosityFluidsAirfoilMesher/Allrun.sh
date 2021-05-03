#!/bin/bash

decomposePar -force

mpirun -np 2 simpleFoam > log.simpleFoam

reconstructPar

simpleFoam -postProcess -func wallShearStress
simpleFoam -postProcess -func surfaces

./scripts/compute-Cp-x.sh > ./airfoil-test/Cp-x.dat
./scripts/compute-Cf-x.sh > ./airfoil-test/Cf-x.dat

cd scripts
gnuplot Cp-x.gp
gnuplot Cf-x.gp

