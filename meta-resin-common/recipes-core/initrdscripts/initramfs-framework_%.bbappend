FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://fsckext4 \
    file://machineid \
    file://resindataexpander \
    file://rorootfs \
    file://rootfs \
    file://finish \
    "

do_install_append() {
    install -m 0755 ${WORKDIR}/fsckext4 ${D}/init.d/87-fsckext4
    install -m 0755 ${WORKDIR}/rootfs ${D}/init.d/90-rootfs
    install -m 0755 ${WORKDIR}/finish ${D}/init.d/99-finish

    install -m 0755 ${WORKDIR}/machineid ${D}/init.d/91-machineid
    install -m 0755 ${WORKDIR}/resindataexpander ${D}/init.d/88-resindataexpander
    install -m 0755 ${WORKDIR}/rorootfs ${D}/init.d/89-rorootfs
}

PACKAGES_append = " \
    initramfs-module-fsckext4 \
    initramfs-module-machineid \
    initramfs-module-resindataexpander \
    initramfs-module-rorootfs \
    "

RRECOMMENDS_${PN}-base += "initramfs-module-rootfs"

SUMMARY_initramfs-module-fsckext4 = "Filesystem check for ext4 partitions"
RDEPENDS_initramfs-module-fsckext4 = "${PN}-base e2fsprogs-e2fsck"
FILES_initramfs-module-fsckext4 = "/init.d/87-fsckext4"

SUMMARY_initramfs-module-machineid = "Bind mount machine-id to rootfs"
RDEPENDS_initramfs-module-machineid = "${PN}-base initramfs-module-udev"
FILES_initramfs-module-machineid = "/init.d/91-machineid"

SUMMARY_initramfs-module-resindataexpander = "Expand the data partition to the end of device"
RDEPENDS_initramfs-module-resindataexpander = "${PN}-base initramfs-module-udev busybox parted bc util-linux-lsblk"
FILES_initramfs-module-resindataexpander = "/init.d/88-resindataexpander"

SUMMARY_initramfs-module-rorootfs = "Mount our rootfs"
RDEPENDS_initramfs-module-rorootfs = "${PN}-base"
FILES_initramfs-module-rorootfs = "/init.d/89-rorootfs"

SUMMARY_initramfs-module-rootfs = "initramfs support for locating and mounting the root partition"
RDEPENDS_initramfs-module-rootfs = "${PN}-base"
FILES_initramfs-module-rootfs = "/init.d/90-rootfs"
