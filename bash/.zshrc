# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

source ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bash_funcs ]; then
    . ~/.bash_funcs
fi


# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export EDITOR='nvim'
export VISUAL="${EDITOR}"
export BROWSER='zen-browser'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi


# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

export MANPAGER="less -R --use-color -Dd+r -Du+b"
# Uncomment one of the following lines to change the auto-update behavior
#
zstyle ':omz:update' mode disabled  # disable automatic updates

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"
unsetopt correctall

HISTFILE=~/.config/zsh/zhistory
HISTSIZE=500000
SAVEHIST=500000
HISTDUP=erase
HISTCONTROL=erasedups:ignoredups:ignorespace
HISTTIMEFORMAT="%Y-%m-%d %T "
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilations flags
export ARCHFLAGS="-arch $(uname -m)"

#  ┌─┐┬ ┬┌┬┐┌─┐  ┌─┐┌┬┐┌─┐┬─┐┌┬┐
#  ├─┤│ │ │ │ │  └─┐ │ ├─┤├┬┘ │
#  ┴ ┴└─┘ ┴ └─┘  └─┘ ┴ ┴ ┴┴└─ ┴

# Install Starship - curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
#
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
source /usr/share/fzf/key-bindings.zsh

# bind '"\C-f":"zi\n"'

# defined in .bash_funcs
zle -N cd_to_dir
bindkey '^p' cd_to_dir

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.config/emacs/bin
export TEXTUAL_SNAPSHOT_FILE_OPEN_PREFIX=vscode://file/

# source $HOME/github.com/varcall_env/bin/activate  # commented out by conda initialize

. /opt/asdf-vm/asdf.sh
export PATH=$HOME/edirect:${PATH}
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export PATH=$HOME/.ghcup/bin:${PATH}

fpath+=~/.zfunc; autoload -Uz compinit; compinit
export TOWER_ACCESS_TOKEN=eyJ0aWQiOiAxMDgzOX0uYWFiMGM0NTAwNzE3MDc1NDU4NTFjOWNiYTQyYmQ0M2NmN2JlNDdjYQ==

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# Created by `userpath` on 2025-03-20 10:40:57
export PATH="$PATH:$HOME/.local/share/hatch/pythons/3.10/python/bin"
export BIOINFO_SCRIPTS="$HOME/github.com/vidyasagar0405/bioinfo-scripts"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/vs/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/vs/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/vs/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/vs/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='$HOME/miniconda3/bin/mamba';
export MAMBA_ROOT_PREFIX='$HOME/miniconda3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
export PATH=$HOME/.opam/default/bin/:${PATH}
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/vs/.opam/opam-init/init.zsh' ]] || source '/home/vs/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration


[ -f "/home/vs/.ghcup/env" ] && . "/home/vs/.ghcup/env" # ghcup-env


 export DOCKER_HOST=unix:///var/run/docker.sock
