# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.23

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.23.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.23.2/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/charlie/Projects/TRAB/NeuralNetwork-IA

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/charlie/Projects/TRAB/NeuralNetwork-IA/build

# Include any dependencies generated for this target.
include CMakeFiles/neuron.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/neuron.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/neuron.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/neuron.dir/flags.make

CMakeFiles/neuron.dir/main.cpp.o: CMakeFiles/neuron.dir/flags.make
CMakeFiles/neuron.dir/main.cpp.o: ../main.cpp
CMakeFiles/neuron.dir/main.cpp.o: CMakeFiles/neuron.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/charlie/Projects/TRAB/NeuralNetwork-IA/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/neuron.dir/main.cpp.o"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/neuron.dir/main.cpp.o -MF CMakeFiles/neuron.dir/main.cpp.o.d -o CMakeFiles/neuron.dir/main.cpp.o -c /Users/charlie/Projects/TRAB/NeuralNetwork-IA/main.cpp

CMakeFiles/neuron.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/neuron.dir/main.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/charlie/Projects/TRAB/NeuralNetwork-IA/main.cpp > CMakeFiles/neuron.dir/main.cpp.i

CMakeFiles/neuron.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/neuron.dir/main.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/charlie/Projects/TRAB/NeuralNetwork-IA/main.cpp -o CMakeFiles/neuron.dir/main.cpp.s

CMakeFiles/neuron.dir/src/Matrix.cpp.o: CMakeFiles/neuron.dir/flags.make
CMakeFiles/neuron.dir/src/Matrix.cpp.o: ../src/Matrix.cpp
CMakeFiles/neuron.dir/src/Matrix.cpp.o: CMakeFiles/neuron.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/charlie/Projects/TRAB/NeuralNetwork-IA/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/neuron.dir/src/Matrix.cpp.o"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/neuron.dir/src/Matrix.cpp.o -MF CMakeFiles/neuron.dir/src/Matrix.cpp.o.d -o CMakeFiles/neuron.dir/src/Matrix.cpp.o -c /Users/charlie/Projects/TRAB/NeuralNetwork-IA/src/Matrix.cpp

CMakeFiles/neuron.dir/src/Matrix.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/neuron.dir/src/Matrix.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/charlie/Projects/TRAB/NeuralNetwork-IA/src/Matrix.cpp > CMakeFiles/neuron.dir/src/Matrix.cpp.i

CMakeFiles/neuron.dir/src/Matrix.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/neuron.dir/src/Matrix.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/charlie/Projects/TRAB/NeuralNetwork-IA/src/Matrix.cpp -o CMakeFiles/neuron.dir/src/Matrix.cpp.s

CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.o: CMakeFiles/neuron.dir/flags.make
CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.o: ../src/NeuralNetwork.cpp
CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.o: CMakeFiles/neuron.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/charlie/Projects/TRAB/NeuralNetwork-IA/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.o"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.o -MF CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.o.d -o CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.o -c /Users/charlie/Projects/TRAB/NeuralNetwork-IA/src/NeuralNetwork.cpp

CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/charlie/Projects/TRAB/NeuralNetwork-IA/src/NeuralNetwork.cpp > CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.i

CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/charlie/Projects/TRAB/NeuralNetwork-IA/src/NeuralNetwork.cpp -o CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.s

# Object files for target neuron
neuron_OBJECTS = \
"CMakeFiles/neuron.dir/main.cpp.o" \
"CMakeFiles/neuron.dir/src/Matrix.cpp.o" \
"CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.o"

# External object files for target neuron
neuron_EXTERNAL_OBJECTS =

neuron: CMakeFiles/neuron.dir/main.cpp.o
neuron: CMakeFiles/neuron.dir/src/Matrix.cpp.o
neuron: CMakeFiles/neuron.dir/src/NeuralNetwork.cpp.o
neuron: CMakeFiles/neuron.dir/build.make
neuron: CMakeFiles/neuron.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/charlie/Projects/TRAB/NeuralNetwork-IA/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable neuron"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/neuron.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/neuron.dir/build: neuron
.PHONY : CMakeFiles/neuron.dir/build

CMakeFiles/neuron.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/neuron.dir/cmake_clean.cmake
.PHONY : CMakeFiles/neuron.dir/clean

CMakeFiles/neuron.dir/depend:
	cd /Users/charlie/Projects/TRAB/NeuralNetwork-IA/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/charlie/Projects/TRAB/NeuralNetwork-IA /Users/charlie/Projects/TRAB/NeuralNetwork-IA /Users/charlie/Projects/TRAB/NeuralNetwork-IA/build /Users/charlie/Projects/TRAB/NeuralNetwork-IA/build /Users/charlie/Projects/TRAB/NeuralNetwork-IA/build/CMakeFiles/neuron.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/neuron.dir/depend
