# Zsh Setup — macOS

Sets up a complete **Zsh** development environment on **macOS** (Homebrew) with modern CLI tools,
plus the two features Zsh doesn't ship by default:

- **Autosuggestions** — a gray suggestion ahead of the cursor based on your history
  (accept with `→`). From [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions).
- **Syntax highlighting** — the first word turns **green** when the command exists and **red**
  when it doesn't. From [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting).

> macOS already ships **Zsh as the default shell** (since Catalina) — nothing to install or
> `chsh` for the shell itself; just install the tools and drop in the config.

## Install [`Homebrew`](https://brew.sh/)

Skip if you already have it:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install the CLI tools + Zsh plugins

```sh
brew install starship zoxide fzf eza bat \
  zsh-autosuggestions zsh-syntax-highlighting
```

- `starship` – cross-shell prompt
- `zoxide` – smart `cd`
- `fzf` – fuzzy finder
- `eza` – modern `ls`
- `bat` – cat with syntax highlighting (on macOS the binary is `bat`, not `batcat`)
- `zsh-autosuggestions`, `zsh-syntax-highlighting` – the two features above

The `.zshrc` loads the plugins from `$(brew --prefix)/share/...`, which resolves correctly on
both Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`).

## Configure starship (optional)

```sh
mkdir -p ~/.config
cp macos/starship.toml ~/.config/starship.toml
```

Config file: [`starship.toml`](starship.toml)

## Install [`fnm`](https://github.com/Schniz/fnm) + Node

[`fnm`](https://github.com/Schniz/fnm) is a fast, Rust-based Node version manager — a lighter
replacement for nvm (no slow shell startup). The `.zshrc` wires it up with
`eval "$(fnm env --use-on-cd)"`, which **auto-switches the Node version** when you `cd` into a
project with a `.node-version` / `.nvmrc` file.

```sh
brew install fnm

fnm install --lts
fnm default lts-latest
npm update -g npm
```

## Install [`pnpm`](https://pnpm.io/)

```sh
curl -fsSL https://get.pnpm.io/install.sh | sh -
```

On macOS pnpm uses `~/Library/pnpm` as its home; the `.zshrc` adds `$PNPM_HOME/bin` to `PATH`.

## Install [`bun`](https://bun.sh/)

```sh
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

## Install Docker

Install [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/) (from the
website or `brew install --cask docker-desktop`), then launch it once. All the `d*` / `dc*`
aliases use the `docker` and `docker compose` CLIs it provides.

> Tip: Docker Desktop is heavy on RAM — lower its VM memory in **Settings → Resources**, and quit
> it when you're not using containers.

## Configure Zsh

```sh
cp macos/.zshrc ~/.zshrc
source ~/.zshrc
```

Config file: [`.zshrc`](.zshrc)

## Verify the two features

- **Autosuggestions:** run `git status`, then start typing `git s` — a gray suggestion appears;
  press `→` to accept.
- **Syntax highlighting:** type `git` → **green**; type `gitt` → **red**.

## Troubleshooting

If `compinit` warns about **"insecure directories"** (Homebrew's completion dirs are
group-writable):

```sh
chmod -R go-w "$(brew --prefix)/share"
```

Alternatively, change `compinit` to `compinit -i` in `~/.zshrc`.
