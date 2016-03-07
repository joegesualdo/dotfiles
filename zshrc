## THOUGHTBOT Dotfiles ==========
# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

for function in ~/.zsh/functions/*; do
  source $function
done

# history settings
setopt histignoredups
HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Try to correct command line spelling
setopt correct correctall

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# look for ey config in project dirs
export EYRC=./.eyrc

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash)"
fi

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

## END THOUGHTBOT Dotfiles =====
#
# Got a warning from 'brew doctor' about /usr/bin being before /usr/local/bin
# so this export fixes that. Source: http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

export PAGER="/usr/bin/less"

export VAGRANT_SSH_KEY="/Users/joegesualdo/.ssh/id_rsa_nopass"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Add RVM to PATH for scripting
export PATH=$PATH:$HOME/.rvm/bin

# Use 256 color support (not sure why this isn't enable by thoughtbot)
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# Color the manual (man) pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

# This give the ability to use base16 colors with 256 enabled:
#   (https://github.com/chriskempson/base16-iterm2)
# Needed base16 for tomorrow-theme:
#   (https://github.com/chriskempson/tomorrow-theme)
# This script enables support:
#   (https://github.com/chriskempson/base16-shell)
# BASE16_SCHEME="tomorrow"
# BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
# [[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# Add auto-complete to npm
. <(npm completion)

# For rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="~/vendor/bundle/bin:$PATH"
# To add zsh-syntax-highlighing"
#   https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
# source /Users/joegesualdo/Desktop/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/sindresorhus/pure#getting-started
fpath=( "$HOME/dotfiles/zsh/functions" $fpath )

# User for the pur promt
autoload -U promptinit && promptinit
PURE_CMD_MAX_EXEC_TIME=10
prompt pure

# added by travis gem
[ -f /Users/joegesualdo/.travis/travis.sh ] && source /Users/joegesualdo/.travis/travis.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
