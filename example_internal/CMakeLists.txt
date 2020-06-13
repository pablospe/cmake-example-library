add_executable(bar bar.cpp)

target_link_libraries(bar PRIVATE Foo::foo)

install(
  TARGETS bar
  RUNTIME DESTINATION bin
)
