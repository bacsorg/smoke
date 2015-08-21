project(bunsan_bacs_smoke_pika)

set(PIKA_PREFIX ${BUNSAN_SMOKE_PYTHON3_INSTALL_PREFIX})
set(PIKA_PYTHON_PATH ${BUNSAN_SMOKE_PYTHON3_INSTALL_PATH})
bunsan_smoke_to_native_python_path(PIKA_PREFIX PIKA_PYTHON_PATH)
set(PIKA_PYTHON_ENV ${CMAKE_COMMAND} -E env
    PYTHONPATH=${PIKA_PYTHON_PATH}
)

include(ExternalProject)
ExternalProject_Add(pika
    URL https://github.com/renshawbay/pika-python3/archive/0.9.14rb1.tar.gz
    URL_MD5 0d8cfb1480ff763d06a33f31081e5ff2
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${BUNSAN_SMOKE_NOOP}
    BUILD_COMMAND ${PIKA_PYTHON_ENV} ${BUNSAN_SMOKE_PYTHON3_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PIKA_PYTHON_ENV} ${BUNSAN_SMOKE_PYTHON3_EXECUTABLE}
        setup.py install --prefix=${PIKA_PREFIX}
)
ExternalProject_Add_Step(pika preinstall
    COMMAND ${CMAKE_COMMAND} -E make_directory ${PIKA_PYTHON_PATH}
    DEPENDEES build
    DEPENDERS install
)
