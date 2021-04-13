set terminal png
set title "NACA 0012"
set output "../airfoil-test/Cp-x.png"

set xlabel "x"
set ylabel "Cp" offset 2
set grid

set key right


plot "../airfoil-test/Cp-x.dat" with linespoints pt 7 ps 0.1 lt rgb "red" title "pressureCoefficient"
