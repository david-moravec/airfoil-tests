#!/bin/bash
file=$1
echo $file

declare -a patchNames=(symmetry_y symmetry_y outlet_up outlet_down airfoil inlet temp1 temp2)

for i in {2..9}; do
	sed -i "s/b${i}.*/${patchNames[i-2]}/g" ${file}
	if (( $i == 9 )) ; then
		sed -i "s/defaultFaces/${patchNames[i-2]}/g" ${file}
	fi
done
