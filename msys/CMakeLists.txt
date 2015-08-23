if(UNIX)
    set(BUNSAN_SMOKE_MAKE ${CMAKE_MAKE_PROGRAM} CACHE INTERNAL "")
    set(BUNSAN_SMOKE_SH sh CACHE INTERNAL "")
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
    set(MSYS_ENV ${MSYS_BIN}/sh.exe ${CMAKE_CURRENT_LIST_DIR}/run.sh CACHE INTERNAL "")
    set(MSYS_PACMAN ${MSYS_ENV} ${MSYS_BIN}/pacman.exe CACHE INTERNAL "")
    set(BUNSAN_SMOKE_MAKE ${MSYS_ENV} ${CMAKE_MAKE_PROGRAM} CACHE INTERNAL "")
    set(BUNSAN_SMOKE_SH ${MSYS_ENV} ${MSYS_BIN}/sh.exe CACHE INTERNAL "")
else()
    message("Unsupported platform")
endif()
