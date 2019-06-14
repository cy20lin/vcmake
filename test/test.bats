#!/usr/bin/env bats

load test_helper

@test "vcpkg args forwarding" {
    args=(
        "arg0"
        "arg1"
        "arg2"
        "arg3"
        "arg4"
        )
    run vcpkg "${args[@]}" 
    [ "${status}" -eq 0 ]
    [ "${lines[0]}" = "arg0" ]
    [ "${lines[1]}" = "arg1" ]
    [ "${lines[2]}" = "arg2" ]
    [ "${lines[3]}" = "arg3" ]
    [ "${lines[4]}" = "arg4" ]
}

@test "vcmake configure with one CMAKE_TOOLCHAIN_FILE and one VCPKG_CHAINLOAD_TOOLCHAIN_FILE defined" {
    args=(
        ".."
        "-DA=1"
        "-DB=2"
        "-DCMAKE_TOOLCHAIN_FILE=/tmp/a.cmake"
        "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/tmp/b.cmake"
        )
    run vcmake "${args[@]}" 
    [ "${status}" -eq 0 ]
    [ "${lines[0]}" = ".." ]
    [ "${lines[1]}" = "-DA=1" ]
    [ "${lines[2]}" = "-DB=2" ]
    [ "${lines[3]}" = "-DCMAKE_TOOLCHAIN_FILE=/tmp/a.cmake" ]
    [ "${lines[4]}" = "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/tmp/b.cmake" ]
    [ "${lines[5]}" = "-DCMAKE_TOOLCHAIN_FILE=${VCMAKE_VCPKG_CMAKE_TOOLCHAIN_FILE}" ]
}

@test "vcmake configure with one CMAKE_TOOLCHAIN_FILE defined" {
    args=(
        ".."
        "-DA=1"
        "-DB=2"
        "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/tmp/b.cmake"
        )
    run vcmake "${args[@]}" 
    # vcmake "${args[@]}" >&3
    [ "${status}" -eq 0 ]
    [ "${lines[0]}" = ".." ]
    [ "${lines[1]}" = "-DA=1" ]
    [ "${lines[2]}" = "-DB=2" ]
    [ "${lines[3]}" = "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/tmp/b.cmake" ]
    [ "${lines[4]}" = "-DCMAKE_TOOLCHAIN_FILE=${VCMAKE_VCPKG_CMAKE_TOOLCHAIN_FILE}" ]
}

@test "vcmake configure with one VCPKG_CHAINLOAD_TOOLCHAIN_FILE defined" {
    args=(
        ".."
        "-DA=1"
        "-DB=2"
        "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/tmp/b.cmake"
        )
    run vcmake "${args[@]}" 
    # vcmake "${args[@]}" >&3
    [ "${status}" -eq 0 ]
    [ "${lines[0]}" = ".." ]
    [ "${lines[1]}" = "-DA=1" ]
    [ "${lines[2]}" = "-DB=2" ]
    [ "${lines[3]}" = "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/tmp/b.cmake" ]
    [ "${lines[4]}" = "-DCMAKE_TOOLCHAIN_FILE=${VCMAKE_VCPKG_CMAKE_TOOLCHAIN_FILE}" ]
}

@test "vcmake configure with no CMAKE_TOOLCHAIN_FILE nor VCPKG_CHAINLOAD_TOOLCHAIN_FILE defined" {
    args=(
        ".."
        "-DA=1"
        "-DB=2"
        "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/tmp/b.cmake"
        )
    run vcmake "${args[@]}" 
    # vcmake "${args[@]}" >&3
    [ "${status}" -eq 0 ]
    [ "${lines[0]}" = ".." ]
    [ "${lines[1]}" = "-DA=1" ]
    [ "${lines[2]}" = "-DB=2" ]
    [ "${lines[3]}" = "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/tmp/b.cmake" ]
    [ "${lines[4]}" = "-DCMAKE_TOOLCHAIN_FILE=${VCMAKE_VCPKG_CMAKE_TOOLCHAIN_FILE}" ]
}