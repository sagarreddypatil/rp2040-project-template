CMAKE_FLAGS := -GNinja
CCACHE_EXISTS := $(shell command -v ccache 2> /dev/null)

ifdef CCACHE_EXISTS
    CMAKE_FLAGS += -DCMAKE_C_COMPILER_LAUNCHER=ccache
else
    $(warning ccache not found, build may be slower)
endif

all: build

host: CMAKE_FLAGS += -DPICO_PLATFORM=host
host: build

build: CMAKE_FLAGS += -DCMAKE_BUILD_TYPE=Debug
build: cmake

release: CMAKE_FLAGS += -DCMAKE_BUILD_TYPE=Release
release: cmake

cmake: deps build-folder
	@cd build && cmake $(CMAKE_FLAGS) .. --log-level=STATUS && ninja

build-folder:
	-@sh -c 'mkdir build 2>/dev/null || true'

clean:
	rm -rf build/

deps: external/pico-sdk

clean-deps:
	rm -rf external

external/pico-sdk:
	git clone --depth 1 --branch 2.0.0 https://github.com/raspberrypi/pico-sdk.git external/pico-sdk
	cd external/pico-sdk && git submodule update --init lib/tinyusb
	cd external/pico-sdk && git submodule update --init lib/mbedtls

.PHONY: 
	cmake