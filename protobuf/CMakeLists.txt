project(bunsan_bacs_smoke_protobuf)

if(UNIX)
    set(make ${BUNSAN_SMOKE_MAKE})
elseif(MINGW)
    set(make ${BUNSAN_SMOKE_MAKE}
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
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_SH} configure --prefix=${BUNSAN_SMOKE_ROOT}
    BUILD_COMMAND ${make}
    INSTALL_COMMAND ${make} install
)
if(MINGW)
    ExternalProject_Add_Step(protobuf pacman_prepare
        COMMAND ${MSYS_PACMAN} -Sy
        WORKING_DIRECTORY <SOURCE_DIR>
        DEPENDEES patch
    )
    ExternalProject_Add_Step(protobuf os_prepare
        COMMAND ${MSYS_PACMAN} -S --needed
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
    COMMAND ${BUNSAN_SMOKE_SH} autogen.sh
    WORKING_DIRECTORY <SOURCE_DIR>
    DEPENDEES os_prepare
    DEPENDERS configure
)
