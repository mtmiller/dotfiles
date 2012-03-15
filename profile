# ~/.profile -*- mode: sh -*- vi:set ft=sh:
# Executed by the command interpreter for login shells

if [ -n "$BASH_VERSION" ] && [ -r "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
elif [ -r "$HOME/.shrc" ]; then
    . "$HOME/.shrc"
fi
