# dotfiles

My personal development environment. Built for productivity or call it whatever you want, featuring a Neovim setup on steroids, a snappy Fish shell, and a modular Hyprland configuration that actually makes sense.

## Preview

![Mobile Showcase](assets/preview_1.jpg)
*Aesthetics*

![Main Desktop Showcase](assets/preview_2.png)
Aesthetics too

## Key Features

*   **Neovim:** Based on LazyVim but heavily customized. It packs custom Lua modules for AI bridging, specialized prompts, and `git-ai-commit` logic—because writing commit messages manually is so 2023.
*   **Modular Hyprland:** Native Lua config, split by concern into `appearance/`, `binds/`, `hardware/`, `rules/`, and `lib/`. No massive, bloated config files here; utilized caelestia like keymapping.
*   **Modern CLI Stack:** **Fish Shell** + **Starship**. It’s fast, looks great, and tells me exactly which git branch I'm on.
*   **LSP on Steroids:** Optimized out-of-the-box support for my stuff.
*   **Unified Aesthetics:** Consistent styling across the board—Waybar, Rofi, Kitty, and Hyprland all share a central color palette.
*   **Dev Utilities:** Integrated tools like `codecompanion` for LLM interaction, `conform` for formatting, and specialized action scripts for Rust and Go.

## Installation

### Requirements
Before you dive in, make sure you have these installed:
*   **WM:** Hyprland
*   **Shell:** Fish & Starship
*   **Editor:** Neovim
*   **Terminal:** Kitty
*   **Extras:** Waybar, Rofi, Fastfetch

### Deployment
This repo is designed to be managed with `stow`. To link these configs to your system, clone the repo to your home directory and run:

```bash
git clone https://github.com/robertmon-dev/dotfiles.git
cd dotfiles

./install.sh
# or stow modules individually:
stow nvim
stow hypr
# ...and so on for other modules
```

`pkglist.txt` holds the explicitly installed packages (`pacman -Qqe`) used on the reference setup, in case you want to reproduce the environment with `pacman -S --needed - < pkglist.txt`.

## Configuration

### Neovim AI Integration
The AI features rely on my separate `nvim-engine` project (check that repo for the binary; the `Makefile` there is your friend). You'll need to export your API keys in your shell. You can pass multiple keys as comma-separated values:

```bash
export GEMINI_API_KEYS="your_key_1,your_key_2"
export ANTHROPIC_API_KEYS="your_key_1,your_key_2,your_key_3"
```

### Project Structure
The repo mirrors a standard `.config` layout:

```text
.
├── bat               # Pager theme & style
├── fastfetch         # System info layout
├── fish              # Shell config & custom functions (fzf, zoxide, eza wired in conf.d)
├── git               # Global .gitconfig and local overrides
├── hypr              # Hyprland (modular Lua config), hyprlock, hyprpaper, and helper scripts
├── kitty             # GPU-accelerated terminal config
├── nvim              # The heart (LazyVim + AI + LSP modules)
├── rofi              # App launcher & theme
├── starship          # Cross-shell prompt config
└── waybar            # Status bar CSS and JSON modules
```

`hypr/.config/hypr` itself is organized by concern rather than dumped into one folder:

```text
hypr/.config/hypr
├── hyprland.lua      # Entry point: wires up modules & autostart
├── hyprlock.conf      # Lock screen (own config, read by hyprlock)
├── hyprpaper.conf     # Wallpaper daemon (own config, read by hyprpaper)
├── lib/               # Shared helpers & constants (utils, variables)
├── appearance/        # Colors, animations, cursor, window look & feel
├── hardware/          # Monitors, keyboard layout
├── rules/             # Window / workspace / layer rules
├── binds/             # Keybindings
└── scripts/           # Helper scripts (e.g. keybinds cheat-sheet)
```

## Highlights within Neovim

*   `lua/configs/keymaps.lua`: Where the magic happens. All my main keybindings live here.
*   `lua/configs/autocmds.lua`: Autocommands and a few specific keybindings kept here to avoid re-importing everything and to keep me sane.
*   `lua/functions/ai/`: The core logic for the AI bridge and custom prompt engineering.
*   `lua/lsp/`: Per-language server configs to ensure peak performance without the bloat.
*   `lua/plugins/`: A curated list of plugins, including `codecompanion.lua` for that sweet LLM interaction.

## Support & Scripts

*   **Keybinds:** Hyprland shortcuts are located in `hypr/.config/hypr/binds/keybinds.lua`. To quickly list active system shortcuts, just hit `SUPER + H`.
*   **LSP Logs:** If Neovim is acting up, check the standard LSP logs at `~/.local/state/nvim/lsp.log`.

---
