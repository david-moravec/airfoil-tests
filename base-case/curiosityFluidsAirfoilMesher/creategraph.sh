#!/bin/bash
cd ./scripts
./compute-Cp-x.sh > ../airfoil-test/Cp-x.dat
./compute-Cf-x.sh > ../airfoil-test/Cf-x.dat

gnuplot Cp-x.gp
gnuplot Cf-x.gp
