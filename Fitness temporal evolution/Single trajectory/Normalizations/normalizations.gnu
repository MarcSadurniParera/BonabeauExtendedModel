reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "5-001-L25-Range.pdf"

#set title "L=25"
unset title
set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 j}}" font "cmr10, 18" offset 0, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
#set key b r
unset key
set yrange [:]
set xrange [0:3000]
set lmargin 10
#set rmargin 4
#set tmargin 0.5
#set bmargin 2
set ytics font ", 17"
set xtics font ", 17"
set size ratio 0.7

plot for [col=2:51] 'fitness2Range.dat' i 0 using 1:col with lines lw 2

########################################################################
########################################################################

reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "5-001-L25-Mean.pdf"

#set title "L=25"
unset title
set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 j}}" font "cmr10, 18" offset 0, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
#set key b r
unset key
set yrange [:]
set xrange [0:8000]
set lmargin 10
#set rmargin 4
#set tmargin 0.5
#set bmargin 2
set ytics font ", 17"
set xtics font ", 17"
set size ratio 0.7

plot for [col=2:51] 'fitness2Mean.dat' i 0 using 1:col with lines lw 2

########################################################################
########################################################################