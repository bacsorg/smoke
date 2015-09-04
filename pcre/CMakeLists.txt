include(ExternalProject)
ExternalProject_Add(pcre
    URL ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.zip
    URL_MD5 571af7672a830769b0cbbe449e4a0c64
    CMAKE_ARGS ${BUNSAN_SMOKE_CMAKE_ARGS}
)
