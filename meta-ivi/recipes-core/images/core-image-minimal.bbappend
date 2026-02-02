# Add aplay util
IMAGE_INSTALL += "alsa-utils"

# Add basic linux utils like lsblk,dmesg,umount,mount
IMAGE_INSTALL += "util-linux"

# libs which will be the part of sdk
TOOLCHAIN_TARGET_TASK += "alsa-lib-dev"

# Add audio data to add metadata at /etc/res/
IMAGE_INSTALL += "audio audio-data"
IMAGE_INSTALL:append = " kernel-modules"

# Add support for serial login terminal
IMAGE_INSTALL:append = " systemd-serialgetty"

# Force splash components
IMAGE_INSTALL:append = " boot-animation coreutils"

# Qt6 and graphics support
IMAGE_INSTALL:append = " qtbase qtdeclarative"
IMAGE_INSTALL:append = " libgles2 libgbm libdrm"
IMAGE_INSTALL:append = " hmi-ivi"
