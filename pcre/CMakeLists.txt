include(ExternalProject)
ExternalProject_Add(pcre
    URL ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.zip
    URL_MD5 571af7672a830769b0cbbe449e4a0c64
    CMAKE_ARGS
        -DCMAKE_PREFIX_PATH=${BUNSAN_SMOKE_ROOT}
        -DCMAKE_INSTALL_PREFIX=${BUNSAN_SMOKE_ROOT}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DBUILD_SHARED_LIBS=ON
)
