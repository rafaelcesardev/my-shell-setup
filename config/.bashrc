# ===========================================
# Bash Shell Configuration
# Works on macOS, Linux and WSL (Homebrew everywhere)
#
# Note: Bash has no built-in autosuggestions / syntax highlighting
# (those are zsh-plugin / fish features). You still get the starship
# prompt, zoxide, fzf history search and all the aliases below.
# ===========================================

# --- Homebrew (macOS Apple Silicon / Intel, Linux / WSL) ---
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x "$HOME/.linuxbrew/bin/brew" ]; then
    eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
fi

# ===========================================
# History
# ===========================================
HISTFILE="$HOME/.bash_history"
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend              # append to history, don't overwrite it
shopt -s checkwinsize

# ===========================================
# Interactive tools
# ===========================================
eval "$(starship init bash)"         # prompt
eval "$(zoxide init bash)"          # smart cd
cd() {                              # override: create the dir, then jump with zoxide
    [ -n "$1" ] && mkdir -p "$1"
    z "$@"
}

# FZF (fuzzy finder) - bat preview (the binary is 'bat' on every Homebrew platform)
export FZF_DEFAULT_OPTS="--style full --no-clear"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
export FZF_CTRL_R_OPTS=""
eval "$(fzf --bash)"

# ===========================================
# WSL audio (WSLg PulseAudio) - no-op outside WSL
# ===========================================
[ -e /mnt/wslg/PulseServer ] && export PULSE_SERVER=/mnt/wslg/PulseServer

# ===========================================
# PATH
# ===========================================
# pnpm (home differs: ~/Library/pnpm on macOS, ~/.local/share/pnpm elsewhere)
if [ "$(uname)" = "Darwin" ]; then
    export PNPM_HOME="$HOME/Library/pnpm"
else
    export PNPM_HOME="$HOME/.local/share/pnpm"
fi
case ":$PATH:" in *":$PNPM_HOME:"*) ;; *) export PATH="$PNPM_HOME:$PATH" ;; esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# uv / local bin
export PATH="$HOME/.local/bin:$PATH"

# fnm (Node version manager; --use-on-cd switches version per folder)
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd)"

# ===========================================
# Aliases - System
# ===========================================
alias cls='clear'
alias mkdir='mkdir -pv'
alias ls='eza --color --long --git --no-filesize --icons --no-time --no-user --no-permissions'

# ===========================================
# Aliases - Homebrew
# ===========================================
alias i='brew install'
alias upd='brew update && brew upgrade'
alias clean='brew cleanup'

# ===========================================
# Aliases - Bash Config
# ===========================================
alias f5='source ~/.bashrc'

# ===========================================
# Aliases - Docker
# ===========================================
alias d='docker'
alias dps='docker ps'
alias ds='docker stop'
alias di='docker images'
alias dv='docker volume'
alias dex='docker exec -it'

# Docker Compose
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcs='docker compose stop'
alias dcr='docker compose restart'
alias dcl='docker compose logs'
alias dcps='docker compose ps'
alias dcb='docker compose build'
alias dcp='docker compose pull'
