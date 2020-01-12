#!/bin/sh

usage() {
	echo "Usage: $0 -a"
	echo "       $0 file [file] [...]"
	exit 1
}

file=""
map_file="map.txt"
parse_template="bin/parse-template.sh"

# parse command line arguments
if [ $# -eq 0 ]; then
	usage
elif [ $# -eq 1 ]; then
	case "$1" in
	-a)
		file=".*"
		;;
	-*)
		usage
		;;
	*)
		file="$1"
		;;
	esac
else
	for i in "$@"; do
		# escape -'s
		i=$(echo "$i" | /usr/bin/sed 's/-/\\-/')
		if [ -z $file ]; then
			file="$i"
		else
			file="$file|$i"
		fi
	done
fi

while read src dest; do
	# expand src and dest so that their contents can be expanded by
	# the shell later
	src=$(eval echo $src)
	dest=$(eval echo $dest)

	# only process file if "file" string matches the src name
	echo "$src" | grep -qE "$file" 
	if [ $? -eq 0 ]; then
		case "$src" in
		*.template)
			"$parse_template" "$src" > "$dest"
			echo "${src%.template} -> $dest"
			;;
		*)
			/bin/cp -v "$src" "$dest"
			;;
		esac
	fi
done < "$map_file"
