# My Terminal Setup — Zsh · Bash · Fish

Reproducible terminal for **macOS, Linux and WSL**, built on **[Homebrew](https://brew.sh)** with a
modern CLI toolkit and the [`starship`](https://starship.rs) prompt. Copy-paste config files get you
a ready-to-use **Node + Python + Git** environment in minutes.

**Philosophy:** *if `brew` can install it, we use `brew`.* One package manager across all three
operating systems — the only per-OS difference is Docker.

## Structure

```
config/
  .zshrc          # Zsh config
  .bashrc         # Bash config
  config.fish     # Fish config
  starship.toml   # shared prompt config (all shells)
setup-guide.md    # ordered, step-by-step setup
```

The configs are platform-agnostic: Homebrew is detected at `/opt/homebrew`, `/usr/local`, or
`/home/linuxbrew/.linuxbrew`, so the same `.zshrc` works on a Mac, an Ubuntu box, or a WSL distro.

## Included tools

- [`starship`](https://starship.rs) — cross-shell prompt
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) — smart directory jumper
- [`fzf`](https://github.com/junegunn/fzf) — fuzzy finder
- [`eza`](https://github.com/eza-community/eza) — modern `ls`
- [`bat`](https://github.com/sharkdp/bat) — `cat` with syntax highlighting
- [`fnm`](https://github.com/Schniz/fnm) — fast Node version manager
- [`pnpm`](https://pnpm.io) — fast Node package manager
- [`bun`](https://bun.sh) — JavaScript runtime + toolkit
- [`uv`](https://docs.astral.sh/uv) — fast Python / package manager
- [`git`](https://git-scm.com) — version control
- [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) — Fish-style autosuggestions (Zsh)
- [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) — command-validity highlighting (Zsh)

| Shell | Autosuggestions | Syntax highlighting |
| :---- | :-------------: | :-----------------: |
| Zsh   | ✓ (brew plugin) | ✓ (brew plugin)     |
| Fish  | ✓ built-in      | ✓ built-in          |
| Bash  | —               | —                   |

## Quick start

```sh
# 1. install Homebrew (skip if you have it)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. install the toolkit
brew install starship zoxide fzf eza bat fnm pnpm bun uv \
  zsh-autosuggestions zsh-syntax-highlighting git

# 3. drop in your shell config (pick one) + the shared prompt
mkdir -p ~/.config && cp config/starship.toml ~/.config/starship.toml
cp config/.zshrc ~/.zshrc                                       # Zsh
# cp config/.bashrc ~/.bashrc                                   # Bash
# mkdir -p ~/.config/fish && cp config/config.fish ~/.config/fish/config.fish   # Fish
```

Then finish Node, Python, Docker, Git and SSH by following the full guide:

**→ [setup-guide.md](setup-guide.md)**

## Docker

| OS | Install |
| :--- | :--- |
| macOS | `brew install --cask orbstack` |
| Linux (desktop) | [Docker Desktop for Linux](https://docs.docker.com/desktop/setup/install/linux/) (native — Homebrew Cask is macOS-only) |
| WSL | `brew install docker` (client; use Docker Desktop's WSL integration or a local `dockerd`) |
