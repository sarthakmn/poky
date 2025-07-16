FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://defconfig"

do_configure:prepend() {
    install -m 0644 ${WORKDIR}/defconfig ${S}/.config
}

