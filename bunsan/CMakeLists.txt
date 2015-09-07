include(ExternalProject)
macro(add_bunsan_project name path)
    ExternalProject_Add(${name}
        DOWNLOAD_COMMAND ""
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${path}
        CMAKE_ARGS
            ${BUNSAN_SMOKE_CMAKE_ARGS}
            -DENABLE_TESTS=OFF
            -DENABLE_WEB=${ENABLE_WEB}
        DEPENDS
            boost
            turtle
            ${ARGN}
    )
endmacro()

add_bunsan_project(bunsan_cmake cmake)
add_bunsan_project(bunsan_test test bunsan_cmake)
add_bunsan_project(bunsan_common common bunsan_test)
add_bunsan_project(bunsan_common_python common_python bunsan_common)
add_bunsan_project(bunsan_process process bunsan_common)
add_bunsan_project(bunsan_protobuf protobuf protobuf bunsan_common)
add_bunsan_project(bunsan_rpc rpc grpc bunsan_protobuf)
add_bunsan_project(bunsan_utility utility bunsan_process)
add_bunsan_project(bunsan_crypto crypto botan bunsan_common)
add_bunsan_project(bunsan_pm pm
    bunsan_common_python
    bunsan_crypto
    bunsan_utility
)
add_bunsan_project(bunsan_broker broker
    bunsan_crypto
    bunsan_pm
    bunsan_protobuf
)
add_bunsan_project(bunsan_bacs_common bacs/common
    bunsan_common
    protobuf
)
add_bunsan_project(bunsan_bacs_problem bacs/problem
    bunsan_pm
    bunsan_protobuf
    bunsan_bacs_common
)
add_bunsan_project(bunsan_bacs_problem_single
                   bacs/problem_plugins/single
    bunsan_bacs_problem
)
add_bunsan_project(bunsan_bacs_problems bacs/problems
    bunsan_bacs_problem_single
)
add_bunsan_project(bunsan_bacs_archive bacs/archive
    bunsan_bacs_problems
)
