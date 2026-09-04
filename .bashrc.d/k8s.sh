if which kubectl >/dev/null; then
	source <(kubectl completion bash)
	alias k=kubectl
	complete -o default -F __start_kubectl k
fi

if command -v helm 1>/dev/null; then
	# add bash completion for helm
	source <(helm completion bash)
fi
