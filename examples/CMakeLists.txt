# (uncomment these lines for an external project)
#
# cmake_minimum_required(VERSION 2.6)
# project(Bar)
# find_package(Foo REQUIRED)
# include_directories(${FOO_INCLUDE_DIRS})

add_executable(bar bar.cpp)

target_link_libraries(bar ${LIBRARY_NAME})

install(TARGETS bar
# In order to export target, uncomment next line
#   EXPORT ${PROJECT_EXPORT}
  RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT bin)
