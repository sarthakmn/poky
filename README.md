Poky enviroment to learn basics of YOCTO

Reset SD card :
sudo wipefs -a /dev/sda
sudo dd if=/dev/zero of=/dev/sda bs=1M count=10

Flash to SD card:
sudo umount /dev/sda*
ls tmp/deploy/images/beaglebone-yocto/*.rootfs.wic
sudo bmaptool copy tmp/deploy/images/beaglebone-yocto/*.rootfs.wic /dev/sda

Add cmd utils from busybox :
source oe-init-build-env BBB/
bitbake -c menuconfig busybox   <--- check for proper defconfig and change path
bitbake -c cleanall busybox
bitbake busybox
bitbake core-image-minimal

Add Utils :
add IMAGE_INSTALL:append = " alsa-utils" in core-image-minimal.bbappend

Add Development Package :
TOOLCHAIN_TARGET_TASK:append = " alsa-lib-dev" in core-image-minimal.bbappend
Build the sdk :
bitbake core-image-minimal -c populate_sdk
cd tmp/deploy/sdk/
chmod +x poky-*.sh
./poky-*.sh
source /opt/poky/4.0.28/environment-setup-cortexa8hf-neon-poky-linux-gnueabi

To see rootfs : tar -xjf core-image-minimal-beaglebone-yocto-20250714155140.rootfs.tar.bz2 -C ~/Desktop/rootfs/

Add New Layer :
cd poky/build/
bitbake-layers create-layer ../meta-sarthak
bitbake-layers add-layer ../meta-sarthak
local.conf :
# Add audio to image
IMAGE_INSTALL:append = " audio"
# Build image for below formats
IMAGE_FSTYPES += "wic ext4 tar.bz2"

Add kernel configs :
meta-ivi/
└── recipes-kernel/
    └── linux/
        ├── linux-yocto/
        │   └── usb-audio.cfg
        └── linux-yocto_%.bbappend

bitbake -e virtual/kernel | grep ^PN=
output will be : PN="linux-yocto"
mkdir -p ~/Desktop/yocto/poky/meta-ivi/recipes-kernel/linux/linux-yocto
vi usb-audio.cfg
Add kernel conf like : CONFIG_SND_USB=y and CONFIG_SND_USB_AUDIO=y
add in linux-yocto_%.bbappend :
FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"
SRC_URI += "file://def.cfg"

