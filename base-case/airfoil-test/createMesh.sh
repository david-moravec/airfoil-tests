#!/bin/bash
rm -r ./naca0012.msh  0/uniform 0/meshPhi 0/U 0/wallShearStress

gunzip -d ${1}*.gz

./p3d2gmsh.py -o naca0012.msh -m ${1}*.nmf ${1}*.p3dfmt

cp ${1}naca0012.msh ./

gmshToFoam naca0012.msh

./renamePatches.sh constant/polyMesh/boundary

stitchMesh -overwrite temp1 temp2

#for file in 0/* ; do
#	./renamePatches.sh ${file}
#done


