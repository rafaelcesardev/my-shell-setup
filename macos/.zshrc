# ===========================================
# Zsh Shell Configuration (macOS)
# ===========================================

# --- Homebrew (Apple Silicon / Intel) ---
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
BREW_PREFIX="$(brew --prefix)"

# ===========================================
# History (defaults parecidos com o fish)
# ===========================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE INC_APPEND_HISTORY
setopt INTERACTIVE_COMMENTS              # permite '# comentario' ao colar comandos

# ===========================================
# Completion (necessario p/ a estrategia 'completion' do autosuggest)
# ===========================================
fpath=("$BREW_PREFIX/share/zsh/site-functions" $fpath)
autoload -Uz compinit && compinit

# ===========================================
# Autosuggestions  (sugestao cinza vinda do historico/completion)
# ===========================================
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
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

# FZF (fuzzy finder) - bat em vez de batcat (no macOS o binario e 'bat')
export FZF_DEFAULT_OPTS="--style full --no-clear"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
export FZF_CTRL_R_OPTS=""
source <(fzf --zsh)

# ===========================================
# PATH
# ===========================================
# pnpm (no macOS o home e ~/Library/pnpm; os binarios ficam em $PNPM_HOME/bin)
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in *":$PNPM_HOME/bin:"*) ;; *) export PATH="$PNPM_HOME/bin:$PATH" ;; esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"   # completions do bun

# uv / local bin
export PATH="$HOME/.local/bin:$PATH"

# fnm (Node version manager - substitui o nvm; --use-on-cd troca a versao por pasta)
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd)"

# ===========================================
# Aliases - System
# ===========================================
alias cls='clear'
alias mkdir='mkdir -pv'
alias ls='eza --color --long --git --no-filesize --icons --no-time --no-user --no-permissions'

# ===========================================
# Aliases - Homebrew (no lugar dos aliases de APT do fish)
# ===========================================
alias i='brew install'
alias upd='brew update && brew upgrade'
alias clean='brew cleanup'

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
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
