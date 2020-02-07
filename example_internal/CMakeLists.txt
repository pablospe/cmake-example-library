add_executable(bar bar.cpp)

target_link_libraries(bar ${LIBRARY_NAME})

install(
  TARGETS bar
  # EXPORT ${PROJECT_EXPORT} # uncomment in order to export target
  RUNTIME DESTINATION bin
  COMPONENT "${INSTALL_BIN_DIR}"
)

