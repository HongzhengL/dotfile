# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-search
#
bindkey "${terminfo[kcuu1]}" history-search-backward   # Up  arrow
bindkey "${terminfo[kcud1]}" history-search-forward    # Down arrow


##### History
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=100000      # Number of commands stored in memory
SAVEHIST=100000      # Number of commands saved to the history file
setopt hist_ignore_all_dups     # Remove older duplicate commands
setopt hist_ignore_space        # Ignore commands that start with a space
setopt appendhistory            # Append history instead of overwriting
setopt sharehistory             # Share history across multiple sessions
setopt incappendhistory         # Write history incrementally to the file


####### alias
alias c="clear"
alias m="make -j"
alias mc="make clean"
alias ml="make lint"
alias mr="make run"
alias mv="mv -i"
alias rm="rm -i"
alias mz="make zip"
alias t="tmux"
alias ta="tmux attach"
alias v="nvim"
alias n="ninja"
alias nc="ninja clean"
alias y="yazi"
alias d="docker"
alias view="nvim -R"

#### alias inherted from omz
alias gl="git pull"
alias gp="git push"
alias gb="git branch"
alias grv="git remote -v"
alias gcl="git clone"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit --verbose"
alias gsw="git switch"
alias gco="git checkout"
alias glog='git log --oneline --decorate --graph'
alias gd="git diff"
alias gst="git status"
alias gsta='git stash push'
alias grs="git restore"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
function -() {
  cd - "$@"
}


cf () {
    extensions=("*.cpp" "*.c" "*.cc" "*.cxx" "*.h" "*.hpp" "*.hh")
    for ext in "${extensions[@]}"; do
        find . -type f -name "$ext" -exec clang-format -i {} +
    done
}

