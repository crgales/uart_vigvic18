#Makefile for UVM Testbench
RTL= ../rtl/*
work= work #library name
SVTB1= ../tb/uart_top.sv
INC = +incdir+../tb +incdir+../test +incdir+../wb_agt
SVTB2 = ../test/uart_test_pkg.sv
COVOP = -coveropt 3 +cover=bcfs -nocoverfec 
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva

VSIMBATCH1= -c -do " log -r /* ;coverage save -onexit -assert -directive -cvg -codeAll mem_cov1;do exclusions.do;run -all; exit"
VSIMBATCH2= -c -do " log -r /* ;coverage save -onexit -assert -directive -cvg -codeAll mem_cov2;do exclusions.do;run -all; exit"
VSIMBATCH3= -c -do " log -r /* ;coverage save -onexit -assert -directive -cvg -codeAll mem_cov3;do exclusions.do;run -all; exit"
VSIMBATCH4= -c -do " log -r /* ;coverage save -onexit -assert -directive -cvg -codeAll mem_cov4;do exclusions.do;run -all; exit"
VSIMBATCH5= -c -do " log -r /* ;coverage save -onexit -assert -directive -cvg -codeAll mem_cov5;do exclusions.do;run -all; exit"
VSIMBATCH6= -c -do " log -r /* ;coverage save -onexit -assert -directive -cvg -codeAll mem_cov6;do exclusions.do;run -all; exit"

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) $(COVOP)


run_test1:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1) -wlf wave_file1.wlf -l test1.log -sv_seed 1172447016 work.top +UVM_TESTNAME=TC1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test2:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2) -wlf wave_file2.wlf -l test2.log -sv_seed 3389243803 work.top +UVM_TESTNAME=TC2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

run_test3:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3) -wlf wave_file3.wlf -l test3.log -sv_seed random work.top +UVM_TESTNAME=TC3
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3

run_test4:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4) -wlf wave_file4.wlf -l test4.log -sv_seed random work.top +UVM_TESTNAME=TC4
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4

run_test5:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5) -wlf wave_file5.wlf -l test5.log -sv_seed random work.top +UVM_TESTNAME=TC5
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5

run_test6:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6) -wlf wave_file6.wlf -l test6.log -sv_seed random work.top +UVM_TESTNAME=TC6
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov6


report:
	vcover merge mem_cov   mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress: clean run_test1 run_test2 run_test3 report cov

cov:
	firefox covhtmlreport/index.html&

clean:
	rm -rf transcript* *log*  vsim.wlf fcover* covhtml* mem_cov* *.wlf modelsim.ini work *.vstf
	clear



