cmake_minimum_required(VERSION 3.0)

include(${CMAKE_SOURCE_DIR}/system-config.cmake OPTIONAL)

project(bunsan_bacs_smoke)

add_subdirectory(bunsan/cmake)

if(BunsanCMakeBuiltin)
    BunsanCMakeLoad()
else()
    find_package(BunsanCMake CONFIG REQUIRED)
endif()

set(BUNSAN_SMOKE_NOOP ${CMAKE_COMMAND} -E echo_append)
set(BUNSAN_SMOKE_ROOT ${CMAKE_BINARY_DIR}/root/usr)

# environment
add_subdirectory(msys)
add_subdirectory(python)

# base libraries
add_subdirectory(pcre)
add_subdirectory(zlib)

# libraries
add_subdirectory(boost)
add_subdirectory(botan)
add_subdirectory(cppcms)
add_subdirectory(pika)
add_subdirectory(protobuf)
add_subdirectory(turtle)

add_subdirectory(bunsan)
