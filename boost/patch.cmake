if(WIN32)
    file(APPEND ${BOOST_SOURCE_ROOT}/project-config.jam
         "using python : "
         "\"${BUNSAN_SMOKE_PYTHON2_VERSION}\" : "
         "\"${BUNSAN_SMOKE_PYTHON2_PREFIX}\" : "
         "\"${BUNSAN_SMOKE_PYTHON2_INCLUDE_DIR}\" : "
         "\"${BUNSAN_SMOKE_PYTHON2_LIBRARY_DIR}\" ;\n"
    )
endif()
file(APPEND ${BOOST_SOURCE_ROOT}/project-config.jam
     "using python : "
     "\"${BUNSAN_SMOKE_PYTHON3_VERSION}\" : "
     "\"${BUNSAN_SMOKE_PYTHON3_PREFIX}\" : "
     "\"${BUNSAN_SMOKE_PYTHON3_INCLUDE_DIR}\" : "
     "\"${BUNSAN_SMOKE_PYTHON3_LIBRARY_DIR}\" ;\n"
)
