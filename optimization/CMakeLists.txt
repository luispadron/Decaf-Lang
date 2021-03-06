cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_COMPILER "/usr/bin/clang")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++")
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS "-std=c++11 -DDEBUG=1 -g -Wall -Wno-unused -Werror -Wno-sign-compare")
set(FLEX_EXECUTABLE  /usr/local/opt/flex/bin/flex)
set(FLEX_INCLUDE_DIR /usr/local/opt/flex/include)
set(FL_LIBRARY  /usr/local/opt/flex/lib/libfl.dylib)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

include_directories(.)
include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(/usr/local/opt/flex/include)

bison_target(MyParser parser.y ${CMAKE_CURRENT_BINARY_DIR}/y.tab.cpp COMPILE_FLAGS "-vty")
flex_target(MyScanner scanner.l ${CMAKE_CURRENT_BINARY_DIR}/scanner.yy.cpp)

add_executable(opt
        ${BISON_MyParser_OUTPUTS}
        ${FLEX_MyScanner_OUTPUTS}
        ast.cc
        ast_program.cc
        ast_decl.cc
        ast_expr.cc
        ast_stmt.cc
        ast_type.cc
        errors.cc
        utility.cc
        mips.cc
        tac.cc
        codegen.cc
        main.cc
        ast_program.cc
        scope.cc
        adj_list.cc
        )

target_link_libraries(opt
        ${FLEX_LIBRARIES}
        ${BISON_LIBRARIES}
        )

