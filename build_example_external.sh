#!/bin/bash

# This script can be called from anywhere and allows to build out of source.

# Determine script absolute path
SCRIPT_ABS_PATH=$(readlink -f ${BASH_SOURCE[0]})
SCRIPT_ABS_PATH=$(dirname ${SCRIPT_ABS_PATH})

# switch to script path
cd ${SCRIPT_ABS_PATH}

# Choose build type
BUILD_TYPE=Release
BUILD_TYPE=Debug

# Choose build type
BUILD_DIR=_build

# Choose install folder
INSTALL_DIR=_install

# Options summary
echo ""
echo "BUILD_TYPE  =" ${BUILD_TYPE}
echo "BUILD_DIR   =" ${SCRIPT_ABS_PATH}/example_external/${BUILD_DIR}/
echo "INSTALL_DIR =" ${SCRIPT_ABS_PATH}/example_external/${INSTALL_DIR}/
echo ""


# ------------------------------
# example_external (for testing)
# ------------------------------
printf "\n\n ----- example_external ----- \n\n"

# clean
# rm -fr example_external/${BUILD_DIR}

SO=`uname`
if [[ $SO == "Linux" ]]; then
    echo "Running on Linux"

    # cmake
    cmake \
        -S ${SCRIPT_ABS_PATH}/example_external/ \
        -B ${SCRIPT_ABS_PATH}/example_external/${BUILD_DIR} \
        -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
        -DFoo_DIR="${SCRIPT_ABS_PATH}/${INSTALL_DIR}/lib/cmake/Foo/"

    # compile
    cmake \
        --build ${SCRIPT_ABS_PATH}/example_external/${BUILD_DIR} \
        -j 8

else
    echo "Running on Windows"

    # cmake
    cmake \
        -S ${SCRIPT_ABS_PATH}/example_external/ \
        -B ${SCRIPT_ABS_PATH}/example_external/${BUILD_DIR} \
        -DFoo_DIR="${SCRIPT_ABS_PATH}/${INSTALL_DIR}/lib/cmake/Foo/"

    # compile
    cmake \
        --build ${SCRIPT_ABS_PATH}/example_external/${BUILD_DIR} \
        --config ${BUILD_TYPE} \
        -j 8
fi


# run
BIN_PATH=${SCRIPT_ABS_PATH}/example_external/${BUILD_DIR}
echo ${BIN_PATH}/${BUILD_TYPE}/
if [ -d "${BIN_PATH}/${BUILD_TYPE}" ]; then  # multi-config generator
   BIN_PATH=${BIN_PATH}/${BUILD_TYPE}
fi
${BIN_PATH}/bar
