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
            --prefix=${BUNSAN_SMOKE_ROOT}
            -j5
            toolset=gcc
            variant=release
            link=shared
            threading=multi
            --without-coroutine
    )
    set(boost_include ${BUNSAN_SMOKE_ROOT}/include)
elseif(WIN32)
    set(boost_configure bootstrap.bat)
    set(boost_b2
        ./b2
            --prefix=${BUNSAN_SMOKE_ROOT}
            -j5
            toolset=gcc
            variant=release
            link=shared
            threading=multi
            --without-coroutine
    )
    set(boost_include ${BUNSAN_SMOKE_ROOT}/include/boost-1_58)
else()
    message(SEND_ERROR "Unknown platform")
endif()

include(ExternalProject)
ExternalProject_Add(boost_core
    URL http://downloads.sourceforge.net/boost/boost_1_58_0.tar.gz
    URL_MD5 5a5d5614d9a07672e1ab2a250b5defc5
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${boost_configure}
    BUILD_COMMAND ${boost_b2} stage
    INSTALL_COMMAND ${boost_b2} install
)
ExternalProject_Add_Step(boost_core python3
    COMMAND
        ${CMAKE_COMMAND}
            -DBOOST_SOURCE_ROOT=<SOURCE_DIR>
            -P ${CMAKE_CURRENT_LIST_DIR}/patch.cmake
    DEPENDEES configure
    DEPENDERS build
)

ExternalProject_Add(boost_dll
    GIT_REPOSITORY https://github.com/apolukhin/Boost.DLL.git
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_NOOP}
    BUILD_COMMAND ${BUNSAN_SMOKE_NOOP}
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory include ${boost_include}
)

ExternalProject_Add(boost_nowide
    URL http://cppcms.com/files/nowide/nowide.zip
    URL_MD5 05869af83b7f72ef310e690ca2444078
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_NOOP}
    BUILD_COMMAND ${BUNSAN_SMOKE_NOOP}
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory boost ${boost_include}/boost
)

add_custom_target(boost
    DEPENDS
        boost_core
        boost_dll
        boost_nowide
)
