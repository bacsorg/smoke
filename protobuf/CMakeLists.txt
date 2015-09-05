include(ExternalProject)
ExternalProject_Add(protobuf
    URL https://github.com/google/protobuf/archive/v3.0.0-beta-1.tar.gz
    URL_MD5 9422f45da18066a691917ef51c56caec
    CONFIGURE_COMMAND ${CMAKE_COMMAND} <SOURCE_DIR>/cmake
        -DCMAKE_GENERATOR=${CMAKE_GENERATOR}
        ${BUNSAN_SMOKE_CMAKE_ARGS}
        -DBUILD_TESTING=OFF
    DEPENDS zlib
)
