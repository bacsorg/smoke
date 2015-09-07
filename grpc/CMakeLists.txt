set(compiler_flags_
    -D_WIN32_WINNT=0x0600
    -I${BUNSAN_SMOKE_ROOT}/include
)
string(REPLACE ";" " " compiler_flags "${compiler_flags_}")

set(make_parameters
    "AR=${CMAKE_AR}"
    "STRIP=${CMAKE_STRIP}"
    "LD=${CMAKE_C_COMPILER}"
    "LDXX=${CMAKE_CXX_COMPILER}"

    "CFLAGS=-std=c11 ${compiler_flags}"
    "CXXFLAGS=-std=c++11 ${compiler_flags}"
    "LDFLAGS=-L${BUNSAN_SMOKE_ROOT}/bin -L${BUNSAN_SMOKE_ROOT}/lib"

    HAS_PKG_CONFIG=false
    HAS_SYSTEM_OPENSSL_ALPN=true
    HAS_SYSTEM_ZLIB=true
    HAS_SYSTEM_PROTOBUF=true

    prefix=${BUNSAN_SMOKE_ROOT}
)
if(MINGW)
    list(APPEND make_parameters SYSTEM=MINGW32)
endif()

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
    INSTALL_COMMAND ${CMAKE_COMMAND}
        -DBUNSAN_SMOKE_ROOT=${BUNSAN_SMOKE_ROOT}
        -DGRPC_SOURCE_ROOT=<SOURCE_DIR>
        -P ${CMAKE_CURRENT_LIST_DIR}/install.cmake
    DEPENDS openssl protobuf zlib
)
if(WIN32)
    ExternalProject_Add_Step(grpc post_install
        COMMAND ${CMAKE_COMMAND}
            -DBUNSAN_SMOKE_ROOT=${BUNSAN_SMOKE_ROOT}
            -P ${CMAKE_CURRENT_LIST_DIR}/win32_post_install.cmake
        DEPENDEES install
    )
endif()
