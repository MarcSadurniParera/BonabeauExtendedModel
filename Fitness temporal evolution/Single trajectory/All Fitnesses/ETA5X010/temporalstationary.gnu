reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "5-010-L25-s.pdf"

unset title
set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 j}}" font "cmr10, 18" offset 0, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
unset key
set yrange [:]
set xrange [0:52000]
set lmargin 10
set ytics font ", 19"
set xtics 0, 10000, 50000 font ", 19"
set size ratio 0.7
set format x "%.1t·10^{%T}"
set xtics add ("0" 0)

plot for [col=2:51] 'fitness2.dat' i 0 using 1:col with lines lw 2