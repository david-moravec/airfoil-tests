#!/bin/bash
read -p "Name of turbulence model: " turbModel

./Allclean.sh 

cd ./airfoil-test

potentialFoam > log.potentialFoam
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

gnuplot -e "turbModel='${turbModel}'" saveResiduals.gp 
gnuplot -e "turbModel='${turbModel}'" Cf-x.gp 
gnuplot -e "turbModel='${turbModel}'" Cp-x.gp 

cd ../airfoil-test

resultFold="../results/Cf-x/"
if [ ! -d "${resultFold}" ] ; then 
    mkdir -p "${resultFold}"
    echo "creating folder"
fi

cp "./Cf-x.png" "${resultFold}/Cf-x.png"
cp "./Cf-x.png" "${resultFold}/../../Cf-x.png"
cp "./Cf-x.dat" "${resultFold}/data.dat"
cp "./residuals.png" "${resultFold}/../residuals.png"

cd ../
killall gnuplot

echo "DONE!!!"
