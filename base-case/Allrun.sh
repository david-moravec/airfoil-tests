#!/bin/bash
read -p "Name of turbulence model: " turbModel

./Allclean.sh 

cd ./airfoil-test


simpleFoam > log.simpleFoam &
sleep 5
gnuplot residuals.gp &
GNUPLOT_PID=$!

while pgrep -x "simpleFoam" > /dev/null; do
    :
done
kill $GNUPLOT_PID


../scripts/compute-Cf-Rex.sh > Cf-x.dat

cd ../scripts

gnuplot -e "turbModel='${turbModel}'" saveResiduals.gp 
gnuplot -e "turbModel='${turbModel}'" Cf-x.gp 

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
done

echo "DONE!!!"
