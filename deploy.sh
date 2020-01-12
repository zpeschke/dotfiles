#!/bin/sh

map_file="map.txt"
parse_template="bin/parse-template.sh"

while read src dest; do
	# expand src and dest so that their contents can be expanded by
	# the shell later
	src=$(eval echo $src)
	dest=$(eval echo $dest)

	case "$src" in
	*.template)
		"$parse_template" "$src" > "$dest"
		echo "${src%.template} -> $dest"
		;;
	*)
		/bin/cp -v "$src" "$dest"
		;;
	esac
done < "$map_file"
