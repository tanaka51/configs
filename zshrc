export LANG=en_US.UTF-8
export FC_LANG=ja

export EDITOR=vim
export TERM='screen-256color'

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

bindkey -e

autoload -U compinit; compinit
autoload -Uz add-zsh-hook
autoload colors; colors

# prompt vcs
setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr   '%F{yellow}!'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}+'
zstyle ':vcs_info:*' formats '%F{green}%c%u[%b]%f'
zstyle ':vcs_info:*' actionformats '[%b|%a]'

function _precmd_vcs_info () { LANG=en_US.UTF-8 vcs_info }
add-zsh-hook precmd _precmd_vcs_info

PROMPT='%F{cyan}[%~]%f ${vcs_info_msg_0_}
%F{green}%n%f$ '

setopt auto_pushd
setopt hist_ignore_dups
setopt nobeep
setopt pushd_ignore_dups
setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# expand dir name after =
setopt magic_equal_subst

# specify delimiter for word
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|_-"
zstyle ':zle:*' word-style unspecified

# directory: cyan
# symblink:  magenta
# exe:       red
export LSCOLORS=gxfxxxxxbxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;31'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=31'

alias be='bundle exec'
alias c='cargo'
alias e='emacsclient -nw -a ""'
alias emacs='emacsclient -nw -a ""'
alias g='git'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias ls='ls -F -G'
alias r='rails'
alias reload='source $HOME/.zshrc'
alias rm='rm -i'
alias sl='ls'
alias z='zeus'

# tmux ¾å¤Î vim ¤¬ÂÀ»ú¤Ë¤Ê¤Ã¤Æ¤·¤Þ¤¦ÌäÂê¤ò²óÈò
# http://moqada.hatenablog.com/entry/2013/10/18/02033
alias tmux='TERM=screen-256color tmux'
compdef g=git

export GOPATH=$HOME

export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin" # install golang on /usr/local/go
export PATH="./bin:./mybin:/usr/local/bin:$PATH"
# rust
export PATH="$HOME/.cargo/bin:$PATH"

# http://blog.kentarok.org/entry/2014/06/03/135300
function peco-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^[s' peco-src

function tmux-attach-peco () {
  local selected_session=$(tmux ls | peco | awk '{print $1}' | sed -e 's/.$//')
  if [ -n "$selected_session" ]; then
    if [ -n "$(echo $TMUX)" ]; then
      BUFFER="tmux switch-client -t ${selected_session}"
    else
      BUFFER="tmux a -t ${selected_session}"
    fi
    zle accept-line
  fi
  zle clear-screen
}
zle -N tmux-attach-peco
bindkey '^[t' tmux-attach-peco

function gim () {
  local filename=$(git ls-files | peco)
  vim $filename
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
source $(which virtualenvwrapper.sh)
function tn () {
  tmux new -s $(basename $(pwd))
}
