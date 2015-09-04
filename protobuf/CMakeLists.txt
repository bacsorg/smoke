include(ExternalProject)
ExternalProject_Add(protobuf
    URL https://github.com/google/protobuf/archive/v3.0.0-beta-1.tar.gz
    URL_MD5 9422f45da18066a691917ef51c56caec
    CONFIGURE_COMMAND ${CMAKE_COMMAND} <SOURCE_DIR>/cmake
        -DCMAKE_PREFIX_PATH=${BUNSAN_SMOKE_ROOT}
        -DCMAKE_INSTALL_PREFIX=${BUNSAN_SMOKE_ROOT}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DBUILD_TESTING=OFF
        -DBUILD_SHARED_LIBS=ON
    DEPENDS zlib
)
