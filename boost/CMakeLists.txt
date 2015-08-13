project(bunsan_bacs_smoke_boost)

bunsan_find_python2()

if(UNIX)
    set(boost_configure
        ./bootstrap.sh
            --with-toolset=gcc
            --with-icu
            --with-python=${PYTHON_EXECUTABLE}
    )
    set(boost_b2
        ./b2
            --prefix=${CMAKE_INSTALL_PREFIX}
            -j5
            toolset=gcc
            variant=release
            link=shared
            threading=multi
    )
elseif(WIN32)
    set(boost_configure
        bootstrap.bat
            --with-toolset=gcc
            --with-icu
            --with-python=${PYTHON_EXECUTABLE}
    )
    set(boost_b2
        ./b2
            --prefix=${CMAKE_INSTALL_PREFIX}
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