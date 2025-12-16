# Test case #1
add_test(
  NAME qsort_test
  COMMAND ${CMAKE_BINARY_DIR}/verilator_sim +prog_elf_path=${CMAKE_BINARY_DIR}/runtime/test-progs/qsort
)

# Test case #2
