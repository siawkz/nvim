# KZ neovim

## Install

### Prerequisites

- Neovim >= v0.8.0

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

- for yanky.nvim

```sh
  # You may need to install this on MacOS if you encounter error
  brew install sqlite
```

- for ChatGPT

```sh
# set enviroment variable in /etc/environment or ~/.bash-profile
OPENAI_API_KEY="your openapi api key"
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

| Key                                        | Mode | Action           |
| ------------------------------------------ | :--: | ---------------- |
| <kbd>Space</kbd>+<kbd>e</kbd>              |  𝐍   | Open file tree   |
| <kbd>Space</kbd>+<kbd>c</kbd>+<kbd>s</kbd> |  𝐍   | Open symbols     |
| <kbd>Space</kbd>+<kbd>f</kbd>+<kbd>f</kbd> |  𝐍   | Open file finder |
| <kbd>Space</kbd>+<kbd>u</kbd>+<kbd>r</kbd> |  𝐍   | Remove highlight |
| <kbd>g</kbd>+<kbd>c</kbd>                  |  𝐍   | Toggle comment   |
| <kbd>Space</kbd>+<kbd>f</kbd>+<kbd>p</kbd> |  𝐍   | Projects         |
| <kbd>Ctrl</kbd>+<kbd>/</kbd>               | 𝐈 𝐍  | Open terminal    |
| <kbd>Space</kbd>+<kbd>C</kbd>              |  𝐍   | Command Palette  |
| <kbd>Space</kbd>+<kbd>u</kbd>+<kbd>v</kbd> |  𝐍   | Toogle LSP line  |

### Motion

| Key                                         | Mode | Action                  |
| ------------------------------------------- | :--: | ----------------------- |
| <kbd>f</kbd>                                |  𝐍   | find next character     |
| <kbd>F</kbd>                                |  𝐍   | find previous character |
| <kbd>s</kbd>                                |  𝐍   | find character          |
| <kbd>Alt</kbd>+<kbd>a</kbd>                 |  𝐈   | select all              |
| <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>j</kbd> |  𝐍   | Add Multi Cursor down   |
| <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>k</kbd> |  𝐍   | Add Multi Cursor up     |

### LSP

| Key                                                     | Mode | Action               |
| ------------------------------------------------------- | :--: | -------------------- |
| <kbd>Space</kbd>+<kbd>c</kbd>+<kbd>p</kbd>+<kbd>d</kbd> |  𝐍   | Peek Definition      |
| <kbd>Space</kbd>+<kbd>c</kbd>+<kbd>p</kbd>+<kbd>i</kbd> |  𝐍   | Peek Implementation  |
| <kbd>Space</kbd>+<kbd>c</kbd>+<kbd>p</kbd>+<kbd>t</kbd> |  𝐍   | Peek Type Definition |

### Plugin: Bufferline

| Key                                        | Mode | Action             |
| ------------------------------------------ | :--: | ------------------ |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>h</kbd> |  𝐍   | Close all to left  |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>l</kbd> |  𝐍   | Close all to right |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>s</kbd> |  𝐍   | Pick buffer        |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>c</kbd> |  𝐍   | Close buffer       |

### Plugin: WindowPicker

| Key                                        | Mode | Action      |
| ------------------------------------------ | :--: | ----------- |
| <kbd>Space</kbd>+<kbd>w</kbd>+<kbd>p</kbd> |  𝐍   | Pick window |
| <kbd>Space</kbd>+<kbd>w</kbd>+<kbd>s</kbd> |  𝐍   | Swap window |

### Plugin: BetterEscape

| Key           | Mode | Action |
| ------------- | :--: | ------ |
| <kbd>jk</kbd> |  𝐈   | Escape |
| <kbd>jj</kbd> |  𝐈   | Escape |

### Plugin: AsyncTasks

| Key                                        | Mode | Action        |
| ------------------------------------------ | :--: | ------------- |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>f</kbd> |  𝐍   | Build File    |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>p</kbd> |  𝐍   | Build Project |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>e</kbd> |  𝐍   | Edit Tasks    |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>l</kbd> |  𝐍   | List Tasks    |
| <kbd>Space</kbd>+<kbd>r</kbd>+<kbd>f</kbd> |  𝐍   | Run File      |
| <kbd>Space</kbd>+<kbd>r</kbd>+<kbd>p</kbd> |  𝐍   | Run Project   |

### Plugin: Copilot

| Key                                        | Mode | Action                    |
| ------------------------------------------ | :--: | ------------------------- |
| <kbd>Alt</kbd>+<kbd>]</kbd>                |  𝐈   | Next suggestion           |
| <kbd>Alt</kbd>+<kbd>[</kbd>                |  𝐈   | Previous suggestion       |
| <kbd>Alt</kbd>+<kbd>p</kbd>                |  𝐈   | Accept current suggestion |
| <kbd>Alt</kbd>+<kbd>l</kbd>                |  𝐈   | Accept line suggestion    |
| <kbd>Alt</kbd>+<kbd>w</kbd>                |  𝐈   | Accept word suggestion    |
| <kbd>Ctrl</kbd>+<kbd>]</kbd>               |  𝐈   | Dismis                    |
| <kbd>Space</kbd>+<kbd>a</kbd>+<kbd>e</kbd> |  𝐍   | Enable Copilot            |
| <kbd>Space</kbd>+<kbd>a</kbd>+<kbd>d</kbd> |  𝐍   | Disable Copilot           |
| <kbd>Space</kbd>+<kbd>a</kbd>+<kbd>t</kbd> |  𝐍   | Toggle Inline suggestion  |
| <kbd>Space</kbd>+<kbd>a</kbd>+<kbd>s</kbd> |  𝐍   | Check status              |

### Plugin: ChatGPT

| Key                                        | Mode | Action                |
| ------------------------------------------ | :--: | --------------------- |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>e</kbd> | 𝐈 𝐍  | Edit with Instruction |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>g</kbd> | 𝐈 𝐍  | Grammar Correction    |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>t</kbd> | 𝐈 𝐍  | Translate             |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>k</kbd> | 𝐈 𝐍  | Keywords              |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>d</kbd> | 𝐈 𝐍  | Docstring             |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>a</kbd> | 𝐈 𝐍  | Add Tests             |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>o</kbd> | 𝐈 𝐍  | Optimize Code         |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>s</kbd> | 𝐈 𝐍  | Summarize             |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>f</kbd> | 𝐈 𝐍  | Fix Bugs              |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>x</kbd> | 𝐈 𝐍  | Explain Code          |
| <kbd>Space</kbd>+<kbd>h</kbd>+<kbd>r</kbd> | 𝐈 𝐍  | Roxygen Edit          |

### Plugin: Diffview

| Key                                        | Mode | Action        |
| ------------------------------------------ | :--: | ------------- |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>d</kbd> |  𝐍   | Open Diffview |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>h</kbd> |  𝐍   | Focus History |
