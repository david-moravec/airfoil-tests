#!/bin/bash


./p3d2gmsh.py -m ${1}nmf ${1}p3dfmt
gmshToFoam ${1}msh
./renamePatches.sh constant/polyMesh/boundary
stitchMesh temp1 temp2
for file in 0/* ; do
	./renamePatches.sh ${file}
done


