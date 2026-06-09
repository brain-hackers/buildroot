#!/usr/bin/env bash

append_inittab()
{
	# --forward: don't reverse-apply
	# -r -: discard rejected hunk
	# -p 0: respect the entire path
	patch --forward -r - "${TARGET_DIR}/etc/inittab" < board/sharp/brain_imx28/inittab.patch
}


install_securetty()
{
	# BusyBox is compiled with CONFIG_FEATURE_SECURETTY=y.  Without /etc/securetty
	# root login is silently denied on every terminal.  Create the file listing
	# the consoles used on SHARP Brain devices.
        cat > "${TARGET_DIR}/etc/securetty" <<'EOF'
console
tty1
ttyAMA0
EOF
}

promote_haveged_initscript()
{
	# haveged initializes at S21 by default. Move it to S10 so it starts before
	# S20seedrng, which blocks on getrandom(2) until the CRNG is seeded.
	mv "${TARGET_DIR}/etc/init.d/S21haveged" "${TARGET_DIR}/etc/init.d/S10haveged"
}

main()
{
	append_inittab
	install_securetty
	promote_haveged_initscript
	exit $?
}

main $@
