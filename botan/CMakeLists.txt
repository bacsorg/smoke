project(bunsan_bacs_smoke_botan)

if(UNIX)
    set(botan_args)
elseif(MINGW)
    set(botan_args --os=mingw)
elseif(CYGWIN)
    set(botan_args --os=cygwin)
endif()

set(botan_make_args
    "RM=${CMAKE_COMMAND} -E remove -f"
    "RM_R=cmake -E remove_directory"
)
if(MINGW)
    list(APPEND botan_make_args
        "COPY=copy"
        "LN=${CMAKE_COMMAND} -E copy_if_different"
        "SCRIPTS_DIR=${BUNSAN_SMOKE_PYTHON2_EXECUTABLE} src/scripts"
    )
endif()

include(ExternalProject)
ExternalProject_Add(botan
    GIT_REPOSITORY https://github.com/randombit/botan.git
    GIT_TAG 8e19ecf11c
    BUILD_IN_SOURCE 1
    PATCH_COMMAND
        ${CMAKE_COMMAND}
            -DBOTAN_SOURCE_ROOT=<SOURCE_DIR>
            -P ${CMAKE_CURRENT_LIST_DIR}/patch.cmake
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_PYTHON2_EXECUTABLE} configure.py
        --prefix=${BUNSAN_SMOKE_ROOT}
        --cc=gcc
        --link-method=copy
        --enable-shared
        ${botan_args}
    BUILD_COMMAND ${CMAKE_MAKE_PROGRAM} ${botan_make_args}
    INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} ${botan_make_args} install
)
if(WIN32)
    ExternalProject_Add_Step(botan post_install
        COMMAND
            ${CMAKE_COMMAND}
                -DBUNSAN_SMOKE_ROOT=${BUNSAN_SMOKE_ROOT}
                -P ${CMAKE_CURRENT_LIST_DIR}/win32_post_install.cmake
        DEPENDEES install
    )
endif()
