# -*-Shell-script-*-
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -n $EMACS ]; then
    #export PATH=$PATH:/usr/local/bin:/usr/local/git/bin:/usr/X12/bin
    export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:$PATH:/usr/X12/bin
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export PYTHONPATH=/Library/Python/2.7/site-packages:/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python:$PYTHONPATH
export NODE_PATH=/usr/local/lib/node_module

#export HISTCONTROL=ignoreboth
export HISTCONTROL=erasedups
export HISTSIZE=10000
HISTIGNORE="clear:bg:fg:bar:h:history"
shopt -s histappend

# export EDITOR=vim
export EDITOR="/usr/local/bin/mate -w"
# export EDITOR="subl -w" # let's give it a try...
export HGEDITOR='/Users/nilcolor/hgeditor.sh'

#PS1="[\u@\h] \[\033[0;37m\]\W\$\[\033[0m\] "
# set some color shortcuts
D="\[\033[37;1m\]"
GREEN="\[\033[32;1m\]"
PINK="\[\033[35;1m\]"
MAGENTA="\[\033[36;1m\]"
BLUE="\[\033[34;1m\]"
ORANGE="\[\033[33;1m\]"
RED="\[\033[31;1m\]"
RESET_CLR="\[\033[0m\]"

#PS1="${BLUE}λ${RESET_CLR} "
#PS2="${MAGENTA}>${RESET_CLR} "
### hg prompt using `hg prompt` command
# hg_ps1() {
#   hg prompt "${D} on ${RED}{update}${PINK}{branch}${GREEN}{status}{${RED}⚡{incoming}}" 2>/dev/null
# }
# PS1='\[\n${PINK}\u ${D}at ${ORANGE}\h ${D}in ${GREEN}\w$(hg_ps1) ${RESET_CLR}\n\]$ '
### prompt using `vcprompt` commend ###
export VCPROMPT_FORMAT="[%n:%b%m]"
#PS1='${PINK}\u\e[30;1m@${RESET_CLR}${ORANGE}\h${D}:${BLUE}\w${RED}$(vcprompt)${RESET_CLR}\$ '
PS1="\[\e[34m\]\$(date +%H%M)|\[\e[35m\]\u\[\e[30;1m\]@\[\e[33m\]\h\[\e[37m\]:\[\e[34m\]\W\[\033[31m\]\$(vcprompt)\[\e[0m\]\$ "
#PS1="\[\e[34;1m\]\$(date +%H%M)|\[\e[35;1m\]\u  \[\e[0m\]"
#PS2="${GREEN}>${RESET_CLR} "
### try to set window title. doesn't work with Terminal.app tabs...
if [ -z $EMACS ]; then
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}\007"'
fi

### some Java/Maven
# export M2_HOME=/usr/local/apache-maven/apache-maven-2.1.0
# export M2=$M2_HOME/bin
# export MAVEN_OPTS="-Xms512m -Xmx1024m"
# export PATH=$M2:$PATH
# export PATH="/usr/local/glassfish/bin":$PATH
# Java development scuts
# alias mvnx="echo '-== Maven runs without checkstyle/tests ==-';mvn -Dcheckstyle.skip=true -DskipTests=true"
# alias mvn-debug="mvn -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000 install"
# alias gfstart='asadmin start-domain'
# alias gfstop='asadmin stop-domain'
# alias killjava="ps ax | grep java |grep -v grep | awk '{print($1)}' | xargs kill -9"

#disable XOFF/XON commands from beeing sent via ctrl+S/Ctrl+Q
#i don't need to "pause" terminal... and now i can use Ctrl+S & Ctrl+Q combos
#for ex. - Ctrl+Q now stops rtorrent ;)
stty ixoff -ixon

#iTerm2 needs it to work with Russian output
export LC_CTYPE=UTF-8

set mark-symlinked-directories on
set completion-ignore-case on

# aliases
alias l="ls -l"
alias ll="ls -al"
alias ls="ls -apFGlh"
alias m="mate"
#alias cd..='cd ..'
alias h="history"
alias bar='echo -e "\033[1;37;44m================================================================================\033[0m"'
alias colors='echo -e "\033[0m
\033[30m30    \033[31m31    \033[32m32    \033[33m33    \033[34m34    \033[35m35    \033[36m36    \033[37m37    \033[0m
\033[30;1m30;1m \033[31;1m31;1m \033[32;1m32;1m \033[33;1m33;1m \033[34;1m34;1m \033[35;1m35;1m \033[36;1m36;1m \033[37;1m37;1m \033[0m
"'
### task aliases ###
alias t="task"
alias t+="task add"
alias tl="task ls"

# Git aliases
alias gs="git status -sb"
alias gc="git commit" #i'd like to use vim. or i can add -m "..." manually
alias gca="git commit -a"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias grm="git status | grep deleted | awk '{print $3}' | xargs git rm"
alias gic="git fetch && git log ..@{u}"

alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# Mercurial stuff
hgtarget() {
    hg_root=`hg root 2>&1 | egrep -v "$abort:"`
    if [ $hg_root ]; then
        if [ -f $hg_root/.hg/hgrc ]; then
            hg_target=`cat $hg_root/.hg/hgrc | egrep "^default =" | sed 's/\(^default = \(http:\/\/\)*\)\(.*@\)*//'`
            echo "$hg_target"
        fi
    fi
}

# look for lists of files in piped output, sort the unique set of them and print them one per line
lf() {
    egrep "^files:" | awk '{for (i=2; i<=NF; i++) print $i}' | sort | uniq
}

vcst() {
    # print out all of the files with a passed in status flag (M - modified, A - added, ? - unknown, etc) (default ?)
    # expects first parameter to be the version control command (likely svn or hg)
    STATUS='\?'
    if [ -n "$2" ]
    then
        STATUS=$2
    fi
    $1 status | egrep "^$STATUS" | awk '{print $2}'
}

alias ic="hg incoming -v | lf"
alias og="hg outgoing -v | lf"
alias svnst='vcst svn'
alias hgst='vcst hg'

alias count_files='ls -aRF | wc -l'

-orig() {
    if [ -n "$1" ]; then
        echo 'removing all *.orig files down a tree...'
        find . -name *.orig | xargs rm
    else
        echo 'current *.orig files down a tree'
        find . -name *.orig
    fi
}

#start/stop dev vm (fusion)
# vr() {
#     DEVVM='/Users/nilcolor/.../Ubuntu 9.10 server.vmx'
#     if [ -z "$1" ]; then
#         vmrun list
#         return 0
#     fi
#     vmrun -T fusion "$1" "$DEVVM" "$2"
# }
# alias devrun="vr start nogui"
# alias devstop="vr stop soft"

[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && . "/usr/local/bin/virtualenvwrapper.sh" # should load virtualenv wrapper aliases/functions

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#echo "================== SCREEN STATUS =================================="
#screen -ls
#echo "==================================================================="

#if there is a local .profile - include it
if [ -f "$HOME/.profile-local" ]; then
    . "$HOME/.profile-local"
fi
