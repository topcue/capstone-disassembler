CC=gcc
CXX=g++
OBJ=linear_disassembler recursive_disassembler rop_gadget_finder

.PHONY: all clean

all: $(OBJ)

loader.o: ./include/loader.cpp
	$(CXX) -std=c++11 -c ./include/loader.cpp

linear_disassembler: loader.o linear_disassembler.cpp
	$(CXX) -std=c++11 -o linear_disassembler linear_disassembler.cpp loader.o -lbfd -lcapstone

recursive_disassembler: loader.o recursive_disassembler.cpp
	$(CXX) -std=c++11 -o recursive_disassembler recursive_disassembler.cpp loader.o -lbfd -lcapstone

rop_gadget_finder: loader.o rop_gadget_finder.cpp
	$(CXX) -std=c++11 -o rop_gadget_finder rop_gadget_finder.cpp loader.o -lbfd -lcapstone

clean:
	rm -f $(OBJ)
	rm -f *.o

