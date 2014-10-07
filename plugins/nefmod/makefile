GPP = g++
GCC = gcc
OUTPUT = "bin/nefmod.so"
COMPILER_FLAGS = -std=gnu++11 -c -m32 -fPIC -g -DLINUX -w -I./include/ -I./include/SDK/amx/
LIBRARIES = -lrt

all: compile clean

compile:
	$(GCC) $(COMPILER_FLAGS) ./include/SDK/amx/*.c
	$(GPP) $(COMPILER_FLAGS) ./include/SDK/*.cpp
	$(GPP) $(COMPILER_FLAGS) ./src/*.cpp
	mkdir -p bin
	$(GPP) -m32 -g -fshort-wchar -shared -o $(OUTPUT) *.o $(LIBRARIES)
	
clean:
	rm -f *.o
