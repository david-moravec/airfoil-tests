#!/bin/bash


rho=1.2
nu=0.0001547
Ux=77.36
Uy=0
p=101325
U=$(echo "sqrt(${Ux}^2 + ${Uy}^2)" | bc -l |  awk '{printf("%.8f", $1);}')

fold="../airfoil-test/postProcessing/surfaces/1/p_wall.raw"

while read line; do
	((n++))
    
    terms=( $(sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^\2\3)/g' <<<"$line") )
    Cp[$n]=$(echo "(${terms[1]} - $p)/($U*$U * 0.5)" | bc -l | awk '{printf("%.8f", $1);}')
	echo "${terms[0]} ${Cp[$n]}"
done < <(grep '^[0-9].*' "${fold}" | awk '{print $1, $4}')

#while read line; do
	#((i++))
	#Rex=$(echo "$line * $U/$nu" | bc -l | awk '{printf("%7.f", $1);}')
#done < <(grep '^[0-9].*' "${fold}" | awk '{print $1}')
