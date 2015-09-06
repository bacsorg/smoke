file(APPEND ${GRPC_SOURCE_ROOT}/src/build-data/os/mingw.txt  "build_shared yes\n")

file(READ ${GRPC_SOURCE_ROOT}/src/core/support/string_win32.c STRING_WIN32_C)
string(REPLACE
       "#include <grpc/support/alloc.h>"
       "#include <grpc/support/alloc.h>\n#include <grpc/support/string_util.h>"
       STRING_WIN32_C "${STRING_WIN32_C}")
file(WRITE ${GRPC_SOURCE_ROOT}/src/core/support/string_win32.c "${STRING_WIN32_C}")

file(READ ${GRPC_SOURCE_ROOT}/Makefile MAKEFILE)
string(REPLACE "-Werror" "" MAKEFILE "${MAKEFILE}")
string(REPLACE "LIBS = m z pthread" "LIBS = m zlib pthread ws2_32" MAKEFILE "${MAKEFILE}")
string(REPLACE "OPENSSL_LIBS = ssl32 eay32" "OPENSSL_LIBS = ssleay32 eay32" MAKEFILE "${MAKEFILE}")
foreach(lib gpr grpc grpc_unsecure grpc++ grpc++_unsecure grpc_csharp_ext)
    string(REPLACE "/${lib}.$(SHARED_EXT)" "/lib${lib}.$(SHARED_EXT)" MAKEFILE "${MAKEFILE}")
endforeach()
file(WRITE ${GRPC_SOURCE_ROOT}/Makefile "${MAKEFILE}")

file(READ ${GRPC_SOURCE_ROOT}/include/grpc/support/port_platform.h PORT_PLATFORM_H)
string(REPLACE
       "#include <windows.h>"
       "#if defined(NOMINMAX)\n#undef NOMINMAX\n#endif\n#include <windows.h>"
       PORT_PLATFORM_H "${PORT_PLATFORM_H}")
file(WRITE ${GRPC_SOURCE_ROOT}/include/grpc/support/port_platform.h "${PORT_PLATFORM_H}")

file(READ ${GRPC_SOURCE_ROOT}/src/core/iomgr/sockaddr_win32.h SOCKADDR_WIN32_H)
string(REPLACE
       "__MINGW32__" "__MINGW32_TURNED_OFF_BY_BUNSAN_SMOKE__"
       SOCKADDR_WIN32_H "${SOCKADDR_WIN32_H}")
file(WRITE ${GRPC_SOURCE_ROOT}/src/core/iomgr/sockaddr_win32.h "${SOCKADDR_WIN32_H}")

file(READ ${GRPC_SOURCE_ROOT}/src/core/support/env_win32.c ENV_WIN32_C)
string(REGEX REPLACE
       "char \\*gpr_getenv\\(const char \\*name\\) \\{.*\\}"
       "char *gpr_getenv(const char *name) { return getenv(name); }"
       ENV_WIN32_C "${ENV_WIN32_C}")
file(WRITE ${GRPC_SOURCE_ROOT}/src/core/support/env_win32.c "${ENV_WIN32_C}")

file(READ ${GRPC_SOURCE_ROOT}/src/core/support/file_win32.c FILE_WIN32_C)
string(REPLACE
       "if (_tfopen_s(&result, tmp_filename, TEXT(\"wb+\")) != 0) goto end;"
       "if ((result = fopen(tmp_filename, \"wb+\")) != 0) goto end;"
       FILE_WIN32_C "${FILE_WIN32_C}")
file(WRITE ${GRPC_SOURCE_ROOT}/src/core/support/file_win32.c "${FILE_WIN32_C}")
