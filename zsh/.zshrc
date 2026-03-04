# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Prompt tweaks (optional, especially for powerlevel10k)
# [ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Path to your oh-my-zsh installation.

export ZSH="$HOME/.oh-my-zsh"

# Set the ZSH theme (choose one that is fast and clean)
ZSH_THEME="robbyrussell"

# Enable completion
export ZSH_COMPDUMP="$HOME/.cache/zcompdump"
autoload -Uz compinit
compinit

# Enable command auto-correction
ENABLE_CORRECTION="false"

# Case-insensitive globbing
CASE_GLOB="true"

# Highlight matching brackets
export MATCHING_BRACKETS="true"

# Plugins to load (minimal + useful)
plugins=(
  git              # Git aliases and functions
  fzf              # Fuzzy search, assumes fzf is installed
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Set up PATH additions (e.g., for Homebrew, Node, Go, etc.)
export PATH="$HOME/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"

# Enable LS_COLORS and nicer ls defaults
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ll='ls -lha'

# Enable syntax highlighting (requires plugin installed)
# brew install zsh-syntax-highlighting
[[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable autosuggestions (requires plugin installed)
# brew install zsh-autosuggestions
[[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Enable vi keybindings (or comment if you prefer emacs)
bindkey -v

export JAVA_HOME=$(/usr/libexec/java_home)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Auto-switch node version based on .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
#[S]afe[B]reach[C]onnect - fuzzy find a server by name/ip/jumpserver/text in connection string -  and connect to it via ssh.
sbc () {
  ssa=$(${SBiTerm}/sbc/profiles-transform.py | fzf | sed 's#^.*\--------->  \(.*\)#\1#') && echo "$ssa" && eval $ssa
}

export SBKeys="/Users/itamarbarhod/.ssh/keys"
export SBiTerm="/Users/itamarbarhod/Projects/iterm"
export RABBITMQ_PASS=AgwIeAspAPQa4fla 

# oh my posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/theme.omp.json)"
fi
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export ENABLE_LSP_TOOL=1
