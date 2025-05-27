reset
set term pdfcairo enhanced dashed size 6,5
set encoding utf8
set termoption enhanced
set output "SumFi.pdf"

#set ylabel "{/*1.4 f_{total} \\& F_{total}}" font ", 18" offset -1, 0
#set xlabel "{/*1.4 {/Symbol h}}" font ", 18"

set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  A}_{/*1.4 tot} \\& {/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 tot}}" font "cmr10, 18" offset -1, 0
set xlabel "{/*1.5 {/Symbol h}}" font "cmr10, 18"

set key b r
unset key
set yrange [:]
set xrange[0:15]
set lmargin 11
set bmargin 4
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

set style line 13 lc rgb 'black' dt (4,3) lw 1.1
set style line 14 lc rgb 'black' lt 1 lw 1.1 

f(x)=(1+(500-1)*exp(-x))/(2+(550-2)*exp(-x))
g(x)=(1+(50-1)*exp(-x))/(2+(550-2)*exp(-x))

plot "50050a.dat" u 3:($5/$2) w p ls 1, "50050b.dat" u 3:($5/$2) w p ls 2, "350200a.dat" u 3:($5/$2) w p ls 3, "350200b.dat" u 3:($5/$2) w p ls 4, "52525a.dat" u 3:($5/$2) w p ls 11, "52525b.dat" u 3:($5/$2) w p ls 12, "12525a.dat" u 3:($5/$2) w p ls 7, "12525b.dat" u 3:($5/$2) w p ls 8, "25050a.dat" u 3:($5/$2) w p ls 9, "25050b.dat" u 3:($5/$2) w p ls 10, "505a.dat" u 3:($5/$2) w p ls 5, "505b.dat" u 3:($5/$2) w p ls 6, f(x) w l ls 13, g(x) w l ls 14

########################################################################################################

reset
set term pdfcairo enhanced dashed size 6,5
set encoding utf8
set termoption enhanced
set output "FiMaxSumFi.pdf"

#set ylabel "{/*1.4 f_{max}/{f_{total}} \\& F_{max}/{F_{total}}" font ", 18" offset -1, 0
#set xlabel "{/*1.4 {/Symbol h}}" font ", 18"
set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  A}_{/*1.4 max}/{/*1.6 {/cmmi10 F}}@^{/*1.4  A}_{/*1.4 tot} \\& {/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 max}/{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 tot}}" font "cmr10, 18" offset -1, 0
set xlabel "{/*1.5 {/cmmi10 {/Symbol h}}}" font ", 18"
set key b r
unset key
set yrange [:]
set xrange[0:15]
set lmargin 11
set bmargin 4
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

set style line 13 lc rgb 'black' dt (4,3) lw 1.1
set style line 14 lc rgb 'black' lt 1 lw 1.1 

h(x)= 1/(1+(500-1)*exp(-x))
i(x)= 1/(1+(50-1)*exp(-x))

plot "50050a.dat" u 3:($8/$5) w p ls 1, "50050b.dat" u 3:($8/$5) w p ls 2, "350200a.dat" u 3:($8/$5) w p ls 3, "350200b.dat" u 3:($8/$5) w p ls 4, "52525a.dat" u 3:($8/$5) w p ls 11, "52525b.dat" u 3:($8/$5) w p ls 12, "12525a.dat" u 3:($8/$5) w p ls 7, "12525b.dat" u 3:($8/$5) w p ls 8, "25050a.dat" u 3:($8/$5) w p ls 9, "25050b.dat" u 3:($8/$5) w p ls 10, "505a.dat" u 3:($8/$5) w p ls 5, "505b.dat" u 3:($8/$5) w p ls 6, h(x) w l ls 13, i(x) w l ls 14

########################################################################################################

reset
set term pdfcairo enhanced dashed size 6,5
set encoding utf8
set termoption enhanced
set output "FiMax.pdf"

#set ylabel "{/*1.4 f_{max} \\& F_{max}}" font ", 18" offset -1, 0
#set xlabel "{/*1.4 {/Symbol h}}" font ", 18"

set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  A}_{/*1.4 max} \\& {/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 max}}" font "cmr10, 18" offset -1, 0
set xlabel "{/*1.5 {/Symbol h}}" font "cmr10, 18"

set key b r
unset key
set yrange [:0.55]
set xrange[0:15]
set lmargin 11
set bmargin 4
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

set style line 13 lc rgb 'black' lt 1 lw 1.1

j(x)= 1/(2+(550-2)*exp(-x))

plot "50050a.dat" u 3:($8/$2) w p ls 1, "50050b.dat" u 3:($8/$2) w p ls 2, "350200a.dat" u 3:($8/$2) w p ls 3, "350200b.dat" u 3:($8/$2) w p ls 4, "52525a.dat" u 3:($8/$2) w p ls 11, "52525b.dat" u 3:($8/$2) w p ls 12, "12525a.dat" u 3:($8/$2) w p ls 7, "12525b.dat" u 3:($8/$2) w p ls 8, "25050a.dat" u 3:($8/$2) w p ls 9, "25050b.dat" u 3:($8/$2) w p ls 10, "505a.dat" u 3:($8/$2) w p ls 5, "505b.dat" u 3:($8/$2) w p ls 6, j(x) w l ls 13

########################################################################################################