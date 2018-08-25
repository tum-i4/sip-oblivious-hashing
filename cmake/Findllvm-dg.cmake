set(llvm-dg_INCLUDE_DIR /usr/local/include/llvm-dg)
set(llvm-dg_VERSION ${PC_llvm-dg_VERSION})

mark_as_advanced(llvm-dg_FOUND llvm-dg_INCLUDE_DIR llvm-dg_VERSION)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(llvm-dg
        REQUIRED_VARS llvm-dg_INCLUDE_DIR
        VERSION_VAR llvm-dg_VERSION
        )

if(llvm-dg_FOUND)
    find_package(LLVM 6.0 REQUIRED CONFIG)
    set(llvm-dg_INCLUDE_DIRS ${llvm-dg_INCLUDE_DIR})
endif()

if(llvm-dg_FOUND AND NOT TARGET llvm-dg:llvm-dg)
    add_library(llvm-dg::llvm-dg INTERFACE IMPORTED)
    set_target_properties(llvm-dg::llvm-dg PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${llvm-dg_INCLUDE_DIR}"
            )

    target_compile_definitions(llvm-dg::llvm-dg
            INTERFACE
            -DHAVE_LLVM
            -DENABLE_CFG)
endif()