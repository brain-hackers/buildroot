#!/usr/bin/env bash

append_inittab()
{
	# --forward: don't reverse-apply
	# -r -: discard rejected hunk
	# -p 0: respect the entire path
	patch --forward -r - -p 0 < board/sharp/brain_imx28/inittab.patch || true
}

main()
{
	append_inittab
	exit $?
}

main $@
