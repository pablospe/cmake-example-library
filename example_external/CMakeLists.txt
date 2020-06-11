cmake_minimum_required(VERSION 3.9)
project(Bar)

# find package Foo (example library)
find_package(Foo 1.0 CONFIG REQUIRED)

# add binary
add_executable(bar bar.cpp)

# add library
target_link_libraries(bar PRIVATE Foo::Foo)
