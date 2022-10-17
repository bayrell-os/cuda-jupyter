. /etc/profile

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

JUPYTER_ENABLE_LAB=yes
export JUPYTER_ENABLE_LAB
