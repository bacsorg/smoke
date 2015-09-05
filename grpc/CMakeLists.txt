include(ExternalProject)
ExternalProject_Add(grpc
    URL https://github.com/grpc/grpc/archive/release-0_10_2.tar.gz
    URL_MD5 770c5c9c5f6fb82488cde616b52d4c09
    BUILD_IN_SOURCE 1
    PATCH_COMMAND ${CMAKE_COMMAND}
        -DGRPC_SOURCE_ROOT=<SOURCE_DIR>
        -P ${CMAKE_CURRENT_LIST_DIR}/patch.cmake
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_NOOP}
    BUILD_COMMAND ${BUNSAN_SMOKE_MAKE} CFLAGS=-D_WIN32_WINNT=0x0600 prefix=${BUNSAN_SMOKE_ROOT}
    INSTALL_COMMAND ${BUNSAN_SMOKE_MAKE} install prefix=${BUNSAN_SMOKE_ROOT}
    DEPENDS protobuf
)
