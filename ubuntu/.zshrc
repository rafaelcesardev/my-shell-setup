# ===========================================
# Zsh Shell Configuration (Ubuntu)
# ===========================================

# ===========================================
# History (defaults parecidos com o fish)
# ===========================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE INC_APPEND_HISTORY
setopt INTERACTIVE_COMMENTS              # permite '# comentario' ao colar comandos

# ===========================================
# Completion
# ===========================================
autoload -Uz compinit && compinit

# ===========================================
# Autosuggestions  (sugestao cinza vinda do historico/completion)
# ===========================================
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)   # imita o fish (history + completion)

# ===========================================
# Ferramentas interativas
# ===========================================
eval "$(starship init zsh)"          # prompt
eval "$(zoxide init zsh)"            # smart cd
cd() {                               # override: cria a pasta e pula com zoxide
    [ -n "$1" ] && mkdir -p "$1"
    z "$@"
}

# FZF (fuzzy finder) - instalado via git em ~/.fzf (versao recente p/ 'fzf --zsh')
export PATH="$HOME/.fzf/bin:$PATH"
export FZF_DEFAULT_OPTS="--style full --no-clear"
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always {}'"   # no Ubuntu o bat e 'batcat'
export FZF_CTRL_R_OPTS=""
source <(fzf --zsh)

# ===========================================
# Audio (WSLg PulseAudio) - so aplica no WSL
# ===========================================
[ -e /mnt/wslg/PulseServer ] && export PULSE_SERVER=/mnt/wslg/PulseServer

# ===========================================
# PATH
# ===========================================
# pnpm (no Ubuntu o home e ~/.local/share/pnpm)
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in *":$PNPM_HOME:"*) ;; *) export PATH="$PNPM_HOME:$PATH" ;; esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"   # completions do bun

# uv / local bin
export PATH="$HOME/.local/bin:$PATH"

# fnm (Node version manager - substitui o nvm; --use-on-cd troca a versao por pasta)
export PATH="$HOME/.local/share/fnm:$PATH"
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd)"

# ===========================================
# Aliases - System
# ===========================================
alias cls='clear'
alias mkdir='mkdir -pv'
alias bat='batcat'          # no Ubuntu o pacote bat instala o binario como 'batcat'
alias ls='eza --color --long --git --no-filesize --icons --no-time --no-user --no-permissions'

# ===========================================
# Aliases - APT Package Manager
# ===========================================
alias i='sudo apt install'
alias i-get='sudo apt-get install'
alias upd='sudo apt update && sudo apt upgrade -y'
alias clean='sudo apt-get autoremove && sudo apt-get autoclean && sudo apt-get clean'

# ===========================================
# Aliases - Zsh Config
# ===========================================
alias f5='source ~/.zshrc'

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

# ===========================================
# Syntax highlighting
# DEVE ser a ULTIMA linha do arquivo - pinta a 1a palavra de
# verde (comando existe) ou vermelho (nao existe)
# ===========================================
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
