set terminal png
set title "NACA 0012"
set output "../airfoil-test/Cf-x.png"

set xlabel "x"
set ylabel "Cf" offset 2
set grid

set key right


plot "../airfoil-test/Cf-x.dat" with linespoints pt 7 ps 0.1 lt rgb "red" title "skinFrictionCoefficient"
