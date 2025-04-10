# my common bashrc settings

# This file is not necessarily meant to be copied entirely to ~/.bashrc.
# Instead, append the contents here to the existing ~/.bashrc.

set -o vi
export PATH="${HOME}/bin:${PATH}"

git_branch() {
	OUTPUT=""
	BRANCH=$(git branch --show-current 2>/dev/null)
	if [ $? -eq 0 ]; then
		OUTPUT=" (${BRANCH})"
	fi

	echo "${OUTPUT}"
}

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\]$(git_branch)\[\033[00m\]$ '

alias vi='vim'

if command -v helm 1>/dev/null; then
	# add bash completion for helm
	source <(helm completion bash)
fi

if command -v kubectl 1>/dev/null; then
	# add bash completion for kubectl
	source <(kubectl completion bash)

	# alias k to kubectl and allow bash completion
	alias k='kubectl'
	complete -F __start_kubectl k
fi
