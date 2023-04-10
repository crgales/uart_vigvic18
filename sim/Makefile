#Makefile for UVM Testbench
RTL = ../rtl/*
TB = ../tb/top.sv

WB_AGT_PKG = ../wb_agt/wb_agt_pkg.sv ../wb_agt/wb_if.sv
WB_AGT_INC = +incdir+../wb_agt

UART_ENV_PKG = ../uart_env/uart_env_pkg.sv
UART_ENV_INC = +incdir+../uart_env

UART_TEST_PKG = ../uart_test/uart_test_pkg.sv
UART_TEST_INC = +incdir+../uart_test

COVOP = -coveropt 3 +cover=bcfs -nocoverfec 
VSIMCOV= -coverage -sva

TEST?=TC1

all: clean comp opt

comp:
	vlog $(RTL)
	vlog $(WB_AGT_PKG) $(WB_AGT_INC)
	vlog $(UART_ENV_PKG) $(UART_ENV_INC)
	vlog $(UART_TEST_PKG) $(UART_TEST_INC)
	vlog $(TB)

opt:
	vopt -o top_opt top +designfile -debug

sim:
	vsim -c top_opt -qwavedb=+signal +UVM_TESTNAME=$(TEST) -do "run -all; quit"

report:
	vcover merge 
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress: clean

cov:
	firefox covhtmlreport/index.html&

clean:
	rm -rf transcript* *log*  vsim.wlf fcover* covhtml* mem_cov* *.wlf modelsim.ini work *.vstf
	rm -rf design.bin qwave.db .visualizer
