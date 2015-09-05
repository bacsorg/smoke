file(APPEND ${GRPC_SOURCE_ROOT}/src/build-data/os/mingw.txt  "build_shared yes\n")

file(READ ${GRPC_SOURCE_ROOT}/src/core/support/string_win32.c STRING_WIN32_C)
string(REPLACE
       "#include <grpc/support/alloc.h>"
       "#include <grpc/support/alloc.h>\n#include <grpc/support/string_util.h>"
       STRING_WIN32_C "${STRING_WIN32_C}")
file(WRITE ${GRPC_SOURCE_ROOT}/src/core/support/string_win32.c "${STRING_WIN32_C}")

file(READ ${GRPC_SOURCE_ROOT}/Makefile MAKEFILE)
string(REPLACE "-Werror" "" MAKEFILE "${MAKEFILE}")
file(WRITE ${GRPC_SOURCE_ROOT}/Makefile "${MAKEFILE}")

file(READ ${GRPC_SOURCE_ROOT}/include/grpc/support/port_platform.h PORT_PLATFORM_H)
string(REPLACE
       "#include <windows.h>"
       "#if defined(NOMINMAX)\n#undef NOMINMAX\n#endif\n#include <windows.h>"
       PORT_PLATFORM_H "${PORT_PLATFORM_H}")
file(WRITE ${GRPC_SOURCE_ROOT}/include/grpc/support/port_platform.h "${PORT_PLATFORM_H}")
