cmake_minimum_required(VERSION 3.0)

include(${CMAKE_SOURCE_DIR}/system-config.cmake OPTIONAL)

project(bunsan_bacs_smoke)

if(BunsanCMakeBuiltin)
    BunsanCMakeLoad()
else()
    find_package(BunsanCMake CONFIG REQUIRED)
endif()

if(UNIX)
    set(BUNSAN_SMOKE_NOOP true)
elseif(WIN32)
    set(BUNSAN_SMOKE_NOOP call)
else()
    message(SEND_ERROR "Unknown platform")
endif()

set(BUNSAN_SMOKE_ROOT ${CMAKE_BINARY_DIR}/root)
add_subdirectory(boost)
add_subdirectory(botan)
