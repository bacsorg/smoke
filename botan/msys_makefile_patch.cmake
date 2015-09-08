file(READ ${BOTAN_SOURCE_ROOT}/Makefile MAKEFILE)
string(REGEX REPLACE "\\\\([^\r\n])" "/\\1" MAKEFILE "${MAKEFILE}")
file(WRITE ${BOTAN_SOURCE_ROOT}/Makefile "${MAKEFILE}")
