export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

# Source the system-wide file.

. /etc/bashrc
. $QZ_ALIASES
. $HOME/ns.sh # pyenv

# emacs-vterm display helper
vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# emacs-vterm: clear scrollback
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    function clear(){
        vterm_printf "51;Evterm-clear-scrollback";
        tput clear;
    }
fi

# VTERM PS1
vterm_prompt_end(){
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}
# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    GUIX_ENV_PS1='[env]'
else
    GUIX_ENV_PS1=''
fi

therefore="$(echo -e '\U2234')"
arrow="$(echo -e '\U219D')"
hammer="🔨"
money="💰"
spades="🂡"
king="♚"
dice="🎲"
end=$money
break=""


    PS1="\n┏━❨\A❩━❨\u@\h❩$break"
PS1="$PS1\n┣━❨\w❩$break"
PS1="$PS1\n┗━$GUIX_ENV_PS1$end "

PS1=$PS1'\[$(vterm_prompt_end)\]'

$HOME/.local/bin/unix
