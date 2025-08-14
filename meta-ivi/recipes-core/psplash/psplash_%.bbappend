FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Use framebuffer directly instead of virtual provider
PACKAGECONFIG:append = " fbdev"
PACKAGECONFIG:remove = "systemd-only"
DEPENDS += "libdrm"

# Disable progress bar
EXTRA_OECONF += "--disable-progress-bar"

# File handling
FILES:${PN} += " \
    ${bindir}/psplash \
    ${systemd_system_unitdir}/psplash-start.service.d \
"

# Raspberry Pi specific
SPLASH_IMAGES:raspberrypi3-64 = "file://merc-img.h;outsuffix=raspberrypi"
SRC_URI:append:raspberrypi3-64 = " file://framebuf.conf"

# Systemd configuration
do_install:append:raspberrypi3-64() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}${systemd_system_unitdir}/psplash-start.service.d
        install -m 0644 ${WORKDIR}/framebuf.conf \
            ${D}${systemd_system_unitdir}/psplash-start.service.d/
    fi

    # Explicitly install the psplash binary
    install -m 0755 ${B}/psplash ${D}${bindir}/psplash
}
