# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"
#ZSH_THEME="robbyrussell"
#ZSH_THEME="jbergantine"
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
#DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
#export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
#DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="false"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
#DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
#HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode systemd colorize safe-paste node brew cp debian)
#ubuntu extract vagrant systemd)
# dirhistory sublime git-flow vi-mode)
#plugins=(git)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH

#export PATH="$PATH:/home/dek/.rvm/gems/ruby-1.9.3-p547/bin:/home/dek/.rvm/gems/ruby-1.9.3-p547@global/bin:/home/dek/.rvm/rubies/ruby-1.9.3-p547/bin:/home/dek/bin:/usr/local/cuda-6.0/bin:/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin:/home/dek/perl5/perlbrew/bin:/home/dek/perl5/perlbrew/perls/perl-5.20.1/bin:/usr/local/cuda-6.0/bin:/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin:/usr/local/cuda-6.0/bin:/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin:/home/dek/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin:/home/dek/.rvm/bin:/home/dek/android-sdks/tools/:/home/dek/.rvm/bin:/home/dek/android-sdks/tools/:/home/dek/.rvm/bin:/home/dek/android-sdks/tools/:/home/dek/.rvm/bin:/home/dek/.rvm/bin"

#export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#    export EDITOR='vi'
#else
#    export EDITOR='vim'
#fi

#PS1=$'%F{def}%(?..%B%K{red}[%?]%K{def}%b )%(1j.%b%K{yel}%F{bla}%jJ%F{def}%K{def} .)%F{white}%B%*%b %F{m}%m:%F{white}%~ %(!.#.>) %F{def}'
# Compilation flags

#export ARCHFLAGS="-arch x86_64"

# ssh
#export SSH_KEY_PATH="~/.ssh/dsa_id"
#export SSH_KEY_PATH="~/.ssh/id_rsa"

# Set less options

#if [[ -x $(which less 2> /dev/null) ]]
#then
    #export PAGER="less"
    #export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
    #export LESSHISTFILE='-'
    #if [[ -x $(which lesspipe 2> /dev/null) ]]
    #then
        #LESSOPEN="| lesspipe %s"
        #export LESSOPEN
    #fi
#fi

#
#setopt appendhistory autocd extendedglob nohup autopushd

# Add linuxbrew to PATH.
#export PATH="$HOME/.linuxbrew/bin:$PATH"
#export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
#export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

#fpath=(~/.zsh/completion $fpath)

# Load zsh-syntax-highlighting.
#source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions.
#source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically.
#zle-line-init() {
#    zle autosuggest-start
#}

#zle -N zle-line-init

#bindkey '^T' autosuggest-toggle

#
export AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1
export AUTOSUGGESTION_HIGHLIGHT_COLOR="fg=7"

# Test and than source the options
if [ -f ~/.zsh/zshoptions ]; then
    source ~/.zsh/zshoptions
else
   print -Pn "Warning: ~/.zsh/zshoptions is unavailable" 
fi

# Test and than source the exported variables
if [ -f ~/.zsh/zshexports ]; then
    source ~/.zsh/zshexports
else
   print -Pn "Warning: ~/.zsh/zshexport is unavailable" 
fi

# Test and than source the aliases
if [ -f ~/.zsh/zshaliases ]; then
    source ~/.zsh/zshaliases
else
    print -Pn "Warning: ~/.zsh/zshalias is unavailable" 
fi

# Test and than source the bindings
if [ -f ~/.zsh/zshbindings ]; then
    source ~/.zsh/zshbindings
else
    print -Pn "Warning: ~/.zsh/zshbindings is unavailable" 
fi

# Test and than source the functions
if [ -f ~/.zsh/zshfunctions ]; then
    source ~/.zsh/zshfunctions
else
    print -Pn "Warning: ~/.zsh/zshfunctions is unavailable" 
fi

# Test and than source the zsh completitionws
if [ -f ~/.zsh/zshcompl ]; then
    source ~/.zsh/zshcompl
else
   print -Pn "Warning: ~/.zsh/zshcompl is unavailable" 
fi

# Test and than source the prompt
if [ -f ~/.zsh/zshprompt ]; then
    source ~/.zsh/zshprompt
else
    print -Pn "Warning: ~/.zsh/zshprompt is unavailable" 
fi

# Test and than source the prompt
if [ -f ~/.zsh/zshhooks ]; then
    source ~/.zsh/zshhooks
else
    print -Pn "Warning: ~/.zsh/zshhooks is unavailable" 
fi

if [ -f ~/.zsh/zshlocal ]; then
    source ~/.zsh/zshlocal
fi

fpath=($ZSH/functions $ZSH/completions $fpath)

# Load zsh-syntax-highlighting.
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions.
source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically.
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#./home/dek/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

source ~/perl5/perlbrew/etc/bashrc # Add perlbrew to PATH

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


