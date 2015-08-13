project(bunsan_bacs_smoke_boost)

bunsan_find_python2()

if(UNIX)
    set(noop true)
    set(boost_configure
        ./bootstrap.sh
            --with-toolset=gcc
            --with-icu
            --with-python=${PYTHON_EXECUTABLE}
    )
    set(boost_b2
        ./b2
            --prefix=${BUNSAN_SMOKE_ROOT}
            -j5
            toolset=gcc
            variant=release
            link=shared
            threading=multi
    )
elseif(WIN32)
    set(noop call)
    set(boost_configure
        bootstrap.bat
            --with-toolset=gcc
            --with-icu
            --with-python=${PYTHON_EXECUTABLE}
    )
    set(boost_b2
        ./b2
            --prefix=${BUNSAN_SMOKE_ROOT}
            -j5
            toolset=gcc
            variant=release
            link=shared
            threading=multi
    )
else()
    message(SEND_ERROR "Unknown platform")
endif()

include(ExternalProject)
ExternalProject_Add(boost
    URL http://downloads.sourceforge.net/boost/boost_1_58_0.tar.gz
    URL_MD5 5a5d5614d9a07672e1ab2a250b5defc5
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${boost_configure}
    BUILD_COMMAND ${boost_b2} stage
    INSTALL_COMMAND ${boost_b2} install
)
ExternalProject_Add(boost_dll
    GIT_REPOSITORY https://github.com/apolukhin/Boost.DLL.git
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${noop}
    BUILD_COMMAND ${noop}
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory include ${BUNSAN_SMOKE_ROOT}/include
)
