source $HOME/dotfiles/test-helpers.sh
cd $HOME/dotfiles

headline "UPDATING DOTFILES"
delim

block "BEGIN: COMPILE DOTFILES"
emacs -Q --batch --script $HOME/dotfiles/.doom.d/tangle-dotfiles.el
block "END: COMPILE DOTFILES"
delim

block "BEGIN: STOW DOTFILES"
stow .
block "END: STOW DOTFILES"
delim

block "BEGIN: UPDATE EMACS INSTANCE"
emacsclient \
    -e '(load-file "~/dotfiles/.doom.d/per-system-settings.el")' \
    -a "No emacs server running"
block "END: UPDATE EMACS INSTANCE"
delim


bash $HOME/dotfiles/test-system.sh
