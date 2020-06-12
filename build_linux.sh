#!/bin/bash

# This script can be called from anywhere and allows to build out of source.

# Determine script absolute path
SCRIPT_ABS_PATH=$(readlink -f ${BASH_SOURCE[0]})
SCRIPT_ABS_PATH=$(dirname ${SCRIPT_ABS_PATH})

# switch to script path
cd ${SCRIPT_ABS_PATH}

# Choose build type
BUILD_TYPE=Release
# BUILD_TYPE=Debug

# Choose build type
BUILD_DIR=_build

# Choose install folder
INSTALL_DIR=_install

# Options summary
echo ""
echo "BUILD_TYPE  =" ${BUILD_TYPE}
echo "BUILD_DIR   =" ${SCRIPT_ABS_PATH}/${BUILD_DIR}/
echo "INSTALL_DIR =" ${SCRIPT_ABS_PATH}/${INSTALL_DIR}/
echo ""


# clean
# rm -fr ${BUILD_DIR} ${INSTALL_DIR}

# cmake
cmake \
    -S . \
    -B ${BUILD_DIR} \
    -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}"

# compile & install
cmake \
    --build ${BUILD_DIR} \
    --target install \
    -j 8
