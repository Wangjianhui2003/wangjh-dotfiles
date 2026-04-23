#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

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


#================================================================================ personal config 
# use eza or ls
if command -v eza >/dev/null 2>&1; then
  alias ll="eza -alh --git --icons --group-directories-first --group --time-style='+%Y-%m-%d %H:%M %a'"
else
  alias ll='ls -alh'
fi
#eza tree 
alias lt="eza -T -L 2 -alh --git --icons --group-directories-first --group --time-style='+%Y-%m-%d %H:%M %a'"
alias inst="sudo apt install"
# to
alias ghoconfig="nvim ~/.config/ghostty/config"
alias zconfig="nvim ~/.zshrc"

alias cls="clear"
alias cc="claude"
alias cx="codex"
alias ff="fastfetch"
alias b="btop"
alias g="lazygit"

# yazi shell wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

export PATH="$HOME/.local/bin:$PATH"
# maven
export PATH="/opt/apache-maven-3.9.12/bin:$PATH"

# nvm lazy load
export NVM_DIR="$HOME/.nvm"
lazy_load_nvm() {
  unset -f nvm node npm npx pnpm yarn
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}
nvm()  { lazy_load_nvm; nvm  "$@"; }
node() { lazy_load_nvm; node "$@"; }
npm()  { lazy_load_nvm; npm  "$@"; }
npx()  { lazy_load_nvm; npx  "$@"; }
pnpm() { lazy_load_nvm; pnpm "$@"; }
yarn() { lazy_load_nvm; yarn "$@"; }

# bun completions
[ -s "/home/jianhui/.bun/_bun" ] && source "/home/jianhui/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go 
export PATH=$PATH:/usr/local/go/bin

# default editor,range use this to open file
export EDITOR=nvim

# reduce vi-mode ESC(mode change) timeout
export KEYTIMEOUT=1

# starship
# put this at the end of zshrc
eval "$(starship init zsh)"
# zoxide
eval "$(zoxide init zsh)"
