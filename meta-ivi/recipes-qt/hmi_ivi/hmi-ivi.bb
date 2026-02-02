SUMMARY = "Qt6 IVI HMI Application"
LICENSE = "CLOSED"

SRC_URI = " \
    file://main.cpp \
    file://main.qml \
    file://CMakeLists.txt \
    file://qml.qrc \
    file://hmi-ivi.sh \
    file://hmi-ivi.service \
"

S = "${WORKDIR}"

inherit cmake qt6-cmake systemd

DEPENDS += " \
    qtbase \
    qtdeclarative \
    qttools-native \
"

RDEPENDS:${PN} += " \
    qtbase \
    qtdeclarative \
"

EXTRA_OECMAKE += "-DCMAKE_BUILD_TYPE=Release"

SYSTEMD_SERVICE:${PN} = "hmi-ivi.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install:append() {
    install -d ${D}${bindir}
    install -d ${D}${systemd_unitdir}/system
    install -m 0755 ${WORKDIR}/hmi-ivi.sh ${D}${bindir}/hmi-ivi.sh
    install -m 0644 ${WORKDIR}/hmi-ivi.service ${D}${systemd_unitdir}/system/hmi-ivi.service
}

FILES:${PN} += "${systemd_unitdir}/system/hmi-ivi.service"

