cmake_minimum_required(VERSION 2.6)
project(Bar)

# find package Foo (example library)
find_package(Foo REQUIRED)
include_directories(${FOO_INCLUDE_DIRS})

# build type
set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
             "Debug"
             "Release"
             "MinSizeRel"
             "RelWithDebInfo"
)

# add binary
add_executable(bar bar.cpp)

# add library
target_link_libraries(bar ${FOO_LIBRARIES})

