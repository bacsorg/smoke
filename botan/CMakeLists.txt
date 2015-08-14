project(bunsan_bacs_smoke_botan)

bunsan_find_python()

include(ExternalProject)
ExternalProject_Add(botan
    GIT_REPOSITORY https://github.com/randombit/botan.git
    GIT_TAG 8e19ecf11c
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${PYTHON_EXECUTABLE} configure.py
        --prefix=${BUNSAN_SMOKE_ROOT}
    BUILD_COMMAND make
    INSTALL_COMMAND make install
)
