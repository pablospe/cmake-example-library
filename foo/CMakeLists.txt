# Set SOURCES variable
file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

# Set HEADERS variable
file(GLOB HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

include(${CMAKE_SOURCE_DIR}/cmake/LibraryConfig.cmake)
