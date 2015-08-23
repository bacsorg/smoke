if(UNIX)
    set(PCRE_SUFFIX)
elseif(WIN32)
    set(PCRE_SUFFIX d)
endif()

include(ExternalProject)
ExternalProject_Add(cppcms
    URL http://sourceforge.net/projects/cppcms/files/cppcms/1.0.5/cppcms-1.0.5.tar.bz2/download
    URL_MD5 d668c201dd31fff8090380ebdc0bcc2b
    CMAKE_ARGS
        -DCMAKE_PREFIX_PATH=${BUNSAN_SMOKE_ROOT}
        -DCMAKE_INSTALL_PREFIX=${BUNSAN_SMOKE_ROOT}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DBUILD_SHARED_LIBS=ON
        -DDISABLE_STATIC=ON

        -DPYTHON=${BUNSAN_SMOKE_PYTHON2_EXECUTABLE}
        -DPCRE_SUFFIX=${PCRE_SUFFIX}
    DEPENDS
        pcre
        zlib
)
