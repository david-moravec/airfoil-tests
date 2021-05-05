#!/bin/bash
file=$1
echo $file

declare -a patchNames=(front back outlet_up outlet_down airfoil inlet temp1 temp2)

for i in {2..9}; do
	sed -i "s/b${i}.*/${patchNames[i-2]}/g" ${file}
	if (( $i == 9 )) ; then
		sed -i "s/defaultFaces/${patchNames[i-2]}/g" ${file}
	fi
done

sed -i ':a;N;$!ba;s/patch/empty/1' ${file}
sed -i ':a;N;$!ba;s/patch/empty/2' ${file}
sed -i ':a;N;$!ba;s/patch/wall/7' ${file}
