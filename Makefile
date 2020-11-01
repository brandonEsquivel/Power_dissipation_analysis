#Verilog

# Making verilog makefile
# Makefile to simulate Verilog HDL designs under GNU.
# an adaptation of the joint work with Belinda Brown. The best colleague of my career to date
# Brandon Esquivel Molina
# brandon.esquivel@ucr.ac.cr


# 	Makefile logic: this is a specific version of a very general makefile for synthesis, compilation and simulation.
# To create this file you need these files:   --banco_pruebas.v definiciones.v libreria.v sumador_logico.v sumador_rizado.v sumador_look.v

#if you feel lazy, just make all.



#******************************************************************************
#										TARGETS
#******************************************************************************
### 						YOSYS 		use $make	y<mark>
# To generate the structural design of the
# behavioral design automatically through synthesis
#It is defined as a roughly RTL (Register Transfer Level)
#synthesizer that allows you to convert the HDL (Hardware
# Description Language) code into an electronic scheme.
# Coming to show the components connected to each other what
# is usually called RTL network list which is associated with
# the level of registry transfer. Considering that what it allows
# is to model a synchronous digital circuit in terms of digital signal
# flow (this being data) relating it to the hardware registers and the
# logical operations that are carried out in each signal.

#### 					 IVERILOG 		use $make v<mark>
# It is defined as an HDL (Hardware Description Language),
#  this being a modeled hardware language, that is, it allows
#  describing a simulation of digital circuits. It can be seen
# as the tool that allows to provide the specifications to carry
# out a physical component which is being modeled.
# 	Example of command:
# iverilog -o ./vvp/TestBench_21_2.vvp ./TestBenchAUTONST/TestBench_21_2.v
# Its automatic, because each time you are asked for a vvp
# you need one with con.v

### 					GTKWAVE   		use $make gtkwave<mark>
# We can define it as a visualization of simulation results
# where one of its advantages is that by means of a visualization
# of signal waves we can understand the problem when it
# is found by using the testbench.

#******************************************************************************
# Modify this part with your own folders paths.

DIAGRAMS_GENERATED = ./diagrams_generated/

LIB = ./lib/

LOG = ./log/

SRC = ./src/
_LOGIC = sumador_logico.v
_LOOK = sumador_look.v
_RIPPLE = sumador_rizado.v
_DEF = definiciones.v

SYN = ./syn/

TESTBENCHES = ./testbenches/
_TB =  banco_pruebas.v

TESTERS = ./testers/

_VCD_TEST_ripple = Sumadores.vcd


OVVP = ./vvp/
_VVP_TEST = Sumadores.vvp



YOSYS = ./yosys/


#******************************************************************************

# # IVERILOG
# %.vvp: %.v
# 	iverilog -o $@ $^


#******************************************************************************
#### 						make the complete test
#******************************************************************************
#if you feel lazy, just make all.

All: 	clean cadders gtkwaveripple

## individual steps

cadders:
	iverilog -o $(OVVP)$(_VVP_TEST) $(TESTBENCHES)$(_TB)
	vvp $(OVVP)$(_VVP_TEST) > $(LOG)$(_VVP_TEST)_log.txt

#target phony
.PHONY: gtkwavetest

gtkwaveripple:
	gtkwave Sumadores.vcd ripple.gtkw




#******************************************************************************
# CLEAN  ALL
#******************************************************************************


.PHONY: clean
clean:
	rm -rf $(OVVP)*.vvp *.vcd $(LOG_TXT)*_log.txt $(SYN)*syn.v $(DIAGRAMS_GENERATED)*.dot $(DIAGRAMS_GENERATED)*.ps
