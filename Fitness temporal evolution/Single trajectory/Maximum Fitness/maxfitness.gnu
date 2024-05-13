reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "fmaxlog.pdf"

set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  A}_{/*1.4 max}}" font "cmr10, 18" offset 2, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
set key b r
#unset key
set yrange [:500]
set xrange [0:1600000]
set lmargin 8
set ytics font ", 19"
set xtics 0,250000,1500000 font ", 19"
set size ratio 0.7
set logscale y
set format x "%.1t·10^{%T}"
# Customize the major tics
set xtics add ("0" 0)
set key spacing 1.5

plot "fitnessagents.dat" i 0 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=25}", "" i 1 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=45}", "" i 2 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=65}", "" i 3 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=95}", "" i 4 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=120}"

########################################################################
########################################################################

reset
set term pdfcairo enhanced dashed size 6,4.5
set encoding utf8
set termoption enhanced
set output "f2maxlog.pdf"

set ylabel "{{/*1.6 {/cmmi10 F}}@^{/*1.4  B}_{/*1.4 max}}" font "cmr10, 18" offset 2, 0
set xlabel "{/*1.5 {/cmmi10 time}}" font ", 18" offset 0, -1
set key b r
#unset key
set yrange [:500]
set xrange [0:1600000]
set lmargin 8
set ytics font ", 19"
set xtics 0,250000,1500000 font ", 19"
set size ratio 0.7
set logscale y
set format x "%.1t·10^{%T}"
# Customize the major tics
set xtics add ("0" 0)
set key spacing 1.5

plot "fitnessagents2.dat" i 0 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=25}", "" i 1 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=45}", "" i 2 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=65}", "" i 3 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=95}", "" i 4 u 1:2 w l lw 1.5 t"{/*1.4 {/cmmi10 L}=120}"

########################################################################
########################################################################