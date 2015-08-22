project(bunsan_bacs_smoke_protobuf)

if(UNIX)
    set(env)
    set(sh sh)
    set(make ${CMAKE_MAKE_PROGRAM})
elseif(MINGW)
    find_path(MSYS_BIN
        NAMES pacman.exe
        PATHS
            C:/msys64/usr/bin
            C:/msys64/bin
            C:/msys32/usr/bin
            C:/msys32/bin
    )
    if(NOT MSYS_BIN)
        message(SEND_ERROR "Unable to find MSYS, set MSYS_BIN manually")
    endif()
    set(env ${MSYS_BIN}/sh.exe ${CMAKE_CURRENT_LIST_DIR}/msys_run.sh)
    set(pacman ${env} ${MSYS_BIN}/pacman.exe)
    set(sh ${env} ${MSYS_BIN}/sh.exe)
    set(make ${CMAKE_MAKE_PROGRAM}
        "MAKE=${CMAKE_MAKE_PROGRAM}"
        "EGREP=${MSYS_BIN}/grep -E"
        "FGREP=${MSYS_BIN}/grep -F"
        "GREP=${MSYS_BIN}/grep"
        "INSTALL=${MSYS_BIN}/install -c"
        "MKDIR_P=${MSYS_BIN}/mkdir -p"
        "SED=${MSYS_BIN}/sed"
    )
else()
    message("Unsupported platform")
endif()

include(ExternalProject)
ExternalProject_Add(protobuf
    URL https://github.com/google/protobuf/archive/v3.0.0-alpha-3.1.tar.gz
    URL_MD5 9f4bb26dadd8ee578d8974fa854cae37
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${sh} configure --prefix=${BUNSAN_SMOKE_ROOT}
    BUILD_COMMAND ${env} ${make}
    INSTALL_COMMAND ${env} ${make} install
)
if(MINGW)
    ExternalProject_Add_Step(protobuf pacman_prepare
        COMMAND ${pacman} -Sy
        WORKING_DIRECTORY <SOURCE_DIR>
        DEPENDEES patch
    )
    ExternalProject_Add_Step(protobuf os_prepare
        COMMAND ${pacman} -S --needed
            autoconf
            automake
            libtool
            perl
            sed
            unzip
        WORKING_DIRECTORY <SOURCE_DIR>
        DEPENDEES pacman_prepare
    )
else()
    ExternalProject_Add_Step(protobuf os_prepare
        COMMAND ${BUNSAN_SMOKE_NOOP}
        WORKING_DIRECTORY <SOURCE_DIR>
        DEPENDEES patch
    )
endif()
ExternalProject_Add_Step(protobuf prepare
    COMMAND ${sh} autogen.sh
    WORKING_DIRECTORY <SOURCE_DIR>
    DEPENDEES os_prepare
    DEPENDERS configure
)
