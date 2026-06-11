# dotfiles

Managed with [chezmoi](https://chezmoi.io). Multi-machine: `macos-pdq` (work), `macos-personal`.

## Setup (new machine)

```sh
brew install chezmoi
chezmoi init --apply <github-user>/dotfiles
```

Prompts once for the machine name, then applies all configs and installs all Homebrew packages.

## Usage

```sh
chezmoi edit ~/.zshrc    # edit a managed file (the template in this repo)
chezmoi diff             # preview pending changes
chezmoi apply            # apply configs + install new packages
chezmoi cd               # jump into this repo to commit/push
```

**Add an app:** add it to `.chezmoidata/packages.yaml` under `darwin.shared` (all Macs) or a machine section, then `chezmoi apply`. Removal is manual (`brew uninstall`) — bundle never uninstalls.

**Machine-specific config:** branch inside any `.tmpl` file:

```
{{ if eq .machine "macos-pdq" }}...{{ end }}
```

or list machine-only files in `.chezmoiignore` so other machines skip them.

## Layout

```
.chezmoi.toml.tmpl                            prompts machine name on init
.chezmoidata/packages.yaml                    all packages, per OS + per machine
run_onchange_darwin-install-packages.sh.tmpl  auto brew bundle when yaml changes
.chezmoiignore                                per-OS/per-machine exclusions
dot_*                                         the actual dotfiles (.tmpl = templated)
```
