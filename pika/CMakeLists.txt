project(bunsan_bacs_smoke_pika)

bunsan_find_python3()
set(PIKA_PYTHON_DIR
    python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}/site-packages
)
set(PIKA_PYTHON_PATH ${BUNSAN_SMOKE_ROOT}/lib/${PIKA_PYTHON_DIR})
set(PIKA_PYTHON_ENV ${CMAKE_COMMAND} -E env
    PYTHONPATH=${PIKA_PYTHON_PATH}
)

include(ExternalProject)
ExternalProject_Add(pika
    URL https://github.com/renshawbay/pika-python3/archive/0.9.14rb1.tar.gz
    URL_MD5 0d8cfb1480ff763d06a33f31081e5ff2
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_NOOP}
    BUILD_COMMAND ${PIKA_PYTHON_ENV} ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PIKA_PYTHON_ENV} ${PYTHON_EXECUTABLE}
        setup.py install --prefix=${BUNSAN_SMOKE_ROOT}
)
ExternalProject_Add_Step(pika preinstall
    COMMAND ${CMAKE_COMMAND} -E make_directory ${PIKA_PYTHON_PATH}
    DEPENDERS install
)
