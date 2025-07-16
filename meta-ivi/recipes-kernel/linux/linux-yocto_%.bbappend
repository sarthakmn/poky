FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://def.cfg"

KERNEL_CONFIG_FRAGMENTS += "file://def.cfg"

