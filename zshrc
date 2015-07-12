autoload -U compinit
compinit

if [ -f ~/.profile ] ; then
    source ~/.profile
fi

if [[ "$USER" == "root" ]] then
PROMPT=$'%{\e[0;32m%}\[%{\e[0;31m%}%T%{\e[0;32m%}\]%{\e[0;32m%}\[%{\e[0;33m%}%m%{\e[0;32m%}\]%{\e[0;32m%}\[%{\e[0;34m%}%~%{\e[0;32m%}\] %{\e[0;31m%}\#%{\e[0;32m%} '
else
PROMPT=$'%{\e[0;32m%}\[%{\e[0;31m%}%T%{\e[0;32m%}\]%{\e[0;32m%}\[%{\e[0;33m%}%m%{\e[0;32m%}\]%{\e[0;32m%}\[%{\e[0;34m%}%~%{\e[0;32m%}\] %{\e[0;35m%}\$%{\e[0;32m%} '
fi

zstyle ':completion:*' menu yes select

export LC_ALL="en_US.UTF-8"

if [[ "$(uname -s)" = "FreeBSD" ]] then
	if [ -f /usr/local/bin/grc ]; then
	  alias ping="grc --colour=auto ping"
	  alias traceroute="grc --colour=auto traceroute"
	  alias make="grc --colour=auto make"
	  alias diff="grc --colour=auto diff"
	  alias cvs="grc --colour=auto cvs"
	  alias netstat="grc --colour=auto netstat"
	fi
	if [ -f /usr/local/bin/vim ]; then
		export VISUAL=/usr/local/bin/vim
		export EDITOR=/usr/local/bin/vim
		else
		export VISUAL=/usr/bin/ee
		export EDITOR=/usr/bin/ee
	fi
	alias ls='ls -Gh'
	alias ls_size='ls -lGh | sort -n +4'
	alias ll="ls -A"
	alias la="ls -lA"
	alias ..='cd ..'
fi

if [[ "$(uname -s)" = "Linux" ]] then
	if [ -f /usr/bin/grc ]; then
	  alias ping="grc --colour=auto ping"
	  alias tt="grc --colour=auto traceroute"
	  alias make="grc --colour=auto make"
	  alias diff="grc --colour=auto diff"
	  alias cvs="grc --colour=auto cvs"
	  alias netstat="grc --colour=auto netstat"
	fi
	if [ -f /usr/bin/vim ]; then
		export VISUAL=/usr/bin/vim
		export EDITOR=/usr/bin/vim
		else
		export VISUAL=/usr/bin/nano
		export EDITOR=/usr/bin/nano
	fi
	alias ls='ls -h --color'
	alias ls_size='ls -h --color | sort -n +4'
	alias ll="ls -A --color"
	alias la="ls -lA --color"
	alias ..='cd ..'
fi

zmodload -i zsh/complist
bindkey -M menuselect "^M" .accept-line

hosts=(`cat ~/.ssh/known_hosts | tr , " " | awk '{ print $1 }'  ; cat /etc/hosts | grep -v '^#' | awk '{print $2}'`)
zstyle '*' hosts $hosts
zstyle ':completion:*:(ssh|scp):*:users' ignored-patterns `cat /etc/passwd | awk -F ":" '{ if($3<1000) print $1 }'`
if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi
if [ -d ~/.bin ] ; then
  PATH=~/.bin:"${PATH}"
fi

if [ -f ~/.dircolors ] ; then
    eval $(dircolors -b $HOME/.dircolors)
    export LSCOLORS
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='4;35'


HISTFILE=~/.zhistory

SAVEHIST=5000

HISTSIZE=5000

DIRSTACKSIZE=20

setopt  APPEND_HISTORY

setopt  HIST_IGNORE_ALL_DUPS

setopt  HIST_IGNORE_SPACE

setopt  HIST_REDUCE_BLANKS

case $TERM in
        linux)
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
bindkey " " magic-space ## do history expansion on space
;;
*xterm*|screen|rxvt|(dt|k|E)term)
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
bindkey " " magic-space ## do history expansion on space
;;
esac

case $TERM in (screen|xterm*|rxvt)
precmd () { print -Pn "\e]0;%n@%m: %~\a" }
preexec () { print -Pn "\e]0;%n@%m: $*\a" }
;;
esac

function update_rc_files(){
    if [ -f /usr/bin/wget ] ; then
        /usr/bin/wget -q -O ~/.zshrc https://raw.githubusercontent.com/corebug/dotfiles/master/zshrc ;
        /usr/bin/wget -q -O ~/.vimrc https://raw.githubusercontent.com/corebug/dotfiles/master/vimrc ;
        /usr/bin/wget -q -O ~/.tmux.conf https://raw.githubusercontent.com/corebug/dotfiles/master/tmux.conf ;
        /usr/bin/wget -q  -O ~/.dircolors https://raw.githubusercontent.com/corebug/LS_COLORS/master/LS_COLORS
        source ~/.zshrc
        echo "rc files were succesfully updated."

    else
        echo "Wget not found :-("
    fi
}

#XXX:MySQL
function tableSize(){
    mysql -e "SELECT TABLE_NAME, table_rows, data_length, index_length,
    round(((data_length + index_length) / 1024 / 1024),2) 'Size in MB'
    FROM information_schema.TABLES WHERE table_schema = '$1';"
};
alias dbSize="mysql -e \"SELECT table_schema \\\"Data Base Name\\\", sum( data_length + index_length ) / 1024 / 1024 \\\"Data Base Size in MB\\\" FROM information_schema.TABLES GROUP BY table_schema;\""

#Pwgen
if [ -f /usr/bin/pwgen ] ; then
    alias pwgen="/usr/bin/pwgen -Bnv 8"
fi

# Esc + .
bindkey '\e.' insert-last-word


## Aliases
alias cd..='cd ..'
alias su='sudo zsh'
alias tt="tracepath"
alias ss="sudo sudo -u"
alias s="sudo"
alias ta="tmux attach"
alias lsn='stat -c "%a %n"'
alias trailing_whitespaces='find . -name "*" -type f | xargs egrep -l ".* +$"'
alias remove_trailing_whitespaces="sed -i 's/\s*$//g'"
alias ips='grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"'
alias pp='python -c "import sys, json; print json.dumps(json.load(sys.stdin), sort_keys=True, indent=4)"'

# Host-specific shell variables and aliases
if [ -d ~/.host_specific_vars ] ; then
    if find ~/.host_specific_vars -mindepth 1 -print -quit | grep -q .; then
        for FILE in `find ~/.host_specific_vars -type f` ; do
            source ${FILE}
        done
    fi
fi

