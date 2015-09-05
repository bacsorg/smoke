if(UNIX)
    set(USE_MSYS_DEFAULT OFF)
elseif(MINGW)
    set(USE_MSYS_DEFAULT ON)
else()
    message("Unsupported platform")
endif()
option(USE_MSYS ${USE_MSYS_DEFAULT} "Use MSYS for system shell")

if(USE_MSYS)
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
    set(MSYS_ENV ${MSYS_BIN}/sh.exe ${CMAKE_CURRENT_LIST_DIR}/run.sh CACHE INTERNAL "")
    set(MSYS_PACMAN ${MSYS_ENV} ${MSYS_BIN}/pacman.exe CACHE INTERNAL "")
    set(BUNSAN_SMOKE_MAKE ${MSYS_ENV} ${CMAKE_MAKE_PROGRAM}
        "MAKE=${CMAKE_MAKE_PROGRAM}"
        "EGREP=${MSYS_BIN}/grep -E"
        "FGREP=${MSYS_BIN}/grep -F"
        "GREP=${MSYS_BIN}/grep"
        "INSTALL=${MSYS_BIN}/install -c"
        "MKDIR_P=${MSYS_BIN}/mkdir -p"
        "SED=${MSYS_BIN}/sed"
        "PERL=${MSYS_BIN}/perl"
        CACHE INTERNAL "")
    set(BUNSAN_SMOKE_SH ${MSYS_ENV} ${MSYS_BIN}/sh.exe CACHE INTERNAL "")
    set(BUNSAN_SMOKE_PERL ${MSYS_ENV} ${MSYS_BIN}/perl.exe CACHE INTERNAL "")
else()
    set(BUNSAN_SMOKE_MAKE ${CMAKE_MAKE_PROGRAM} CACHE INTERNAL "")
    set(BUNSAN_SMOKE_SH sh CACHE INTERNAL "")
    set(BUNSAN_SMOKE_PERL perl CACHE INTERNAL "")
endif()
