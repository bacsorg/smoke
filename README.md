# Dependencies

- CMake >= 3
- GCC >= 5

Build under MSVC is not supported and unlikely will be (only if someone is willing to contribute).

# Linux instructions

## Prepare machine

`cmake>=3`, `python2` and `python3`, `perl`, `gcc>=5`, `autotools` must be available in PATH.

## Configure
`cmake ${path-so-sources}`

## Build
`make`

# Windows instructions

## Prepare machine

- [CMake 3](http://www.cmake.org/download/), availability in PATH is optional convenience
  for future cmake invocations
- [tdm-gcc](http://tdm-gcc.tdragon.net/download), make sure to select "Add to PATH".
  Choose native version, i.e. if you have 64bit OS, download `tdm64-gcc`
  and choose `MinGW-w64/TDM64` during installation.
- [Python 2 and 3](https://www.python.org/downloads/), if you install 32bit version,
  use `Python 2.7.9` (`Python 2.7.10` is broken on 32bit), if you install 64bit version,
  use `Python>=3.5` (`Python<3.5` is broken on 64bit).
  Make sure that python is not available in PATH.
- Install MS Visual C++ and add directory with MASM (`ml.exe` or `ml64.exe`
  depending on your OS architecture) to `PATH`, for example
  `C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin` or
  `C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64`
- [MSYS2](http://msys2.github.io/), if you install it to non-standard location,
  set `MSYS_BIN` manually, e.g. `cmake -DMSYS_BIN=C:\path\to\msys\bin`

## Configure
From build directory
- `cmake -G "MinGW Makefiles" -DUSE_MSYS=ON %path-to-sources%` if you don't have `sh.exe` in PATH,
- `cmake -G "MSYS Makefiles" -DUSE_MSYS=ON %path-to-sources%` if you have `sh.exe` in PATH.

## Build
From build directory
- `mingw32-make` if you didn't add MSYS2 to PATH
- `make` if you added MSYS2 to PATH
