function getDirs() {
	local srcDir=$1

	cd ${srcDir}
	ls -d */
}
