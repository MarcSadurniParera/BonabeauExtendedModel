##################################################################################

reset
set term pdfcairo enhanced dashed size 6,5
set encoding utf8
set termoption enhanced
set output "FiMaxNt.pdf"

set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  A}_{/*1.4 max} \\& {/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 max}}" font "cmr10, 18" offset -1, 0
set xlabel "{{/*1.6 {/cmmi10 N}}_{/*1.4 T}} " font "cmr10, 18" offset 0, -1

unset key
set yrange [:]
set xrange[:1100]
set lmargin 11
set bmargin 5
set ytics font ", 19"
set xtics font ", 19"
set view equal xy

set style line 1 lc rgb 'black' pointtype 6 pointsize 1.1 #circles
set style line 2 lc rgb 'black' pointtype 7 pointsize 1.1
set style line 3 lc rgb 'red' pointtype 4 pointsize 1.1 #square
set style line 4 lc rgb 'red' pointtype 5 pointsize 1.1
set style line 5 lc rgb 'blue' pointtype 8 pointsize 1.1 #uptriangle
set style line 6 lc rgb 'blue' pointtype 9 pointsize 1.1
set style line 7 lc rgb 'green' pointtype 10 pointsize 1.1 #downtriangle
set style line 8 lc rgb 'green' pointtype 11 pointsize 1.1
set style line 9 lc rgb 'yellow' pointtype 12 pointsize 1.1 #rhombus
set style line 10 lc rgb 'yellow' pointtype 13 pointsize 1.1
set style line 11 lc rgb 'purple' pointtype 14 pointsize 1.1 #pentagon
set style line 12 lc rgb 'purple' pointtype 15 pointsize 1.1

plot "ETA5.dat" u 1:($9/$3) w p ls 2 t"{/*1.1 {/Symbol h} =5}", "ETA3.dat" u 1:($9/$3) w p ls 4 t"{/*1.1 {/Symbol h} =3}", "ETA10.dat" u 1:($9/$3) w p ls 6 t"{/*1.1 {/Symbol h} =10}", "ETA7.dat" u 1:($9/$3) w p ls 12 t"{/*1.1 {/Symbol h} =10}"

##################################################################################

reset
set term pdfcairo enhanced dashed size 6,5
set encoding utf8
set termoption enhanced
set output "FiMaxSumFiNi.pdf"

set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  A}_{/*1.4 max}/{/*1.6 {/cmmi10 F}}@^{/*1.4  A}_{/*1.4 tot} \\& {/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 max}/{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 tot}}" font "cmr10, 18" offset -1, 0
set xlabel "{{/*1.6 {/cmmi10 N}}_{/*1.4 A} \\& {/*1.6 {/cmmi10 N}}_{/*1.4 B}} " font "cmr10, 18" offset 0, -1

unset key
set yrange [:]
set xrange[:1100]
set lmargin 11
set bmargin 5
set ytics font ", 19"
set xtics font ", 19"
set view equal xy

set style line 1 lc rgb 'black' pointtype 6 pointsize 1.1 #circles
set style line 2 lc rgb 'black' pointtype 7 pointsize 1.1
set style line 3 lc rgb 'red' pointtype 4 pointsize 1.1 #square
set style line 4 lc rgb 'red' pointtype 5 pointsize 1.1
set style line 5 lc rgb 'blue' pointtype 8 pointsize 1.1 #uptriangle
set style line 6 lc rgb 'blue' pointtype 9 pointsize 1.1
set style line 7 lc rgb 'green' pointtype 10 pointsize 1.1 #downtriangle
set style line 8 lc rgb 'green' pointtype 11 pointsize 1.1
set style line 9 lc rgb 'yellow' pointtype 12 pointsize 1.1 #rhombus
set style line 10 lc rgb 'yellow' pointtype 13 pointsize 1.1
set style line 11 lc rgb 'purple' pointtype 14 pointsize 1.1 #pentagon
set style line 12 lc rgb 'purple' pointtype 15 pointsize 1.1

plot "ETA5.dat" u 2:($9/$6) w p ls 2 t"{/*1.1 {/Symbol h}=5}", "ETA3.dat" u 2:($9/$6) w p ls 4 t"{/*1.1 {/Symbol h}=3}", "ETA10.dat" u 2:($9/$6) w p ls 6 t"{/*1.1 {/Symbol h}=10}", "ETA7.dat" u 2:($9/$6) w p ls 12 t"{/*1.1 {/Symbol h}=10}"