cmake_minimum_required(VERSION 3.13)
project(semantic_analyzer)

set(CMAKE_C_COMPILER "/usr/local/bin/gcc-8")
set(CMAKE_CXX_COMPILER "/usr/local/bin/g++-8")
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS "-std=c++11 -DDEBUG=1 -g -Wall -Wno-unused -Wno-sign-compare")
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

#add_flex_bison_dependency(MyParser MyScanner)

add_executable(semantic
        ${BISON_MyParser_OUTPUTS}
        ${FLEX_MyScanner_OUTPUTS}
        ast.cpp
        ast_program.cpp
        ast_decl.cpp
        ast_expr.cpp
        ast_stmt.cpp
        ast_type.cpp
        errors.cpp
        Scope.cpp
        Symbol_table.cpp
        utility.cpp
        main.cpp)

target_link_libraries(semantic
        ${FLEX_LIBRARIES}
        ${BISON_LIBRARIES}
)