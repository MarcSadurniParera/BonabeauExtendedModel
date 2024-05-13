reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "5-001-L25.pdf"

unset title
set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 j}}" font "cmr10, 18" offset 0, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
unset key
set yrange [:]
set xrange [0:1100]
set lmargin 10
set ytics font ", 19"
set xtics 0,200,1000 font ", 19"
set size ratio 0.7

plot for [col=2:51] 'fitness2.dat' i 0 using 1:col with lines lw 2

########################################################################
########################################################################

reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "5-001-L25-s.pdf"

set multiplot

set origin 0,0
set size 1,1
set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 j}}" font "cmr10, 18" offset 0, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
set xrange[0:220000]
set yrange[:]
set lmargin 10
set ytics font ", 19"
set xtics 0, 50000, 200000 font ", 19"
set size ratio 0.7
set format x "%.1t·10^{%T}"
set xtics add ("0" 0)
unset key

plot for [col=2:51] 'fitness2.dat' i 0 using 1:col with lines

set origin 0.35, 0.15
set size 0.45, 0.4
set xrange [0:40000]
set yrange[0:2.5]
set xtics (0,20000,40000)
set xtics add ("0" 0)
unset xlabel
unset ylabel
set size ratio 0.7

replot

unset multiplot

##########################################################################

reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "5-001-L65-s.pdf"

set multiplot

set origin 0,0
set size 1,1
set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 j}}" font "cmr10, 18" offset -1, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
set xrange[0:520000]
set yrange[:]
set lmargin 11
set ytics font ", 19"
set xtics 0, 100000, 500000 font ", 19"
set size ratio 0.7
set format x "%.0t·10^{%T}"
set xtics add ("0" 0)
unset key

plot for [col=2:51] 'fitness2.dat' i 2 using 1:col with lines

set origin 0.40, 0.15
set size 0.45, 0.4
set xrange [0:60000]
set yrange[0:2.5]
set xtics (0,30000,60000)
set xtics add ("0" 0)
unset xlabel
unset ylabel
set size ratio 0.7

replot

unset multiplot

##########################################################################

reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "5-001-L120-s.pdf"

set multiplot

set origin 0,0
set size 1,1
set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 j}}" font "cmr10, 18" offset -1, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
set xrange[0:520000]
set yrange[:]
set lmargin 11
set ytics font ", 19"
set xtics 0, 100000, 500000 font ", 19"
set size ratio 0.7
set format x "%.0t·10^{%T}"
set xtics add ("0" 0)
unset key

plot for [col=2:51] 'fitness2.dat' i 4 using 1:col with lines

set origin 0.40, 0.15
set size 0.45, 0.4
set xrange [0:200000]
set yrange[0:2.5]
set xtics (0,100000,200000)
set xtics add ("0" 0)
unset xlabel
unset ylabel
set size ratio 0.7

replot

unset multiplot