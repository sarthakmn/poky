SUMMARY = "Audio media files"
DESCRIPTION = "Installs MP3/WAV files to /etc/res"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://Hey_Ya.mp3 \
    file://california.wav \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/res
    install -m 0644 ${WORKDIR}/*.mp3 ${D}${sysconfdir}/res/
    install -m 0644 ${WORKDIR}/*.wav ${D}${sysconfdir}/res/
}

FILES:${PN} += "${sysconfdir}/res"

