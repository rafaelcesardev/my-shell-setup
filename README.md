# My Zsh Setup — Ubuntu & macOS

Reproducible **Zsh** shell setup with modern CLI tools, in two platform flavors that share the
same workflow, aliases and [`starship`](https://starship.rs) prompt:

- **[`ubuntu/`](ubuntu/)** — Zsh on Ubuntu (Debian/apt; works on WSL too).
- **[`macos/`](macos/)** — Zsh on macOS (Homebrew).

Both add the two niceties Zsh doesn't ship by default:

- **Autosuggestions** — a gray suggestion ahead of the cursor from your history
  ([`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)).
- **Syntax highlighting** — the first word turns green when the command exists, red when it
  doesn't ([`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)).

## Structure

```
ubuntu/   .zshrc · starship.toml · setup-guide.md   (apt · /usr/share · batcat)
macos/    .zshrc · starship.toml · setup-guide.md   (Homebrew · $(brew --prefix)/share · bat)
```

Pick your folder and follow its `setup-guide.md`.

## Included Tools

- [`starship`](https://starship.rs) - Cross-shell prompt
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) - Smart directory jumper
- [`fzf`](https://github.com/junegunn/fzf) - Fuzzy finder
- [`eza`](https://github.com/eza-community/eza) - Modern ls replacement
- [`bat`](https://github.com/sharkdp/bat) - Cat with syntax highlighting
- [`fnm`](https://github.com/Schniz/fnm) - Fast Node version manager
- [`pnpm`](https://pnpm.io) - Fast package manager
- [`bun`](https://bun.sh) - JavaScript runtime
- [`uv`](https://docs.astral.sh/uv) - Python package installer
- [`docker`](https://docs.docker.com/engine) - Container platform
- [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) - Fish-style autosuggestions
- [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) - Command validity highlighting

## Quick Start

### Ubuntu

```sh
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git zsh

# make zsh the default shell
chsh -s $(which zsh)

# drop in the config
cp ubuntu/.zshrc ~/.zshrc
mkdir -p ~/.config && cp ubuntu/starship.toml ~/.config/starship.toml
```

Full steps: [ubuntu/setup-guide.md](ubuntu/setup-guide.md)

### macOS

Zsh is already the default shell. Install [Homebrew](https://brew.sh), then:

```sh
brew install starship zoxide fzf eza bat \
  zsh-autosuggestions zsh-syntax-highlighting

# drop in the config
cp macos/.zshrc ~/.zshrc
mkdir -p ~/.config && cp macos/starship.toml ~/.config/starship.toml
source ~/.zshrc
```

Full steps: [macos/setup-guide.md](macos/setup-guide.md)

## Optional Configuration

### Git Setup

```sh
git config --global init.defaultBranch main
git config --global user.name "your_github_username"
git config --global user.email "your_github_email"
```

### SSH Setup

Create an SSH key (Ed25519):

```sh
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "your_github_email" -f ~/.ssh/id_ed25519
```

Start the agent and add the key:

```sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Display the public key (add it to GitHub):

```sh
cat ~/.ssh/id_ed25519.pub
```
