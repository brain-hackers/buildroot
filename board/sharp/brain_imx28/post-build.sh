#!/usr/bin/env bash

append_inittab()
{
	# --forward: don't reverse-apply
	# -r -: discard rejected hunk
	# -p 0: respect the entire path
	patch --forward -r - -p 0 < board/sharp/brain_imx28/inittab.patch || true
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
	promote_haveged_initscript
	exit $?
}

main $@
