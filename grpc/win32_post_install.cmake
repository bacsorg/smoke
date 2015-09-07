file(GLOB grpc_dlls
     ${BUNSAN_SMOKE_ROOT}/lib/libgpr*.dll*
     ${BUNSAN_SMOKE_ROOT}/lib/libgrpc*.dll*)
file(MAKE_DIRECTORY ${BUNSAN_SMOKE_ROOT}/bin)
file(COPY ${grpc_dlls} DESTINATION ${BUNSAN_SMOKE_ROOT}/bin)
