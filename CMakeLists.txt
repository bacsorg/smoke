cmake_minimum_required(VERSION 3.0)

include(${CMAKE_SOURCE_DIR}/system-config.cmake OPTIONAL)

project(bunsan_bacs_smoke)

add_subdirectory(bunsan/cmake)

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

set(BUNSAN_SMOKE_ROOT ${CMAKE_BINARY_DIR}/root/usr)
add_subdirectory(boost EXCLUDE_FROM_ALL)
add_subdirectory(botan EXCLUDE_FROM_ALL)
add_subdirectory(pika EXCLUDE_FROM_ALL)
add_subdirectory(protobuf EXCLUDE_FROM_ALL)
add_subdirectory(turtle EXCLUDE_FROM_ALL)

include(ExternalProject)
macro(add_bunsan_project name path)
    ExternalProject_Add(${name}
        DOWNLOAD_COMMAND ""
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${path}
        CMAKE_ARGS
            -DENABLE_TESTS=OFF
            -DCMAKE_INSTALL_PREFIX=${BUNSAN_SMOKE_ROOT}
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
            -DBOOST_ROOT=${BUNSAN_SMOKE_ROOT}
            -DBoost_NO_SYSTEM_PATHS=ON
            -DBOOST_INCLUDEDIR=${BUNSAN_SMOKE_ROOT}/include
            -DBOOST_LIBRARYDIR=${BUNSAN_SMOKE_ROOT}/lib
        DEPENDS
            boost
            turtle
            ${ARGN}
    )
endmacro()

add_bunsan_project(bunsan_cmake bunsan/cmake)
add_bunsan_project(bunsan_test bunsan/test bunsan_cmake)
add_bunsan_project(bunsan_common bunsan/common bunsan_test)
add_bunsan_project(bunsan_process bunsan/process bunsan_common)
