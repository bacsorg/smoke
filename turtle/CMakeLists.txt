project(bunsan_bacs_smoke_turtle)

include(ExternalProject)
ExternalProject_Add(turtle
    URL http://downloads.sourceforge.net/project/turtle/turtle/1.2.7/turtle-1.2.7.tar.bz2
    URL_MD5 9b188bdd09bdad9f1bc8e5080161d01f
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_NOOP}
    BUILD_COMMAND ${BUNSAN_SMOKE_NOOP}
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory include ${BUNSAN_SMOKE_ROOT}/include
)
