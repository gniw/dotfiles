#
# ~/.profile
#

export EDITOR=nvim

# remove duplicate path
PATH=$(printf %s "$PATH" | awk -v RS=: -v ORS=: '!a[$0]++')
