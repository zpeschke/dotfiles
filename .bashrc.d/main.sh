set -o vi

export PS1='\[\033[01;32m\]\u@\h\[\033[01;00m\]:\[\033[01;34m\]\w\[\033[01;33m\]$(git_branch)\[\033[01;00m\]$ '
export PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/go/bin:${PATH}"

export EDITOR=vi
export RIPGREP_CONFIG_PATH=~/.ripgreprc

export TERRAGRUNT_PROVIDER_CACHE=1
export TERRAGRUNT_PROVIDER_CACHE_DIR=~/.terragrunt
