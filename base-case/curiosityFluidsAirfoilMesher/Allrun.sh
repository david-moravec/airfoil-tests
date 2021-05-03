#!/bin/bash
./Allclean.sh


cd airfoil-test
cp 0/U.org 0/U

#potentialFoam > log.potentialFoam

decomposePar -force

mpirun -np 2 simpleFoam -parallel > log.simpleFoam &
SF_PID=$!
sleep 20
gnuplot residuals.gp &
GP_PID=$!

while ps -p $SF_PID > /dev/null; do
    :
done
kill $GP_PID


reconstructPar

cd ../

