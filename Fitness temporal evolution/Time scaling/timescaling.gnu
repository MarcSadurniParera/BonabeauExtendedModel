reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "timescaling.pdf"

set ylabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset -2, 0
set xlabel "{/*1.6 {/cmmi10 L}}" font "cmr10, 18" offset 0, 0
unset key
set yrange [:]
set xrange [:]
set lmargin 14
set bmargin 1
set tmargin 0
set ytics font ", 19"
set xtics font ", 19"
set size ratio 0.7
set format y "%.1t·10^{%T}"
set ytics add ("0" 0)

set style line 1 lc rgb 'black' pointtype 7 pointsize 1.2
set style line 2 lc rgb 'black' lt 7 lw 2

g(x)=a*x**(b)
a=39
b=1
FIT_LIMIT = 1e-6
fit g(x) "MonopTime.dat" u 1:2 via a,b

plot "MonopTime.dat" u 1:2 w p ls 1 t "{/*1.1 Numerical values}", g(x) ls 2 t"{/*1.1 Power-law Fit}"