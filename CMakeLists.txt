cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_STANDARD 11)

# ---------- Version ----------
# set(VERSION_MAJOR 0)
# set(VERSION_MINOR 2)
# set(VERSION_PATCH 0)

# ---------- Pico SDK Project Setup  ----------
# Importing the pico-sdk importer
include(external/pico-sdk/pico_sdk_init.cmake)

# Project
project(program)
pico_sdk_init()

set(stdlibs pico_stdlib hardware_gpio hardware_adc hardware_spi hardware_dma hardware_uart pico_bootsel_via_double_reset)

# To make sure build folder doesn't get cluttered
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_compile_options(
    -Wall # Enable all warnings
    -O3 # I am speed
    -Werror # Treat warnings as errors
    -Wno-unused-variable # annoying, don't keep it tho
    -Wno-unused-but-set-variable
    -Wno-unused-function # FreeRTOS
    -Wno-strict-aliasing # pico-sdk fails this
)

if(PICO_PLATFORM MATCHES "host")
    add_compile_options(
        -Wno-error # host compilation redefines shit for some reason, and it prevents compilation
    )
endif()

# --------- Git Describe ---------
execute_process(
    COMMAND git describe --tags --dirty
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_DESCRIBE_STRING
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

# ---------- Main Program  ----------S

file(GLOB_RECURSE srcs src/*.c)
file(GLOB_RECURSE hdrs src/*.h)

add_executable(program ${srcs} ${hdrs})
target_include_directories(program PUBLIC src/)
target_link_directories(program PUBLIC src/)
pico_set_program_name(program "program")
pico_set_program_version(program "${GIT_DESCRIBE_STRING} (build ${CMAKE_BUILD_TYPE})")

set_target_properties(program
    PROPERTIES

    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/elf
)

target_link_libraries(program ${stdlibs} ${libs})

pico_enable_stdio_usb(program 1)
pico_enable_stdio_uart(program 0)

pico_set_binary_type(program copy_to_ram) # run full program from ram

# pico_set_float_implementation(program none)
pico_add_uf2_output(program)
