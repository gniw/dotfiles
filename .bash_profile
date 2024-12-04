#
# ~/.bash_profile
#

# load profile
. "$HOME/.profile"

# load bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# remove duplicate path
PATH=$(printf %s "$PATH" | awk -v RS=: -v ORS=: '!a[$0]++')
