macro(bunsan_smoke_setup_python pyver)
    set(BUNSAN_SMOKE_PYTHON${pyver}_EXECUTABLE
        ${PYTHON_EXECUTABLE}
        CACHE INTERNAL ""
    )
    set(BUNSAN_SMOKE_PYTHON${pyver}_VERSION
        ${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}
        CACHE INTERNAL ""
    )
    set(BUNSAN_SMOKE_PYTHON${pyver}_WINDIR
        Python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}
        CACHE INTERNAL ""
    )
    set(BUNSAN_SMOKE_PYTHON${pyver}_INCLUDE_DIR
        ${PYTHON_INCLUDE_DIR}
        CACHE INTERNAL ""
    )
    get_filename_component(BUNSAN_SMOKE_PYTHON${pyver}_LIBRARY_DIR
                          ${PYTHON_LIBRARY} DIRECTORY CACHE)
    get_filename_component(BUNSAN_SMOKE_PYTHON${pyver}_PREFIX
                           ${BUNSAN_SMOKE_PYTHON${pyver}_INCLUDE_DIR} DIRECTORY CACHE)
    if(UNIX)
        set(BUNSAN_SMOKE_PYTHON${pyver}_INSTALL_PREFIX
            ${BUNSAN_SMOKE_ROOT}
            CACHE INTERNAL ""
        )
        set(BUNSAN_SMOKE_PYTHON${pyver}_INSTALL_PATH
            ${BUNSAN_SMOKE_PYTHON${pyver}_PREFIX}/lib/python${BUNSAN_SMOKE_PYTHON${pyver}_VERSION}/site-packages
            CACHE INTERNAL ""
        )
    elseif(WIN32)
        set(BUNSAN_SMOKE_PYTHON${pyver}_INSTALL_PREFIX
            ${BUNSAN_SMOKE_ROOT}/${BUNSAN_SMOKE_PYTHON${pyver}_WINDIR}
            CACHE INTERNAL ""
        )
        set(BUNSAN_SMOKE_PYTHON${pyver}_INSTALL_PATH
            ${BUNSAN_SMOKE_PYTHON${pyver}_PREFIX}/Lib/site-packages
            CACHE INTERNAL ""
        )
    else()
        message(SEND_ERROR "Unknown platform")
    endif()
endmacro()

bunsan_find_python2()
bunsan_smoke_setup_python(2)

set(Python_ADDITIONAL_VERSIONS 3.5)
bunsan_find_python3()
bunsan_smoke_setup_python(3)

macro(bunsan_smoke_to_native_python_path)
    if(WIN32)
        foreach(var ${ARGN})
            string(REPLACE "/" "\\" ${var} "${${var}}")
        endforeach()
    endif()
endmacro()
