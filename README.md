# KZ neovim

## Install

### Prerequisites

- Neovim >= v0.11.2

```sh
  brew install neovim
```

- Lazygit

```sh
  brew install lazygit
```

- for fzf-lua

```sh
  brew install ripgrep fd
  # MacOS
  brew install fzf
  # Ubuntu
  sudo apt install fzf
```

- for perl formatting (not in Mason)

```sh
  brew install perltidy
```

### Clone and Install

```sh
  # required
  mv ~/.config/nvim{,.bak}

  # optional but recommended
  mv ~/.local/share/nvim{,.bak}
  mv ~/.local/state/nvim{,.bak}
  mv ~/.cache/nvim{,.bak}

  git clone https://github.com/siawkz/nvim ~/.config/nvim
```

### Recommended Fonts

JetBrainsMono Nerd Font

## Useful Commands

| Command      | Description      |
| ------------ | ---------------- |
| :LazyExtras  | Open LazyExtras  |
| :ProjectRoot | Set project root |

## Original Key-mappings

Please refer to [LazyVim Keymaps](https://www.lazyvim.org/keymaps)

## Custom Key-mappings

Note that,

- **Leader** key set as <kbd>Space</kbd>

Modes: 𝐍=normal 𝐕=visual 𝐒=select 𝐈=insert 𝐂=command

### UI

| Key                                         | Mode | Action                     |
| ------------------------------------------- | :--: | -------------------------- |
| <kbd>Space</kbd>+<kbd>u</kbd>+<kbd>b</kbd>  |  𝐍   | Toggle carbonfox ↔ dayfox  |
| <kbd>Space</kbd>+<kbd>u</kbd>+<kbd>\|</kbd> |  𝐍   | Toggle 80-col color column |
| <kbd>Alt</kbd>+<kbd>a</kbd>                 | 𝐈 𝐍  | Select all                 |

### LSP / Peek

| Key                                                     | Mode | Action               |
| ------------------------------------------------------- | :--: | -------------------- |
| <kbd>Space</kbd>+<kbd>c</kbd>+<kbd>p</kbd>+<kbd>d</kbd> |  𝐍   | Peek Definition      |
| <kbd>Space</kbd>+<kbd>c</kbd>+<kbd>p</kbd>+<kbd>i</kbd> |  𝐍   | Peek Implementation  |
| <kbd>Space</kbd>+<kbd>c</kbd>+<kbd>p</kbd>+<kbd>t</kbd> |  𝐍   | Peek Type Definition |

### Bufferline

Uses vim direction mnemonic: `h` = close in the h-direction (left), `l` = close in the l-direction (right). This overrides LazyVim's `bl` (which means "left" lexically there).

| Key                                        | Mode | Action                      |
| ------------------------------------------ | :--: | --------------------------- |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>h</kbd> |  𝐍   | Delete buffers to the left  |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>l</kbd> |  𝐍   | Delete buffers to the right |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>s</kbd> |  𝐍   | Pick buffer                 |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>c</kbd> |  𝐍   | Pick + close                |

### WindowPicker

| Key                                        | Mode | Action      |
| ------------------------------------------ | :--: | ----------- |
| <kbd>Space</kbd>+<kbd>w</kbd>+<kbd>p</kbd> |  𝐍   | Pick window |
| <kbd>Space</kbd>+<kbd>w</kbd>+<kbd>x</kbd> |  𝐍   | Swap window |

### Dropbar (winbar)

| Key                           | Mode | Action                 |
| ----------------------------- | :--: | ---------------------- |
| <kbd>Space</kbd>+<kbd>;</kbd> |  𝐍   | Pick winbar symbol     |
| <kbd>[</kbd>+<kbd>;</kbd>     |  𝐍   | Go to start of context |
| <kbd>]</kbd>+<kbd>;</kbd>     |  𝐍   | Select next context    |

### BetterEscape

| Key           | Mode | Action |
| ------------- | :--: | ------ |
| <kbd>jk</kbd> |  𝐈   | Escape |
| <kbd>jj</kbd> |  𝐈   | Escape |

### Copilot

| Key                                                     | Mode | Action                    |
| ------------------------------------------------------- | :--: | ------------------------- |
| <kbd>Alt</kbd>+<kbd>p</kbd>                             |  𝐈   | Accept current suggestion |
| <kbd>Alt</kbd>+<kbd>w</kbd>                             |  𝐈   | Accept word               |
| <kbd>Alt</kbd>+<kbd>l</kbd>                             |  𝐈   | Accept line               |
| <kbd>Alt</kbd>+<kbd>]</kbd>                             |  𝐈   | Next suggestion           |
| <kbd>Alt</kbd>+<kbd>[</kbd>                             |  𝐈   | Previous suggestion       |
| <kbd>Ctrl</kbd>+<kbd>]</kbd>                            |  𝐈   | Dismiss                   |
| <kbd>Space</kbd>+<kbd>a</kbd>+<kbd>c</kbd>+<kbd>a</kbd> |  𝐍   | Force Attach              |
| <kbd>Space</kbd>+<kbd>a</kbd>+<kbd>c</kbd>+<kbd>e</kbd> |  𝐍   | Enable                    |
| <kbd>Space</kbd>+<kbd>a</kbd>+<kbd>c</kbd>+<kbd>d</kbd> |  𝐍   | Disable                   |
| <kbd>Space</kbd>+<kbd>a</kbd>+<kbd>c</kbd>+<kbd>s</kbd> |  𝐍   | Status                    |
| <kbd>Space</kbd>+<kbd>a</kbd>+<kbd>c</kbd>+<kbd>m</kbd> |  𝐍   | Toggle Ghost ↔ Blink-only |

### Cheat.sh

| Key                           | Mode | Action     |
| ----------------------------- | :--: | ---------- |
| <kbd>Space</kbd>+<kbd>H</kbd> |  𝐍   | Cheat list |

### Diffview

| Key                                        | Mode | Action        |
| ------------------------------------------ | :--: | ------------- |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>d</kbd> |  𝐍   | Open Diffview |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>h</kbd> |  𝐍   | File history  |
