GPP = g++
GCC = gcc
OUTPUT = "bin/nefmod.so"
COMPILER_FLAGS = -std=c++0x -c -m32 -fPIC -O3 -DLINUX -w -I./include/ -I./include/SDK/amx/
LIBRARIES = -lrt

all: compile clean

compile:
	$(GCC) $(COMPILER_FLAGS) ./include/SDK/amx/*.c
	$(GPP) $(COMPILER_FLAGS) ./include/SDK/*.cpp
	$(GPP) $(COMPILER_FLAGS) ./src/*.cpp
	mkdir -p bin
	$(GPP) -m32 -O2 -fshort-wchar -shared -o $(OUTPUT) *.o $(LIBRARIES)
	
clean:
	rm -f *.o
