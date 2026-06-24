# Terminal Setup Guide — macOS · Linux · WSL

A complete terminal: a modern CLI toolkit, the [`starship`](https://starship.rs) prompt, and a
ready-to-use Node + Python + Git environment.

**Core idea:** [Homebrew](https://brew.sh) runs on macOS, Linux and WSL — so one package manager
installs (almost) everything. *If `brew` can install it, we use `brew`.* The only per-OS
difference is Docker (see Step 3).

Works with **Zsh**, **Bash** and **Fish**. This guide configures whichever shell you already use —
it does not install or switch your shell.

| Shell | Autosuggestions | Syntax highlighting |
| :---- | :-------------: | :-----------------: |
| Zsh   | ✓ (brew plugin) | ✓ (brew plugin)     |
| Fish  | ✓ built-in      | ✓ built-in          |
| Bash  | —               | —                   |

> Bash has no autosuggestions / syntax highlighting (those are Zsh-plugin / Fish features). It
> still gets the starship prompt, zoxide, fzf and every alias.

**Do the steps in order** — later steps assume the earlier ones ran.

---

## Step 1 — Install Homebrew

Skip if you already have it (`brew --version`).

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

On Linux/WSL the installer prints two `eval` lines at the end to add `brew` to your `PATH` — run
them. (The shell config you drop in at Step 4 also does this automatically from then on.)

## Step 2 — Install the CLI tools

One command, identical on every platform:

```sh
brew install starship zoxide fzf eza bat fnm pnpm bun uv \
  zsh-autosuggestions zsh-syntax-highlighting git
```

| Tool | What it does |
| :--- | :--- |
| [`starship`](https://starship.rs) | Cross-shell prompt |
| [`zoxide`](https://github.com/ajeetdsouza/zoxide) | Smart `cd` that learns your dirs |
| [`fzf`](https://github.com/junegunn/fzf) | Fuzzy finder (`Ctrl-T`, `Ctrl-R`) |
| [`eza`](https://github.com/eza-community/eza) | Modern `ls` (aliased to `ls`) |
| [`bat`](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [`fnm`](https://github.com/Schniz/fnm) | Fast Node version manager |
| [`pnpm`](https://pnpm.io) | Fast Node package manager |
| [`bun`](https://bun.sh) | JavaScript runtime + toolkit |
| [`uv`](https://docs.astral.sh/uv) | Fast Python / package manager |
| [`git`](https://git-scm.com) | Version control |
| `zsh-autosuggestions`, `zsh-syntax-highlighting` | The two Zsh niceties above |

> The two `zsh-*` plugins are only used by Zsh. Installing them on a Bash/Fish machine is harmless
> — keeping one command for everyone is simpler.

## Step 3 — Install Docker

This is the **only** step that differs per OS.

**macOS** — [OrbStack](https://orbstack.dev), a fast, light Docker Desktop replacement (provides
the `docker` and `docker compose` CLIs the aliases use):

```sh
brew install --cask orbstack
```

**Linux (desktop)** — Homebrew Cask can't install Docker Desktop on Linux (the `docker-desktop`
cask is macOS-only). Install it natively, following the official guide:
<https://docs.docker.com/desktop/setup/install/linux/>

**WSL** — install the Docker CLI via brew:

```sh
brew install docker
```

> The brew formula is the **client** only. Point it at a daemon by enabling **Docker Desktop's
> WSL integration** on Windows, or by running `dockerd` inside the distro.

## Step 4 — Drop in your shell config

Copy the file for your shell, plus the shared `starship.toml`, then reload.

```sh
# starship prompt config (all shells)
mkdir -p ~/.config && cp config/starship.toml ~/.config/starship.toml
```

**Zsh**

```sh
cp config/.zshrc ~/.zshrc
exec zsh
```

**Bash**

```sh
cp config/.bashrc ~/.bashrc
exec bash
```

**Fish**

```sh
mkdir -p ~/.config/fish && cp config/config.fish ~/.config/fish/config.fish
exec fish
```

After reloading, `brew`, `fnm`, `pnpm`, `bun` and `uv` are all on your `PATH`.

## Step 5 — Install Node (LTS)

`fnm` is already installed and wired up (the config runs `fnm env --use-on-cd`, which
auto-switches the Node version when you `cd` into a project with a `.node-version` / `.nvmrc`).

```sh
fnm install --lts
fnm default lts-latest
npm update -g npm
```

## Step 6 — Install Python

```sh
uv python install --default
```

`--default` puts `python` / `python3` shims in `~/.local/bin` (already on your `PATH`).

## Step 7 — Configure Git

```sh
git config --global init.defaultBranch main
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

## Step 8 — Create an SSH key

Generate an Ed25519 key, load it into the agent, and print the public half:

```sh
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "you@example.com" -f ~/.ssh/id_ed25519

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

cat ~/.ssh/id_ed25519.pub
```

Add the printed public key to GitHub → **Settings → SSH and GPG keys**.

---

## Verify

```sh
node --version        # LTS, e.g. v22.x
python --version      # e.g. 3.13.x
docker --version      # the CLI is on PATH
eza --version         # ls is aliased to eza
```

- **Zsh / Fish autosuggestions:** run `git status`, then type `git s` — a gray suggestion appears;
  press `→` to accept.
- **Zsh / Fish syntax highlighting:** type `git` → it turns **green**; type `gitt` → **red**.

## Troubleshooting

**Zsh: `compinit` warns about "insecure directories"** (Homebrew's completion dirs are
group-writable):

```sh
chmod -R go-w "$(brew --prefix)/share"
```

Or change `compinit` to `compinit -i` in `~/.zshrc`.

**`command not found` right after installing a tool** — open a new shell (or re-run the `exec`
line from Step 4) so the updated `PATH` takes effect.
