#!/bin/sh
# Simple script to parse conditions within a template configuration
# file. Mainly used by me to distinguish between OpenBSD and Linux
# specific configurations.

usage() {
	echo "Usage: $0 file"
	exit 1
}

if [ $# -ne 1 ]; then
	usage
fi

# file we are parsing
FILE="$1"

# template string to be build and printed if shell condition within the
# template is true
TEMPLATE_STR=""

# 0 if out of template text, 1 if in template text
TEMPLATE_CONDITION=0

# 0 if template condition is false, 1 if template condition is true
TEMPLATE_CONDITION_TRUE=0

WHICH="/usr/bin/which"
GREP="$(${WHICH} grep)"

while read line; do
	case $line in
	\<%*%\>)
		# we are now within a template condition
		TEMPLATE_CONDITION=1

		# remove prefix
		line="${line#<\%}"
		# remove suffix
		line="${line%\%>}"

		printf "$line" | "$GREP" -q "^ *end *$"
		if [ $? -eq 0 ]; then
			printf "$TEMPLATE_STR"
			TEMPLATE_CONDITION_TRUE=0
			TEMPLATE_CONDITION=0
			TEMPLATE_STR=""
		else
			# test the condition provided in the template
			eval "test $line"
			if [ $? -eq 0 ]; then
				TEMPLATE_CONDITION_TRUE=1
			fi	
		fi
		;;
	*)
		if [ $TEMPLATE_CONDITION_TRUE -eq 1 ]; then
			TEMPLATE_STR="${TEMPLATE_STR}${line}\n"
		else
			if [ $TEMPLATE_CONDITION -eq 0 ]; then
				echo $line
			fi	
		fi
		;;
	esac
done < "$FILE"
