add_executable(bar bar.cpp)

target_link_libraries(bar PRIVATE Foo::foo)

target_include_directories(bar PUBLIC
  $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${LIBRARY_NAME}>
)

install(
  TARGETS bar
  RUNTIME DESTINATION bin
  COMPONENT "${INSTALL_BIN_DIR}"
)
