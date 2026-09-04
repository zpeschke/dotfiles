git_branch() {
	local output=""
	local branch=$(git branch --show-current 2>/dev/null)
	if [ -n "$branch" ]; then
		output=" (${branch})"
	fi
	echo "$output"
}
