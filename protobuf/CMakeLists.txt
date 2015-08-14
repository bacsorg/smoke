project(bunsan_bacs_smoke_protobuf)

include(ExternalProject)
ExternalProject_Add(protobuf
    URL https://github.com/google/protobuf/archive/v3.0.0-alpha-3.1.tar.gz
    URL_MD5 9f4bb26dadd8ee578d8974fa854cae37
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND bash -c
        "./autogen.sh && ./configure --prefix=${BUNSAN_SMOKE_ROOT}"
    BUILD_COMMAND make
    INSTALL_COMMAND make install
)
