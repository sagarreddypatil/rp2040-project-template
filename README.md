# RP2040 Project Template

## Usage

### Dependencies

- `git` (to clone this repo)
- `make` (for running CMake)
- `ninja` (CMake backend)
- `cmake` (build system)
- `compdb` (compile database for headers, optional)
- `gcc-arm-none-eabi` (compiler)
- `ccache` (compiler cache, optional)
- `newlib-arm-none-eabi` (C standard library)

### Cloning this Repo

Just clone it like you normally would

## Building

Run `make` or `make build` for a debug build, or `make release` for a release build.
`make clean` will delete the build folder.

Output binaries for each board will be present in `build/bin/`. ELF binaries can
be found in `build/bin/elf/`
