cmake_minimum_required(VERSION 3.0)

include(${CMAKE_SOURCE_DIR}/system-config.cmake OPTIONAL)

project(bunsan_bacs_smoke)

add_subdirectory(bunsan/cmake)

if(BunsanCMakeBuiltin)
    BunsanCMakeLoad()
else()
    find_package(BunsanCMake CONFIG REQUIRED)
endif()

set(CMAKE_BUILD_TYPE Release CACHE STRING
    "Choose the type of build, options are: Debug, Release, RelWithDebInfo and MinSizeRel." FORCE)

set(BUNSAN_SMOKE_NOOP ${CMAKE_COMMAND} -E echo_append)
set(BUNSAN_SMOKE_ROOT ${CMAKE_BINARY_DIR}/root/usr)
set(BUNSAN_SMOKE_CMAKE_ARGS
    -DCMAKE_PREFIX_PATH=${BUNSAN_SMOKE_ROOT}
    -DCMAKE_INSTALL_PREFIX=${BUNSAN_SMOKE_ROOT}
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DBUILD_SHARED_LIBS=ON

    -DPython_ADDITIONAL_VERSIONS=3.5
    "-DCMAKE_CXX_FLAGS=-D_hypot=hypot -I${BUNSAN_SMOKE_ROOT}/include"
)
if(CMAKE_TOOLCHAIN_FILE)
    list(APPEND BUNSAN_SMOKE_CMAKE_ARGS
         -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE})
endif()

option(ENABLE_WEB "Enable CppCMS-based Web" OFF)

# environment
add_subdirectory(msys)
add_subdirectory(python)

# base libraries
add_subdirectory(openssl)
if(ENABLE_WEB)
    add_subdirectory(pcre)
endif()
add_subdirectory(zlib)

# Google
add_subdirectory(protobuf)
add_subdirectory(grpc)

# libraries
add_subdirectory(boost)
add_subdirectory(botan)
if(ENABLE_WEB)
    add_subdirectory(cppcms)
endif()
add_subdirectory(pika)
add_subdirectory(turtle)

add_subdirectory(bunsan)
