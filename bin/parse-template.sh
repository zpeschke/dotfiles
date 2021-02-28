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
file="$1"

# template string to be build and printed if shell condition within the
# template is true
template_str=""

# 0 if out of template text, 1 if in template text
condition=0

# 0 if condition is false, 1 if condition is true
true=0

while read line; do
	case $line in
	\<%*%\>)
		# we are now within a template condition
		condition=1

		# remove prefix
		line="${line#<\%}"
		# remove suffix
		line="${line%\%>}"

		printf "$line" | /usr/bin/grep -q "^ *end *$"
		if [ $? -eq 0 ]; then
			printf "$template_str"
			true=0
			condition=0
			template_str=""
		else
			# test the condition provided in the template
			eval "test $line"
			if [ $? -eq 0 ]; then
				true=1
			fi	
		fi
		;;
	*)
		if [ $true -eq 1 ]; then
			template_str="${template_str}${line}\n"
		else
			if [ $condition -eq 0 ]; then
				echo $line
			fi	
		fi
		;;
	esac
done < "$file"
