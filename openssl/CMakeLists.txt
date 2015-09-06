if(UNIX)
    set(compiler gcc)
elseif(WIN32)
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(compiler mingw64)
    elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
        set(compiler mingw)
    else()
        message(SEND_ERROR "Unknown platform")
    endif()
else()
    message(SEND_ERROR "Unknown platform")
endif()

string(REGEX REPLACE "gcc(\\.exe)?$" "" cross_compile "${CMAKE_C_COMPILER}")
if(cross_compile MATCHES "-$")
    set(make_parameters
        "CROSS_COMPILE=${cross_compile}"
    )
else()
    set(make_parameters)
endif()
list(APPEND make_parameters
    "AR=${CMAKE_AR} r"
)

include(ExternalProject)
ExternalProject_Add(openssl
    URL ftp://ftp.openssl.org/source/openssl-1.0.2d.tar.gz
    URL_MD5 38dd619b2e77cbac69b99f52a053d25a
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_PERL} Configure ${compiler}
        no-asm
        shared
        --prefix=${BUNSAN_SMOKE_ROOT}
    BUILD_COMMAND ${BUNSAN_SMOKE_MAKE} ${make_parameters}
    INSTALL_COMMAND ${BUNSAN_SMOKE_MAKE} ${make_parameters} install
)
