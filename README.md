# LonganPi-3H-SDK
Scripts and blobs for LonganPi 3H image build.
> Tested on Ubuntu 22.04.2 LTS and WSL2 Ubuntu-22.04

## Command Line Build

0. Install some dependencies
```shell
sudo apt update
sudo apt install qemu-user-static gcc-aarch64-linux-gnu mmdebstrap git binfmt-support make build-essential  bison flex make gcc libncurses-dev debian-archive-keyring swig libssl-dev bc python3-setuptools
```

1. Build arm-trusted-firmware
```shell
./mkatf.sh
```

2. Build uboot
```shell
./mkuboot.sh
```

3. Build kernel
```shell
./mklinux.sh
```

4. Build rootfs

```shell
# for Debian desktop
sudo ./mkrootfs-debian-gui.sh

# for Debian without gui
# sudo ./mkrootfs-debian-cli.sh

# for Ubuntu without gui
# sudo ./mkrootfs-ubuntu-cli.sh
```

## Docker build

If you have `make` and `docker` installed you can also build the image with docker. The `Makefile` has four targets that you can use:

```shell
# Just build the build-container
make build

# Build Debian desktop image
make debiangui

# Build Debian image without gui
make debiancli

# Build Ubuntu image without gui
make ubuntucli
```
An `out/` folder will be created which is mounted into the container and the image `.tar` files will be copied in there.

From there you can follow https://wiki.sipeed.com/hardware/en/longan/h618/lpi3h/7_develop_mainline.html to create a boot card.

**Note:** The container to execute the actual image build is run with the `--privileged` flag (due to `quemu` usage). If you cannot run privileged containers in your environment then the docker build will most likely not work for you.

