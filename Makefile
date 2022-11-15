SRCPATH     := $(shell pwd)
ARCH        := $(shell ./archtype.sh)
OS_TYPE     := $(shell ./ostype.sh)


default: build


crypto/libs/$(OS_TYPE)/$(ARCH)/lib/libsodium.a:
	mkdir -p crypto/copies/$(OS_TYPE)/$(ARCH)
	cp -R crypto/libsodium-fork crypto/copies/$(OS_TYPE)/$(ARCH)/libsodium-fork
	cd crypto/copies/$(OS_TYPE)/$(ARCH)/libsodium-fork && \
		./autogen.sh --prefix $(SRCPATH)/crypto/libs/$(OS_TYPE)/$(ARCH) && \
		./configure --disable-shared --prefix="$(SRCPATH)/crypto/libs/$(OS_TYPE)/$(ARCH)" && \
		$(MAKE) && \
		$(MAKE) install


build: crypto/libs/$(OS_TYPE)/$(ARCH)/lib/libsodium.a


clean:
	cd crypto/libsodium-fork && \
		test ! -e Makefile || make clean
	rm -rf crypto/libs
	rm -rf crypto/copies


# clean without crypto
cleango:
	go clean -i ./...
