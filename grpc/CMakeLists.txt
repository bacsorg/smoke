set(compiler_flags_
    -D_WIN32_WINNT=0x0600
    -I${BUNSAN_SMOKE_ROOT}/include
)
string(REPLACE ";" " " compiler_flags "${compiler_flags_}")

set(make_parameters
    "CFLAGS=-std=c11 ${compiler_flags}"
    "CXXFLAGS=-std=c++11 ${compiler_flags}"
    "LDFLAGS=-L${BUNSAN_SMOKE_ROOT}/lib"

    HAS_PKG_CONFIG=false
    HAS_SYSTEM_OPENSSL_ALPN=true
    HAS_SYSTEM_ZLIB=true
    HAS_SYSTEM_PROTOBUF=true

    prefix=${BUNSAN_SMOKE_ROOT}
)

include(ExternalProject)
ExternalProject_Add(grpc
    URL https://github.com/grpc/grpc/archive/release-0_10_2.tar.gz
    URL_MD5 770c5c9c5f6fb82488cde616b52d4c09
    BUILD_IN_SOURCE 1
    PATCH_COMMAND ${CMAKE_COMMAND}
        -DGRPC_SOURCE_ROOT=<SOURCE_DIR>
        -P ${CMAKE_CURRENT_LIST_DIR}/patch.cmake
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_NOOP}
    BUILD_COMMAND ${BUNSAN_SMOKE_MAKE} ${make_parameters}
    INSTALL_COMMAND ${BUNSAN_SMOKE_MAKE} ${make_parameters} install
    DEPENDS openssl protobuf zlib
)
