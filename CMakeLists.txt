cmake_minimum_required(VERSION 3.12)

set (INPUT_DEP_INCLUDE_DIR "/usr/local/include/input-dependency")
set (DG_INCLUDE_DIR "/usr/local/include/dg/")
set (INPUT_DEP_LIB_DIR "/usr/local/lib")
set (SELF_CHECKSUM_INCLUDE_DIR "/home/anahitik/SIP/self-checksumming/src")
set (SELF_CHECKSUM_LIB_DIR "/home/anahitik/SIP/self-checksumming/build/lib")
find_package(nlohmann_json 3.2.0 REQUIRED)

find_package(pdg)
find_package(LLVM REQUIRED CONFIG)
add_definitions(${LLVM_DEFINITIONS})

#include_directories(${LLVM_INCLUDE_DIRS})
#include_directories(${INPUT_DEP_INCLUDE_DIR})
#include_directories(${DG_INCLUDE_DIR})
#include_directories("${DG_INCLUDE_DIR}/llvm")
#include_directories("${DG_INCLUDE_DIR}/llvm/analysis")
#include_directories(${CMAKE_CURRENT_LIST_DIR})
#include_directories(${SELF_CHECKSUM_INCLUDE_DIR})
#link_directories(${LLVM_LIBRARY_DIRS})
#link_directories(${INPUT_DEP_LIB_DIR})
#link_directories(${CMAKE_CURRENT_BINARY_DIR})
#link_directories("/usr/local/lib/lib/")

set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNDEBUG")
add_definitions(-DHAVE_LLVM)
add_definitions(-DENABLE_CFG)
add_definitions(${LLVM_DEFINITIONS})

add_library(oblivious-hashing MODULE 
	src/ObliviousHashInsertion.cpp 
	src/AssertionInsertionPass.cpp 
	src/AssertionFinalizePass.cpp 
	src/AssertFunctionMarkPass.cpp
	src/Stats.cpp
        src/FunctionCallSitesInformation.cpp
        src/FunctionOHPaths.cpp
        src/MemoryDefinitionData.cpp
	)

target_include_directories(oblivious-hashing PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
        $<INSTALL_INTERFACE:include>
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
        ${LLVM_INCLUDE_DIRS}
        ${pdg_INCLUDE_DIR}
        ${DG_INCLUDE_DIR}
        ${SELF_CHECKSUM_INCLUDE_DIR}
        ${INPUT_DEP_INCLUDE_DIR}
)

target_link_libraries(oblivious-hashing PRIVATE
                      nlohmann_json::nlohmann_json
                      m
                      ${CMAKE_DL_LIBS}
)

get_target_property(OUT oblivious-hashing LINK_LIBRARIES)
target_compile_features(oblivious-hashing PRIVATE cxx_range_for cxx_auto_type cxx_std_17)
target_compile_options(oblivious-hashing PRIVATE -fno-rtti -g -DIL_STD) #-DNDEBUG)


