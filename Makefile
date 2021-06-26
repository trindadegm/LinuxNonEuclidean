# MIT License
# 
# Copyright (c) 2018, 2019 Gustavo Moitinho Trindade
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Makefile for C/C++ projects

# The name of the executable
BinName := test

#--------------------
# Project settings
#--------------------

# The compiler to be used (default: gcc)
CC := g++

# Compiler flags (default: -Wall -g)
CCFlags := -Wall -g

# Libraries to be used
CCLibs := -lSDL2 -lGLEW -lGL -lGLU

# Source file extension (default: c)
SrcExt := cpp

# Header file extension (default: h)
HeaderExt := h

#--------------------
# Directory setup
#--------------------

# Directory of binary files (default: bin)
BinDir := bin

# Directory of included files (default: include)
IncludeDir := include

# Directory of source files (default: src)
SrcDir := src

# Directory of object files (default: build)
BuildDir := build

# Directory of library files (default: libs)
LibsDir := libs

# Directory for the creation of dependency files (default: deps)
DepsDir := deps

#--------------------
# Rules
#--------------------

# List source files (used only for input on next listing)
SrcFiles := $(shell find $(SrcDir) -type f -name "*.$(SrcExt)")

# Set that each source file must have an object, to use on main rule
ObjFiles := $(patsubst $(SrcDir)/%.$(SrcExt), $(BuildDir)/%.o, $(SrcFiles))

# Main rule, creating binary file
$(BinDir)/$(BinName): $(ObjFiles)
	@mkdir -p $(@D)
	$(CC) $(ObjFiles) $(CCFlags) $(CCLibs) -o $(BinDir)/$(BinName)  

# Rule to create objects
$(BuildDir)/%.o: $(SrcDir)/%.$(SrcExt) $(DepsDir)/%.d
	@mkdir -p $(@D)
	$(CC) $(CCFlags) -I $(IncludeDir) -c $< -o $@

# Do not delete this files
.PRECIOUS: $(DepsDir)/%.d
# Rule to create dependencies
$(DepsDir)/%.d: $(SrcDir)/%.$(SrcExt)
	@mkdir -p $(@D)
	$(CC) -MM -MF $@ -MT $@ -I $(IncludeDir) $<

-include $(patsubst $(BuildDir)/%.o, $(DepsDir)/%.d, $(ObjFiles))

# Helper rule
.PHONY: clean

# Removes created files and directories
clean:
	@echo "Cleaning..."
	-rm -rvf $(DepsDir) $(BinDir) $(BuildDir)
