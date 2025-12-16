# CMake version requirements
cmake_minimum_required(VERSION 3.21...3.28)
if(${CMAKE_VERSION} VERSION_LESS 3.28)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION} ${CMAKE_MINOR_VERSION})
endif()

# project information
project("CrossVerify" VERSION 0.1.0
        DESCRIPTION "A reference-model-based verification framework for ISA Simulator and RTL Implementation."
        LANGUAGES C CXX)

# set C standard
set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED True)

# sub-projects
add_subdirectory(example-iss)
add_subdirectory(runtime)

# Testing
if (PROJECT_IS_TOP_LEVEL)
    include(CTest)
    if (BUILD_TESTING)
        add_subdirectory(tests)
    endif()
endif()

# RTL compilation
set(RTL_SRC_DIR rtl)
set(RTL_SRCS
    ${RTL_SRC_DIR}/MUX2.sv
    ${RTL_SRC_DIR}/MUX3.sv
    ${RTL_SRC_DIR}/Adder.sv
    ${RTL_SRC_DIR}/Decoder.sv
    ${RTL_SRC_DIR}/DEF.sv
    ${RTL_SRC_DIR}/JB_Unit.sv
    ${RTL_SRC_DIR}/Imm_Ext.sv
    ${RTL_SRC_DIR}/LD_Filter.sv
    ${RTL_SRC_DIR}/ALU.sv
    ${RTL_SRC_DIR}/Reg_PC.sv
    ${RTL_SRC_DIR}/Reg_D.sv
    ${RTL_SRC_DIR}/Reg_E.sv
    ${RTL_SRC_DIR}/Reg_M.sv
    ${RTL_SRC_DIR}/Reg_W.sv
    ${RTL_SRC_DIR}/RegFile.sv
    ${RTL_SRC_DIR}/Controller.sv
    ${RTL_SRC_DIR}/ROM.sv
    ${RTL_SRC_DIR}/CoreTop.sv
    ${RTL_SRC_DIR}/RAM.sv
    ${RTL_SRC_DIR}/TextBuffer.sv
    ${RTL_SRC_DIR}/Halt.sv
    ${RTL_SRC_DIR}/Top.sv
    src/CrossVerify.sv
)

# invoke verilator
find_package(verilator HINTS ${VERILATOR_ROOT})
add_executable(verilator_sim src/sim_main.cpp)
add_library(CrossVerify STATIC src/CrossVerify.cpp)
target_include_directories(
    CrossVerify
    PRIVATE
        example-iss/include
	${VERILATOR_ROOT}/include/vltstd
)
verilate(verilator_sim
    PREFIX VTestbench
    TOP_MODULE CrossVerify
    TRACE_FST
    SOURCES ${RTL_SRCS}
    VERILATOR_ARGS -sv --timing --trace-structs
)
target_link_libraries(CrossVerify PUBLIC iss)
target_link_libraries(verilator_sim PRIVATE CrossVerify)

