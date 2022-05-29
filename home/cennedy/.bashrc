# .bashrc

#Exports
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

PS1="{ \w } \e[00;31m\]\$ \e[01;37m\]"

#Aliases
alias sudo="doas"

#package-manager
alias xi="doas xbps-install"
alias xr="doas xbps-remove"
alias xq="doas xbps-query -Rs"

#navigate-directories
alias ..="cd .."
alias ls="ls --color=auto"
alias l="ls -la"
alias ll="ls -l"
alias la="ls -a"

#git
alias status="git status"
alias push="git push origin"
alias pull="git pull origin"
alias commit="git commit -m"
alias add="git add ."
alias gitname="git config --global user.name 'Cevdet Arda Haran'"
alias gitmail="git config --global user.mail 'cevdet@tutamail.com'"

#poweroff
alias po="doas shutdown now"
alias rs="doas reboot"

#file-access
alias cp="cp -riv"
alias mv="mv -iv"
alias mkdir="mkdir -vp"

#editors
alias v="nvim"
alias n="nano"

#youtube
alias ytm="yt-dlp --extract-audio --audio-format mp3"
alias ytv="yt-dlp -f bestvideo+bestaudio"

ex ()
{
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1   ;;
        *.tar.gz)    tar xzf $1   ;;
        *.bz2)       bunzip2 $1   ;;
        *.rar)       unrar x $1   ;;
        *.gz)        gunzip $1    ;;
        *.tar)       tar xf $1    ;;
        *.tbz2)      tar xjf $1   ;;
        *.tgz)       tar xzf $1   ;;
        *.zip)       unzip $1     ;;
        *.Z)         uncompress $1;;
        *.7z)        7za e x $1   ;;
        *.deb)       ar x $1      ;;
        *.tar.xz)    tar xf $1    ;;
        *.tar.zst)   unzstd $1    ;;
        *)           echo "'$1' cannot be extracted via ex()" ;;
   esac
  else
    echo "'$1' is not a valid file"
  fi
}
