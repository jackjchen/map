# conda compiler toolchains are inherently cross-compilers
# cmake requires extra configuration for this to keep it
# from mixing stuff from the system path into our life
# see:
#     https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-linux
#     https://github.com/AnacondaRecipes/libnetcdf-feedstock/blob/master/recipe/cross-linux.cmake
#     https://docs.conda.io/projects/conda-build/en/latest/resources/compiler-tools.html#an-aside-on-cmake-and-sysroots
#     
# You will want to pass -DCMAKE_TOOLCHAIN_FILE="<path here"> so that this
# gets loaded into cmake before other stuff gets fubar'd

# this one is important
set(CMAKE_SYSTEM_NAME Linux)

# the following two weren't documented at https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-linux
# so I commented them out from what I got at 
#     https://github.com/AnacondaRecipes/libnetcdf-feedstock/blob/master/recipe/cross-linux.cmake
## set(CMAKE_PLATFORM Linux)
## #this one not so much
## set(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
set(CMAKE_C_COMPILER $ENV{CC})
set(CMAKE_CXX_COMPILER $ENV{CXX})



# where is the target environment
#set(CMAKE_FIND_ROOT_PATH $ENV{PREFIX} $ENV{BUILD_PREFIX}/$ENV{HOST}/sysroot)
# PREFIX and BUILD_PREFIX are set by conda-build will hardcode for now
#set(CMAKE_FIND_ROOT_PATH /home/tims/miniconda3/envs/sparta /home/tims/miniconda3/envs/sparta/x86_64-conda_cos6-linux-gnu /home/tims/miniconda3/envs/sparta/x86_64-conda_cos6-linux-gnu/sysroot)


# try using CMAKE_SYSROOT instead because putting all of those paths in FIND_ROOT_PATH casuses them to be filtered from INCLUDE_DIRECTORIES
set(CMAKE_SYSROOT /home/tims/miniconda3/envs/sparta/x86_64-conda_cos6-linux-gnu/sysroot)
# without the following, cmake wasn't able to find 'make'
set(CMAKE_FIND_ROOT_PATH /home/tims/miniconda3/envs/sparta)
# with the sysroot and FIND_ROOT_PATH set, the 



# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# should we be setting CMAKE_FIND_ROOT_PATH_MODE_PACKAGE?
#set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
