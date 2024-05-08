# This is a hybrid Makefile - it is meant run on the host to kick-off the docker container build
# but it's also used inside the container to perform the actual build steps.
# The make targets that are meatn to be run inside the container have the suffix "incontainer"

TAG := longanpi3h-build:latest
OUTPUT_DIR := /LonganPi-3H-SDK/out

# Targets that are meant to be run on the host
build:
	mkdir -p out/
	mkdir -p certs
	cp /usr/local/share/ca-certificates/* certs/
	docker build --progress=plain -t ${TAG} .

debiancli: build
	docker run --rm -v $(shell pwd)/out:${OUTPUT_DIR} --privileged ${TAG} debcliincontainer

debiangui: build
	docker run --rm -v $(shell pwd)/out:${OUTPUT_DIR} --privileged ${TAG} debguiincontainer

ubuntucli: build
	docker run --rm -v $(shell pwd)/out:${OUTPUT_DIR} --privileged ${TAG} ubcliincontainer

# Targets that are meant to be run inside the container
baseincontainer:
	update-binfmts --enable
	./mkatf.sh
	./mkuboot.sh
	./mklinux.sh

debcliincontainer: baseincontainer
	./mkrootfs-debian-cli.sh
	cp build/rootfs* ${OUTPUT_DIR}

debguiincontainer: baseincontainer
	./mkrootfs-debian-gui.sh
	cp build/rootfs* ${OUTPUT_DIR}

ubcliincontainer: baseincontainer
	./mkrootfs-ubuntu-cli.sh
	cp build/rootfs* ${OUTPUT_DIR}

