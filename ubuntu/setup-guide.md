# Zsh Setup — Ubuntu

Sets up a complete **Zsh** development environment on **Ubuntu** (Debian/apt; works on WSL too)
with modern CLI tools, plus the two features Zsh doesn't ship by default:

- **Autosuggestions** — a gray suggestion ahead of the cursor based on your history
  (accept with `→`). From [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions).
- **Syntax highlighting** — the first word turns **green** when the command exists and **red**
  when it doesn't. From [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting).

## Install Zsh and make it the default shell

```sh
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git zsh

chsh -s $(which zsh)
```

Log out and back in (or restart the terminal) for the default-shell change to take effect.

## Install the apt tools + Zsh plugins

```sh
sudo apt install -y zoxide bat zsh-autosuggestions zsh-syntax-highlighting
```

- `zoxide` – smart `cd`
- `bat` – cat with syntax highlighting (Ubuntu installs it as **`batcat`**; the `.zshrc` adds
  `alias bat='batcat'`)
- `zsh-autosuggestions`, `zsh-syntax-highlighting` – the two features above (the `.zshrc` loads
  them from `/usr/share/...`)

## Install [`fzf`](https://github.com/junegunn/fzf)

Cloned from git to get a recent version (the `.zshrc` uses `fzf --zsh`):

```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
```

The `.zshrc` adds `~/.fzf/bin` to `PATH`.

## Install [`eza`](https://github.com/eza-community/eza)

```sh
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

## Install [`starship`](https://starship.rs/)

```sh
curl -sS https://starship.rs/install.sh | sh

mkdir -p ~/.config
cp ubuntu/starship.toml ~/.config/starship.toml
```

Config file: [`starship.toml`](starship.toml)

## Install [`fnm`](https://github.com/Schniz/fnm) + Node

[`fnm`](https://github.com/Schniz/fnm) is a fast, Rust-based Node version manager. The `.zshrc`
adds `~/.local/share/fnm` to `PATH` and runs `eval "$(fnm env --use-on-cd)"`, which auto-switches
the Node version per project (`.node-version` / `.nvmrc`).

```sh
curl -fsSL https://fnm.vercel.app/install | bash

fnm install --lts
fnm default lts-latest
npm update -g npm
```

## Install [`pnpm`](https://pnpm.io/)

```sh
curl -fsSL https://get.pnpm.io/install.sh | sh -
```

On Ubuntu pnpm uses `~/.local/share/pnpm` as its home, which the `.zshrc` adds to `PATH`.

## Install [`bun`](https://bun.sh/)

```sh
sudo apt install -y unzip
curl -fsSL https://bun.sh/install | bash
```

### Bonus: AI Development Tools

```sh
bun i -g @anthropic-ai/claude-code @google/gemini-cli @openai/codex
```

## Install [`uv`](https://docs.astral.sh/uv/)

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh

uv python install --default
```

## Install Docker Engine

```sh
curl -fsSL https://get.docker.com | sh
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

Log out and back in for the group change to take effect. On Ubuntu you get the native Docker
Engine — no Docker Desktop needed.

## Configure Zsh

```sh
cp ubuntu/.zshrc ~/.zshrc
source ~/.zshrc
```

Config file: [`.zshrc`](.zshrc)

## Verify the two features

- **Autosuggestions:** run `git status`, then start typing `git s` — a gray suggestion appears;
  press `→` to accept.
- **Syntax highlighting:** type `git` → **green**; type `gitt` → **red**.
