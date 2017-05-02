# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit linux-mod linux-info eutils

DESCRIPTION="Exar XR21V1410 series UART to USB kernel drivers [2.6.18 - 3.4.x] "
HOMEPAGE="https://www.exar.com/product/interface/uarts/usb-uarts/xr21v1410"
SRC_URI="https://www.exar.com/content/document.ashx?id=21652 -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

MODULE_NAMES="xr_usb_serial_common(misc:${S})"
BUILD_TARGETS="clean all"

DEPEND="
	app-arch/unzip
"

pkg_setup() {
	if kernel_is -gt 3 4; then
		ewarn "This module only works with kernel versions 2.6.18 to 3.4.x"
		die
	fi
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"

}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mkdir "${P}"
	mv `find ${WORKDIR}/* -type f` "${P}"
}

src_install() {
	linux-mod_src_install
	dodoc README.txt
}
