# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(mix git docker docker-compose bundler brew gem rails atom common-aliases osx pod python ruby terminalapp vagrant web-search postgres)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='vim'
fi

# use vi mode (emacs is default)
set -o vi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Keypad
# # 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# # 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# # 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# # 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# # + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

# PATH has to be exported in zshrc
PATH="/usr/local/heroku/bin:$PATH"

# Opt binaries are sym linked in /opt/bin
PATH="/opt/bin:$PATH"

PATH="/usr/local/bin:$PATH"
PATH="$(yarn global bin):$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.scripts:$PATH"

export PATH

# Load the shims in the PATH var
# for python and ruby
[ -s "pyenv" ] && eval "$(pyenv init -)"
[ -s "rbenv" ] && eval "$(rbenv init -)"

# # Configure keychain to be able to use sftp, scp like ssh
# keychain $HOME/.ssh/id_rsa
# source $HOME/.keychain/${HOST}-sh

# Source autojump
[[ -f /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh
[[ -f /usr/local/etc/profile.d/autojump.sh ]] && source /usr/local/etc/profile.d/autojump.sh

# Can be used like this :
# smartresize inputfile.png 300 outputdir/
smartresize() {
   mogrify -path $3 -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}

# Add autocompletion
if [ -f ~/.config/exercism/exercism_completion.zsh  ]; then
    . ~/.config/exercism/exercism_completion.zsh
fi

# Serve current directory on local network
servefiles() {
  python -m http.server 7777
}

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Load aliases from a file shared by zsh and bash
[[ -f ~/.aliases ]] && source ~/.aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Disable flow control to be able to use <C-s> and <C-q> in vim
stty -ixon
