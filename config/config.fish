# ===========================================
# Fish Shell Configuration
# Works on macOS, Linux and WSL (Homebrew everywhere)
#
# Fish ships autosuggestions + syntax highlighting built-in,
# so no extra plugins are needed.
# ===========================================

# --- Homebrew (macOS Apple Silicon / Intel, Linux / WSL) ---
for brewbin in /opt/homebrew/bin/brew /usr/local/bin/brew \
               /home/linuxbrew/.linuxbrew/bin/brew $HOME/.linuxbrew/bin/brew
    if test -x $brewbin
        $brewbin shellenv fish | source
        break
    end
end

# ===========================================
# Interactive tools
# ===========================================
starship init fish | source          # prompt
zoxide init fish | source            # smart cd
function cd                          # override: create the dir, then jump with zoxide
    test -n "$argv[1]"; and mkdir -p $argv[1]
    z $argv
end

# FZF (fuzzy finder) - bat preview (the binary is 'bat' on every Homebrew platform)
set -gx FZF_DEFAULT_OPTS "--style full --no-clear"
set -gx FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}'"
set -gx FZF_CTRL_R_OPTS ""
fzf --fish | source

# ===========================================
# WSL audio (WSLg PulseAudio) - no-op outside WSL
# ===========================================
test -e /mnt/wslg/PulseServer; and set -gx PULSE_SERVER /mnt/wslg/PulseServer

# ===========================================
# PATH
# ===========================================
# pnpm (home differs: ~/Library/pnpm on macOS, ~/.local/share/pnpm elsewhere)
if test (uname) = Darwin
    set -gx PNPM_HOME "$HOME/Library/pnpm"
else
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
end
fish_add_path $PNPM_HOME

# bun
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

# uv / local bin
fish_add_path $HOME/.local/bin

# fnm (Node version manager; --use-on-cd switches version per folder)
if type -q fnm
    fnm env --use-on-cd | source
end

# ===========================================
# Aliases - System
# ===========================================
alias cls 'clear'
alias mkdir 'mkdir -pv'
alias ls 'eza --color --long --git --no-filesize --icons --no-time --no-user --no-permissions'

# ===========================================
# Aliases - Homebrew
# ===========================================
alias i 'brew install'
alias upd 'brew update && brew upgrade'
alias clean 'brew cleanup'

# ===========================================
# Aliases - Fish Config
# ===========================================
alias f5 'source ~/.config/fish/config.fish'

# ===========================================
# Aliases - Docker
# ===========================================
alias d 'docker'
alias dps 'docker ps'
alias ds 'docker stop'
alias di 'docker images'
alias dv 'docker volume'
alias dex 'docker exec -it'

# Docker Compose
alias dc 'docker compose'
alias dcu 'docker compose up'
alias dcd 'docker compose down'
alias dcs 'docker compose stop'
alias dcr 'docker compose restart'
alias dcl 'docker compose logs'
alias dcps 'docker compose ps'
alias dcb 'docker compose build'
alias dcp 'docker compose pull'
