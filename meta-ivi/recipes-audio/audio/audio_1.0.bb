SUMMARY = "Alsa Audio Interface"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://main.cpp \
    file://src/audio.cpp \
    file://inc/audio.h \
    file://CMakeLists.txt \
"

S = "${WORKDIR}"

inherit cmake

EXTRA_OECMAKE += "-DINCLUDE_DIR=${S}/inc"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 pfaudio ${D}${bindir}
}

FILES:${PN} += "${bindir}/pfaudio"

