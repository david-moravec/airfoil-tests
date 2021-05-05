#!/bin/bash
read -p "Name of turbulence model: " turbModel
read -p "name of folder to save setup: " resultFold

./Allclean.sh 

cd ./airfoil-test

cp 0/U.org 0/U

#potentialFoam > log.potentialFoam
simpleFoam > log.simpleFoam &
SIMPLEfOAM_PID=$!
sleep 5
gnuplot residuals.gp &
GNUPLOT_PID=$!

while pgrep -x "simpleFoam" > /dev/null; do
    :
done
kill $GNUPLOT_PID
simpleFoam -postProcess -func wallShearStress
postProcess -func surfaces


../scripts/compute-Cf-x.sh > Cf-x.dat
../scripts/compute-Cp-x.sh > Cp-x.dat

cd ../scripts

gnuplot -e "turbModel='${turbModel}'" Cf-x.gp 
gnuplot -e "turbModel='${turbModel}'" Cp-x.gp 

cd ../

mkdir "${resultFold}"

cp "./airfoil-test/Cf-x.png" "${resultFold}/Cf-x.png"
cp "./airfoil-test//Cf-x.dat" "${resultFold}/Cf-x.dat"
cp "./airfoil-test/Cp-x.png" "${resultFold}/Cp-x.png"
cp "./airfoil-test//Cp-x.dat" "${resultFold}/Cp-x.dat"
cp -r ./airfoil-test/1 ${resultFold}
cp -r ./airfoil-test/system ${resultFold}
cp -r ./airfoil-test/constant ${resultFold}
cp -r ./airfoil-test/0 ${resultFold}

cd ../
killall gnuplot

echo "DONE!!!"
