# VCMake

VCMake is a toolset providing tools for using vcpkg with CMake.

## Prerequsite

### Operating Systems 

This project is tested on `Ubuntu 18.04.2`.

`Unix` based operating system with bash installed might work as well.

While support for `Windows` might come in the future.

### Package vcpkg

Install [vcpkg](https://github.com/microsoft/vcpkg) first.

```bash
cd ~
git clone https://github.com/microsoft/vcpkg
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg integrate install
```

## Install VCMake

Use fellowing commands to install vcmake.

```bash
git clone https://github.com/cy20lin/vcmake
cd vcmake
./install.bash ~/.local ~/vcpkg
```

## Using VCMake

### vcmake

A script named `vcmake` is installed at `<install-prefix>/bin` specified by the user.

This script forwards the arguments to the actual `cmake` executable. 
While configuring cmake project using `vcmake`, it forwards
the arguments passed by the user, and append vcpkg cmake toolchain file in the end automatically. 
Also, it remaps the definition of `CMAKE_TOOLCHAIN_FILE` to 
`VCPKG_CHAINLOAD_TOOLCHAIN_FILE`, so the user is able to use
vcmake as a drop-in replacement for cmake while configuring a cmake project, 
without special need and awareness of vcpkg configurations and definitions.

Originally:

```bash
cmake .. -DCMAKE_TOOLCHAIN_FILE=~/vcpkg/scripts/buildsystems/vcpkg.cmake
```

With vcmake, now it becomes:

```bash
vcmake .. 
```

### vcpkg

A script named `vcpkg` is installed at `<install-prefix>/bin` specified by the user.

This script forwards the arguments to the actual
vcpkg executable. After installation, the user is able to 
access `vcpkg` as a global command, without the need to specify full path to access vcpkg executable.

Examples:

```bash
vcpkg --help
```

## License

`VCMake` is licensed under [the MIT License](https://opensource.org/licenses/MIT).