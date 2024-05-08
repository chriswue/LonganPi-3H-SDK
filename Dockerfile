FROM ubuntu:22.04

ADD . /LonganPi-3H-SDK

RUN apt update && apt install -y \
        gcc-aarch64-linux-gnu mmdebstrap git binfmt-support make build-essential \
        kmod bison flex gcc libncurses-dev debian-archive-keyring swig libssl-dev \
        bc python3-setuptools python3-dev qemu-user-static

# stop git from complaining
RUN git config --global user.email "pi3h@container.local"
RUN git config --global user.name "Local Container Build"

WORKDIR /LonganPi-3H-SDK/
RUN chmod +x *.sh

ENTRYPOINT [ "make" ]