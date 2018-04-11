cmake_minimum_required(VERSION 3.1)

set (INPUT_DEP_INCLUDE_DIR "/usr/local/include/input-dependency")
set (DG_INCLUDE_DIR "/usr/local/include/llvm-dg")
set (INPUT_DEP_LIB_DIR "/usr/local/lib")
set (SELF_CHECKSUM_INCLUDE_DIR "/home/anahitik/SIP/self-checksumming/src")
set (SELF_CHECKSUM_LIB_DIR "/home/anahitik/SIP/self-checksumming/build/lib")

find_package(LLVM REQUIRED CONFIG)
add_definitions(${LLVM_DEFINITIONS})

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${INPUT_DEP_INCLUDE_DIR})
include_directories(${DG_INCLUDE_DIR})
include_directories("${DG_INCLUDE_DIR}/analysis")
include_directories(${CMAKE_CURRENT_LIST_DIR})
include_directories(${SELF_CHECKSUM_INCLUDE_DIR})

link_directories(${LLVM_LIBRARY_DIRS})
link_directories(${INPUT_DEP_LIB_DIR})
link_directories(${CMAKE_CURRENT_BINARY_DIR})

set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNDEBUG")
add_definitions(-DHAVE_LLVM)
add_definitions(-DENABLE_CFG)

add_subdirectory(src)

