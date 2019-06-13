#!/bin/bash

function help_message() {
    echo ""
    echo "Usage:"
    echo "  ./install.bash <install-prefix> <vcpkg-root-dir> [vcpkg-cmake-toolchain-file] [vcpkg-executable]"
    echo ""
    echo "Examples:"
    echo '  ./install.bash "${HOME}/.local" "${HOME}/vcpkg"' 
    echo '  ./install.bash "${HOME}/.local" "${HOME}/vcpkg" scripts/buildsystems/vcpkg.cmake' 
    echo '  ./install.bash "${HOME}/.local" "${HOME}/vcpkg" scripts/buildsystems/vcpkg.cmake vcpkg' 
    echo ""
}

if [ "${#}" -lt 2 ] ; then
    help_message
    exit 1
fi

# TODO: Could add auto detection for vcpkg-root-dir,
# by inspecting the file ${HOME}/.vcpkg/vcpkg.path.txt
install_prefix="${1}"
vcpkg_root_dir="${2}"
vcpkg_cmake_toolchain_file="${3-scripts/buildsystems/vcpkg.cmake}"
vcpkg_executable="${4-vcpkg}"


# Join paths: vcpkg_root_dir + file
vcpkg_cmake_toolchain_file="${vcpkg_root_dir%%+(/)}${vcpkg_root_dir:+/}${vcpkg_cmake_toolchain_file}"
vcpkg_executable="${vcpkg_root_dir%%+(/)}${vcpkg_root_dir:+/}${vcpkg_executable}"

# Escape paths
vcpkg_cmake_toolchain_file_escaped=`printf -- '%s' "${vcpkg_cmake_toolchain_file}" | sed 's@/@\\\/@g'`
vcpkg_executable_escaped=`printf -- '%s' "${vcpkg_executable}" | sed 's@/@\\\/@g'`

# Try create directory if the installation prefix doesn't exist
if [ ! -e "${install_prefix}/bin" ] ; then
    mkdir -p "${install_prefix}/bin" >/dev/null
fi

# Check if installation prefix is a directory,
# since it might has be occupied already.
# TODO: Redirect to stderr is needed
if [ ! -d "${install_prefix}/bin" ] ; then
    echo "[error] invalid install-prefix: ${install_prefix}"
    exit 1
fi

if ! cp -a ./bin/. "${install_prefix}/bin" ; then
    echo "[error] install failed"
    exit 1
fi

function install_script() {
    sed -i "s/@DEFAULT_VCMAKE_VCPKG_EXECUTABLE@/${vcpkg_executable_escaped}/g ; s/@DEFAULT_VCMAKE_VCPKG_CMAKE_TOOLCHAIN_FILE@/${vcpkg_cmake_toolchain_file_escaped}/g" "${@}"
}

if ! install_script "${install_prefix}/bin/vcmake" ; then
    echo "[error] install failed"
    exit 1
fi

if ! install_script "${install_prefix}/bin/vcpkg" ; then
    echo "[error] install failed"
    exit 1
fi
