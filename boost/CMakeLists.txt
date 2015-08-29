if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(boost_address_model 64)
    set(boost_win_cxxflags "-DMS_WIN64")
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
    set(boost_address_model 32)
    set(boost_win_cxxflags)
else()
    message(SEND_ERROR "Unknown platform")
endif()

if(UNIX)
    set(boost_configure
        ./bootstrap.sh
            --with-toolset=gcc
            --with-icu
            --with-python=${BUNSAN_SMOKE_PYTHON2_EXECUTABLE}
    )
    set(boost_b2
        ./b2
            --prefix=${BUNSAN_SMOKE_ROOT}
            -j5
            toolset=gcc
            variant=release
            link=shared
            threading=multi
            address-model=${boost_address_model}
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
            address-model=${boost_address_model}
            cxxflags=${boost_win_cxxflags}
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
            -DBUNSAN_SMOKE_PYTHON2_VERSION=${BUNSAN_SMOKE_PYTHON2_VERSION}
            -DBUNSAN_SMOKE_PYTHON2_PREFIX=${BUNSAN_SMOKE_PYTHON2_PREFIX}
            -DBUNSAN_SMOKE_PYTHON2_INCLUDE_DIR=${BUNSAN_SMOKE_PYTHON2_INCLUDE_DIR}
            -DBUNSAN_SMOKE_PYTHON2_LIBRARY_DIR=${BUNSAN_SMOKE_PYTHON2_LIBRARY_DIR}
            -DBUNSAN_SMOKE_PYTHON3_VERSION=${BUNSAN_SMOKE_PYTHON3_VERSION}
            -DBUNSAN_SMOKE_PYTHON3_PREFIX=${BUNSAN_SMOKE_PYTHON3_PREFIX}
            -DBUNSAN_SMOKE_PYTHON3_INCLUDE_DIR=${BUNSAN_SMOKE_PYTHON3_INCLUDE_DIR}
            -DBUNSAN_SMOKE_PYTHON3_LIBRARY_DIR=${BUNSAN_SMOKE_PYTHON3_LIBRARY_DIR}
            -P ${CMAKE_CURRENT_LIST_DIR}/patch.cmake
    DEPENDEES configure
    DEPENDERS build
)
if(WIN32)
    ExternalProject_Add_Step(boost_core post_install
        COMMAND
            ${CMAKE_COMMAND}
                -DBUNSAN_SMOKE_ROOT=${BUNSAN_SMOKE_ROOT}
                -P ${CMAKE_CURRENT_LIST_DIR}/win32_post_install.cmake
        DEPENDEES install
    )
endif()

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
