SUMMARY = "Custom framebuffer boot animation using 30 PNG frames"
DESCRIPTION = "Renders 30 raw frames to /dev/fb0"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = " \
    file://boot-animation.sh \
    file://boot-animation.service \
    file://frames/ \
"

S = "${WORKDIR}"

inherit systemd

SYSTEMD_SERVICE:${PN} = "boot-animation.service"
SYSTEMD_AUTO_ENABLE = "enable"

FILES:${PN} += "/usr/share/boot-animation/frames/ /usr/bin/boot-animation.sh ${systemd_system_unitdir}/boot-animation.service"

do_install() {
    # Frames
    install -d ${D}/usr/share/boot-animation/frames
    cp -r ${WORKDIR}/frames/* ${D}/usr/share/boot-animation/frames/

    # Script
    install -d ${D}/usr/bin
    install -m 0755 ${WORKDIR}/boot-animation.sh ${D}/usr/bin/boot-animation.sh

    # Systemd unit
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/boot-animation.service ${D}${systemd_system_unitdir}/
}
