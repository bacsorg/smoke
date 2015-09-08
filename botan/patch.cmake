file(APPEND ${BOTAN_SOURCE_ROOT}/src/build-data/os/mingw.txt  "build_shared yes\n")

file(READ ${BOTAN_SOURCE_ROOT}/src/scripts/install.py INSTALL_PY)
string(REPLACE "os.symlink" "shutil.copyfile" INSTALL_PY "${INSTALL_PY}")
file(WRITE ${BOTAN_SOURCE_ROOT}/src/scripts/install.py "${INSTALL_PY}")
