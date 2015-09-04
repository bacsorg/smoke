include(ExternalProject)
ExternalProject_Add(zlib
    URL http://sourceforge.net/projects/libpng/files/zlib-1.2.8.tar.gz/download
    URL_MD5 44d667c142d7cda120332623eab69f40
    CMAKE_ARGS ${BUNSAN_SMOKE_CMAKE_ARGS}
)
