#!/bin/bash


rho=1.2
nu=0.000015
Ux=77.36
Uy=0
U=$(echo "sqrt(${Ux}^2 + ${Uy}^2)" | bc -l |  awk '{printf("%.8f", $1);}')

fold="../airfoil-test/postProcessing/surfaces/1/wallShearStress_wall.raw"

while read line; do
	((n++))
    
    terms=( $(sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^\2\3)/g' <<<"$line") )
    magWSS=$(echo "sqrt(${terms[1]}^2 + ${terms[2]}^2 + ${terms[3]}^2)" | bc -l |  awk '{printf("%.8f", $1);}')
    #magWSS=${terms[1]}
	Cf[$n]=$(echo "$magWSS/(0.5 * $U*$U)" | bc -l | awk '{printf("%.8f", $1);}')
	echo "${terms[0]} ${Cf[$n]}"
done < <(grep '^[0-9].*' "${fold}" | awk '{print $1, $4, $5, $6}')

#while read line; do
	#((i++))
	#Rex=$(echo "$line * $U/$nu" | bc -l | awk '{printf("%7.f", $1);}')
#done < <(grep '^[0-9].*' "${fold}" | awk '{print $1}')
