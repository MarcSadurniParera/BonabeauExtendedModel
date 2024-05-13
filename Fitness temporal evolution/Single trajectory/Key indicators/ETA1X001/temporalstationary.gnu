reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "1-001-L25-o.pdf"

unset title
set ylabel "{/*1.5 {/cmmi10 Fitness}}" font "cmr10, 18" offset 0, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
set key c r
unset key
set lmargin 11
set yrange [0:1000]
set xrange [:520000]
set ytics font ", 19"
set xtics 0, 100000, 500000 font ", 19"
set size ratio 0.7
set format x "%.0t·10^{%T}"
# Customize the major tics
set xtics add ("0" 0)

plot "fitnessagents.dat" i 0 u 1:2 w l lw 1.5 t"{/*1.4 f_{max}}", "" i 0 u 1:3 w l lw 1.5 t"{/*1.4 F_{max}}", "" i 0 u 1:4 w l lw 1.5 t"{/*1.4 {/Symbol S}_i f_i}", "" i 0 u 1:5 w l lw 1.5 t"{/*1.4 {/Symbol S}_j F_j}"