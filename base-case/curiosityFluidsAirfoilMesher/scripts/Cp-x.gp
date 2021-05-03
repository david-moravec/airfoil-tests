set terminal png
set title "NACA 0012"
set output "../airfoil-test/Cp-x.png"

set xlabel "x"
set ylabel "Cp" offset 2
set xrange [-0.1:1.1]
set yrange [1.4:-0.4]
set grid

set key right


plot "../airfoil-test/Cp-x.dat" with points pt 7 ps 1 lt rgb "red" title "pressureCoefficient"
