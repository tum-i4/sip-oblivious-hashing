cmake_minimum_required(VERSION 3.12)
project(oblivious-hashing VERSION 0.1.0 LANGUAGES CXX)

list(INSERT CMAKE_MODULE_PATH 0 ${CMAKE_SOURCE_DIR}/cmake)

find_package(LLVM 6.0 REQUIRED CONFIG)
find_package(nlohmann_json REQUIRED)
find_package(Boost REQUIRED)
find_package(input-dependency REQUIRED COMPONENTS InputDependency)
find_package(llvm-dg REQUIRED)
find_package(self-checksumming REQUIRED)

add_library(oblivious-hashing MODULE
        include/oblivious-hashing/AssertFunctionMarkPass.h
        include/oblivious-hashing/AssertionFinalizePass.h
        include/oblivious-hashing/AssertionInsertionPass.h
        include/oblivious-hashing/FunctionCallSitesInformation.h
        include/oblivious-hashing/FunctionDominanceTree.h
        include/oblivious-hashing/FunctionOHPaths.h
        include/oblivious-hashing/MemoryDefinitionData.h
        include/oblivious-hashing/ObliviousHashInsertion.h
        include/oblivious-hashing/OHRunner.h
        include/oblivious-hashing/Slicer.h
        include/oblivious-hashing/Stats.h
        include/oblivious-hashing/Utils.h

        src/AssertFunctionMarkPass.cpp
        src/AssertionFinalizePass.cpp
        src/AssertionInsertionPass.cpp
        src/FunctionCallSitesInformation.cpp
        src/FunctionOHPaths.cpp
        src/MemoryDefinitionData.cpp
        src/ObliviousHashInsertion.cpp
        src/Slicer.cpp
        src/Stats.cpp
        )

target_include_directories(oblivious-hashing PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
        ${LLVM_INCLUDE_DIRS}
        ${Boost_INCLUDE_DIRS})

if ($ENV{CLION_IDE})
    include_directories("/usr/include/llvm-6.0/")
    include_directories("/usr/include/llvm-c-6.0/")
endif ()

target_compile_features(oblivious-hashing PRIVATE cxx_range_for cxx_auto_type)
target_compile_options(oblivious-hashing PRIVATE -fno-rtti)

target_link_libraries(oblivious-hashing
        PRIVATE
        nlohmann_json::nlohmann_json
        input-dependency::InputDependency
        llvm-dg::llvm-dg)