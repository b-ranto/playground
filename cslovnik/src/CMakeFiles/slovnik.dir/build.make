# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/branto/Slovnik

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/branto/Slovnik

# Include any dependencies generated for this target.
include src/CMakeFiles/slovnik.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/slovnik.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/slovnik.dir/flags.make

src/CMakeFiles/slovnik.dir/main.c.o: src/CMakeFiles/slovnik.dir/flags.make
src/CMakeFiles/slovnik.dir/main.c.o: src/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/branto/Slovnik/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/CMakeFiles/slovnik.dir/main.c.o"
	cd /home/branto/Slovnik/src && /usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/slovnik.dir/main.c.o   -c /home/branto/Slovnik/src/main.c

src/CMakeFiles/slovnik.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/slovnik.dir/main.c.i"
	cd /home/branto/Slovnik/src && /usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/branto/Slovnik/src/main.c > CMakeFiles/slovnik.dir/main.c.i

src/CMakeFiles/slovnik.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/slovnik.dir/main.c.s"
	cd /home/branto/Slovnik/src && /usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/branto/Slovnik/src/main.c -o CMakeFiles/slovnik.dir/main.c.s

src/CMakeFiles/slovnik.dir/main.c.o.requires:

.PHONY : src/CMakeFiles/slovnik.dir/main.c.o.requires

src/CMakeFiles/slovnik.dir/main.c.o.provides: src/CMakeFiles/slovnik.dir/main.c.o.requires
	$(MAKE) -f src/CMakeFiles/slovnik.dir/build.make src/CMakeFiles/slovnik.dir/main.c.o.provides.build
.PHONY : src/CMakeFiles/slovnik.dir/main.c.o.provides

src/CMakeFiles/slovnik.dir/main.c.o.provides.build: src/CMakeFiles/slovnik.dir/main.c.o


# Object files for target slovnik
slovnik_OBJECTS = \
"CMakeFiles/slovnik.dir/main.c.o"

# External object files for target slovnik
slovnik_EXTERNAL_OBJECTS =

src/slovnik: src/CMakeFiles/slovnik.dir/main.c.o
src/slovnik: src/CMakeFiles/slovnik.dir/build.make
src/slovnik: src/CMakeFiles/slovnik.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/branto/Slovnik/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable slovnik"
	cd /home/branto/Slovnik/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/slovnik.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/slovnik.dir/build: src/slovnik

.PHONY : src/CMakeFiles/slovnik.dir/build

src/CMakeFiles/slovnik.dir/requires: src/CMakeFiles/slovnik.dir/main.c.o.requires

.PHONY : src/CMakeFiles/slovnik.dir/requires

src/CMakeFiles/slovnik.dir/clean:
	cd /home/branto/Slovnik/src && $(CMAKE_COMMAND) -P CMakeFiles/slovnik.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/slovnik.dir/clean

src/CMakeFiles/slovnik.dir/depend:
	cd /home/branto/Slovnik && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/branto/Slovnik /home/branto/Slovnik/src /home/branto/Slovnik /home/branto/Slovnik/src /home/branto/Slovnik/src/CMakeFiles/slovnik.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/slovnik.dir/depend

