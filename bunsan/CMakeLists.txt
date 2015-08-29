include(ExternalProject)
macro(add_bunsan_project name path)
    ExternalProject_Add(${name}
        DOWNLOAD_COMMAND ""
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${path}
        CMAKE_ARGS
            -DCMAKE_PREFIX_PATH=${BUNSAN_SMOKE_ROOT}
            -DCMAKE_INSTALL_PREFIX=${BUNSAN_SMOKE_ROOT}
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}

            -DENABLE_TESTS=OFF
            -DENABLE_WEB=${ENABLE_WEB}
            -DPython_ADDITIONAL_VERSIONS=3.5
            -DCMAKE_CXX_FLAGS=-D_hypot=hypot
        DEPENDS
            boost
            turtle
            ${ARGN}
    )
endmacro()

add_bunsan_project(bunsan_cmake bunsan/cmake)
add_bunsan_project(bunsan_test bunsan/test bunsan_cmake)
add_bunsan_project(bunsan_common bunsan/common bunsan_test)
add_bunsan_project(bunsan_common_python bunsan/common_python bunsan_common)
add_bunsan_project(bunsan_process bunsan/process bunsan_common)
add_bunsan_project(bunsan_protobuf bunsan/protobuf protobuf bunsan_common)
add_bunsan_project(bunsan_rpc bunsan/rpc grpc bunsan_protobuf)
add_bunsan_project(bunsan_utility bunsan/utility bunsan_process)
add_bunsan_project(bunsan_crypto bunsan/crypto botan bunsan_common)
add_bunsan_project(bunsan_pm bunsan/pm
    bunsan_common_python
    bunsan_crypto
    bunsan_utility
)
add_bunsan_project(bunsan_broker bunsan/broker
    bunsan_crypto
    bunsan_pm
    bunsan_protobuf
)
add_bunsan_project(bunsan_bacs_common bunsan/bacs/common
    bunsan_common
    protobuf
)
add_bunsan_project(bunsan_bacs_problem bunsan/bacs/problem
    bunsan_pm
    bunsan_protobuf
    bunsan_bacs_common
)
add_bunsan_project(bunsan_bacs_problem_single
                   bunsan/bacs/problem_plugins/single
    bunsan_bacs_problem
)
add_bunsan_project(bunsan_bacs_problems bunsan/bacs/problems
    bunsan_bacs_problem_single
)
