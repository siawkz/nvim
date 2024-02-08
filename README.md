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

- for telescope.nvim

```sh
  brew install ripgrep fd
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

## Custom Key-mappings

Note that,

- **Leader** key set as `Space`

Modes: 𝐍=normal 𝐕=visual 𝐒=select 𝐈=insert 𝐂=command
