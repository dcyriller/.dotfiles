# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# VIM
set -o vi # use vi mode (emacs is default)
stty -ixon # Disable flow control to be able to use <C-s> and <C-q> in vim

# build the PATH
# it has to be exported in this zshrc
PATH="/usr/local/opt/php@5.6/bin:$PATH"
PATH="/usr/local/opt/php@5.6/sbin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"
PATH="/opt/bin:$PATH" # Opt binaries are sym linked in /opt/bin
PATH="/usr/local/bin:$PATH"
PATH="$(yarn global bin):$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.scripts:$PATH"
export PATH

# Load local config
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Load aliases from a file shared by zsh and bash
[ -f ~/.aliases ] && source ~/.aliases

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Load pyenv and rbenv shims in the PATH var
[ -s "pyenv" ] && eval "$(pyenv init -)"
[ -s "rbenv" ] && eval "$(rbenv init -)"

# Load FZF autocompletion and bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load autojump
[ -f /usr/share/autojump/autojump.sh ] && source /usr/share/autojump/autojump.sh
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh

# Load travis gem
[ -f /Users/cyrille/.travis/travis.sh ] && source /Users/cyrille/.travis/travis.sh

# exercism: add autocompletion
if [ -f ~/.config/exercism/exercism_completion.zsh  ]; then
    . ~/.config/exercism/exercism_completion.zsh
fi

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done
