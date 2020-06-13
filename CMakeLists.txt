# Set minimum version of CMake.
cmake_minimum_required(VERSION 3.9)

# Set project name and version
project(Foo VERSION 1.2.3)

# Set environment variables
include(${PROJECT_SOURCE_DIR}/cmake/SetEnv.cmake)

# Library sources
add_subdirectory(${LIBRARY_FOLDER})

# Library examples
add_subdirectory(example_internal)
