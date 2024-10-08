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

Just clone it like you normally would. There are no submodules. Dependencies are cloned in the
Makefile

## Building

Run `make` or `make build` for a debug build, or `make release` for a release build.
`make clean` will delete the build folder.

If you changed a dependency version in the `Makefile`, run `make clean-deps` to force
redownload on the next build

Output binary will be `build/bin/program.uf2`, and the ELF file can be found in
as `build/bin/elf/program.elf`