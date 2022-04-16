#!/bin/sh

usage() {
	echo "Usage: $0 -a"
	echo "       $0 -e pattern [pattern ...]"
	echo "       $0 pattern [pattern ...]"
	exit 1
}

MAP_FILE="map.txt"
PARSE_TEMPLATE="bin/parse-template.sh"
PATTERN=""
GREP_OPTIONS="-qE"

WHICH="/usr/bin/which"
CP="$(${WHICH} cp)"
GREP="$(${WHICH} grep)"
SED="$(${WHICH} sed)"

# parse command line arguments and generate a extended grep pattern
if [ $# -eq 0 ]; then
	usage
else
	case "$1" in
	-a)
		PATTERN=".*"
		shift
		;;
	-e)
		GREP_OPTIONS="${GREP_OPTIONS} -v"
		shift
		;;
	-*)
		usage
		;;
	*)
		PATTERN="$1"
		shift
		;;
	esac

	for i in "$@"; do
		# escape -'s
		i=$(echo "$i" | "$SED" 's/-/\\-/')
		if [ -z "$PATTERN" ]; then
			PATTERN="$i"
		else
			PATTERN="$PATTERN|$i"
		fi
	done
fi

while read src dest; do
	# expand src and dest so that their contents can be expanded by
	# the shell later
	src=$(eval echo $src)
	dest=$(eval echo $dest)

	# only process file if "file" string matches the src name
	echo "$src" | "$GREP" $GREP_OPTIONS "$PATTERN"
	if [ $? -eq 0 ]; then
		case "$src" in
		*.template)
			"$PARSE_TEMPLATE" "$src" > "$dest"
			echo "'${src%.template}' -> '$dest'"
			;;
		*)
			"$CP" -v "$src" "$dest"
			;;
		esac
	fi
done < "$MAP_FILE"
