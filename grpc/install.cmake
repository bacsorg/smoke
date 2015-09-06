file(GLOB bins ${GRPC_SOURCE_ROOT}/bins/opt/*)
file(INSTALL ${bins} DESTINATION ${BUNSAN_SMOKE_ROOT}/bin)

file(GLOB libs ${GRPC_SOURCE_ROOT}/libs/opt/*)
file(INSTALL ${libs} DESTINATION ${BUNSAN_SMOKE_ROOT}/lib)

file(GLOB includes ${GRPC_SOURCE_ROOT}/include/*)
file(INSTALL ${includes} DESTINATION ${BUNSAN_SMOKE_ROOT}/include)
