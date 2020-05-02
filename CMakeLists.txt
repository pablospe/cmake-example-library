# After installation this project can be found by 'find_package(...)':
#
#    find_package(Foo <VERSION> REQUIRED)
#    target_link_libraries(... Foo::foo)
#
# Note that requirements propagated automatically, for example:
#   * Foo::foo linked automatically
#   * headers can be included by C++ code `#include <foo/foo.h>`
#   * FOO_DEBUG=1 added on Debug
#   * FOO_DEBUG=0 added on other configurations

# Set minimum version of CMake.
cmake_minimum_required(VERSION 3.9) # GENERATOR_IS_MULTI_CONFIG

# Set project variables:
#   * PROJECT_NAME
#   * PROJECT_VERSION
project(Foo VERSION 1.2.3)

# Set environment variables:
#   * LIBRARY_NAME
#   * LIBRARY_FOLDER
#   ...
include(${CMAKE_SOURCE_DIR}/cmake/SetEnv.cmake)

# Library sources
add_subdirectory(${LIBRARY_FOLDER})

# Library examples
add_subdirectory(example_internal)
