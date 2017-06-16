add_library(skeleton MODULE
    InputDependencySkeleton.cpp
)

# Use C++11 to compile our pass (i.e., supply -std=c++11).
target_compile_features(skeleton PRIVATE cxx_range_for cxx_auto_type)

# LLVM is (typically) built with no C++ RTTI. We need to match that;
# otherwise, we'll get linker errors about missing RTTI data.
set_target_properties(skeleton PROPERTIES
    COMPILE_FLAGS "-lInputDependency -fno-rtti -g"
)

