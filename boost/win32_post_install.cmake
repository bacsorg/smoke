file(GLOB boost_dlls ${BUNSAN_SMOKE_ROOT}/lib/libboost*.dll)
file(MAKE_DIRECTORY ${BUNSAN_SMOKE_ROOT}/bin)
file(COPY ${boost_dlls} DESTINATION ${BUNSAN_SMOKE_ROOT}/bin)
