#!/bin/bash

function setup() {
    export VCMAKE_CMAKE_EXECUTABLE=${BATS_TEST_DIRNAME}/stub/cmake
    export VCMAKE_VCPKG_EXECUTABLE=${BATS_TEST_DIRNAME}/stub/vcpkg
    export VCMAKE_VCPKG_CMAKE_TOOLCHAIN_FILE=${BATS_TEST_DIRNAME}/stub/vcpkg.cmake
}

function vcpkg() {
    "${BATS_TEST_DIRNAME}/../bin/vcpkg" "${@}"
}

function vcmake() {
    "${BATS_TEST_DIRNAME}/../bin/vcmake" "${@}"
}

function teardown() {
    true
}
