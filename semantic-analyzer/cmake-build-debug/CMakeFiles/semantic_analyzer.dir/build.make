# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

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
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/semantic_analyzer.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/semantic_analyzer.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/semantic_analyzer.dir/flags.make

CMakeFiles/semantic_analyzer.dir/ast.cc.o: CMakeFiles/semantic_analyzer.dir/flags.make
CMakeFiles/semantic_analyzer.dir/ast.cc.o: ../ast.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/semantic_analyzer.dir/ast.cc.o"
	/usr/local/bin/g++-8  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/semantic_analyzer.dir/ast.cc.o -c /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast.cc

CMakeFiles/semantic_analyzer.dir/ast.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/semantic_analyzer.dir/ast.cc.i"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast.cc > CMakeFiles/semantic_analyzer.dir/ast.cc.i

CMakeFiles/semantic_analyzer.dir/ast.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/semantic_analyzer.dir/ast.cc.s"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast.cc -o CMakeFiles/semantic_analyzer.dir/ast.cc.s

CMakeFiles/semantic_analyzer.dir/ast_decl.cc.o: CMakeFiles/semantic_analyzer.dir/flags.make
CMakeFiles/semantic_analyzer.dir/ast_decl.cc.o: ../ast_decl.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/semantic_analyzer.dir/ast_decl.cc.o"
	/usr/local/bin/g++-8  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/semantic_analyzer.dir/ast_decl.cc.o -c /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_decl.cc

CMakeFiles/semantic_analyzer.dir/ast_decl.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/semantic_analyzer.dir/ast_decl.cc.i"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_decl.cc > CMakeFiles/semantic_analyzer.dir/ast_decl.cc.i

CMakeFiles/semantic_analyzer.dir/ast_decl.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/semantic_analyzer.dir/ast_decl.cc.s"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_decl.cc -o CMakeFiles/semantic_analyzer.dir/ast_decl.cc.s

CMakeFiles/semantic_analyzer.dir/ast_expr.cc.o: CMakeFiles/semantic_analyzer.dir/flags.make
CMakeFiles/semantic_analyzer.dir/ast_expr.cc.o: ../ast_expr.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/semantic_analyzer.dir/ast_expr.cc.o"
	/usr/local/bin/g++-8  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/semantic_analyzer.dir/ast_expr.cc.o -c /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_expr.cc

CMakeFiles/semantic_analyzer.dir/ast_expr.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/semantic_analyzer.dir/ast_expr.cc.i"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_expr.cc > CMakeFiles/semantic_analyzer.dir/ast_expr.cc.i

CMakeFiles/semantic_analyzer.dir/ast_expr.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/semantic_analyzer.dir/ast_expr.cc.s"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_expr.cc -o CMakeFiles/semantic_analyzer.dir/ast_expr.cc.s

CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.o: CMakeFiles/semantic_analyzer.dir/flags.make
CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.o: ../ast_stmt.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.o"
	/usr/local/bin/g++-8  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.o -c /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_stmt.cc

CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.i"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_stmt.cc > CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.i

CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.s"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_stmt.cc -o CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.s

CMakeFiles/semantic_analyzer.dir/ast_type.cc.o: CMakeFiles/semantic_analyzer.dir/flags.make
CMakeFiles/semantic_analyzer.dir/ast_type.cc.o: ../ast_type.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/semantic_analyzer.dir/ast_type.cc.o"
	/usr/local/bin/g++-8  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/semantic_analyzer.dir/ast_type.cc.o -c /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_type.cc

CMakeFiles/semantic_analyzer.dir/ast_type.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/semantic_analyzer.dir/ast_type.cc.i"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_type.cc > CMakeFiles/semantic_analyzer.dir/ast_type.cc.i

CMakeFiles/semantic_analyzer.dir/ast_type.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/semantic_analyzer.dir/ast_type.cc.s"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/ast_type.cc -o CMakeFiles/semantic_analyzer.dir/ast_type.cc.s

CMakeFiles/semantic_analyzer.dir/errors.cc.o: CMakeFiles/semantic_analyzer.dir/flags.make
CMakeFiles/semantic_analyzer.dir/errors.cc.o: ../errors.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object CMakeFiles/semantic_analyzer.dir/errors.cc.o"
	/usr/local/bin/g++-8  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/semantic_analyzer.dir/errors.cc.o -c /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/errors.cc

CMakeFiles/semantic_analyzer.dir/errors.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/semantic_analyzer.dir/errors.cc.i"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/errors.cc > CMakeFiles/semantic_analyzer.dir/errors.cc.i

CMakeFiles/semantic_analyzer.dir/errors.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/semantic_analyzer.dir/errors.cc.s"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/errors.cc -o CMakeFiles/semantic_analyzer.dir/errors.cc.s

CMakeFiles/semantic_analyzer.dir/Scope.cc.o: CMakeFiles/semantic_analyzer.dir/flags.make
CMakeFiles/semantic_analyzer.dir/Scope.cc.o: ../Scope.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/semantic_analyzer.dir/Scope.cc.o"
	/usr/local/bin/g++-8  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/semantic_analyzer.dir/Scope.cc.o -c /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/Scope.cc

CMakeFiles/semantic_analyzer.dir/Scope.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/semantic_analyzer.dir/Scope.cc.i"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/Scope.cc > CMakeFiles/semantic_analyzer.dir/Scope.cc.i

CMakeFiles/semantic_analyzer.dir/Scope.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/semantic_analyzer.dir/Scope.cc.s"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/Scope.cc -o CMakeFiles/semantic_analyzer.dir/Scope.cc.s

CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.o: CMakeFiles/semantic_analyzer.dir/flags.make
CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.o: ../Symbol_table.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.o"
	/usr/local/bin/g++-8  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.o -c /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/Symbol_table.cc

CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.i"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/Symbol_table.cc > CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.i

CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.s"
	/usr/local/bin/g++-8 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/Symbol_table.cc -o CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.s

# Object files for target semantic_analyzer
semantic_analyzer_OBJECTS = \
"CMakeFiles/semantic_analyzer.dir/ast.cc.o" \
"CMakeFiles/semantic_analyzer.dir/ast_decl.cc.o" \
"CMakeFiles/semantic_analyzer.dir/ast_expr.cc.o" \
"CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.o" \
"CMakeFiles/semantic_analyzer.dir/ast_type.cc.o" \
"CMakeFiles/semantic_analyzer.dir/errors.cc.o" \
"CMakeFiles/semantic_analyzer.dir/Scope.cc.o" \
"CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.o"

# External object files for target semantic_analyzer
semantic_analyzer_EXTERNAL_OBJECTS =

semantic_analyzer: CMakeFiles/semantic_analyzer.dir/ast.cc.o
semantic_analyzer: CMakeFiles/semantic_analyzer.dir/ast_decl.cc.o
semantic_analyzer: CMakeFiles/semantic_analyzer.dir/ast_expr.cc.o
semantic_analyzer: CMakeFiles/semantic_analyzer.dir/ast_stmt.cc.o
semantic_analyzer: CMakeFiles/semantic_analyzer.dir/ast_type.cc.o
semantic_analyzer: CMakeFiles/semantic_analyzer.dir/errors.cc.o
semantic_analyzer: CMakeFiles/semantic_analyzer.dir/Scope.cc.o
semantic_analyzer: CMakeFiles/semantic_analyzer.dir/Symbol_table.cc.o
semantic_analyzer: CMakeFiles/semantic_analyzer.dir/build.make
semantic_analyzer: CMakeFiles/semantic_analyzer.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Linking CXX executable semantic_analyzer"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/semantic_analyzer.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/semantic_analyzer.dir/build: semantic_analyzer

.PHONY : CMakeFiles/semantic_analyzer.dir/build

CMakeFiles/semantic_analyzer.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/semantic_analyzer.dir/cmake_clean.cmake
.PHONY : CMakeFiles/semantic_analyzer.dir/clean

CMakeFiles/semantic_analyzer.dir/depend:
	cd /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug /Users/luis/Programming/C++/Decaf-Lang/semantic-analyzer/cmake-build-debug/CMakeFiles/semantic_analyzer.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/semantic_analyzer.dir/depend
