# Set a DISPLAY if we are running an ssh session
test -n "$SSH_CLIENT" -a -z "$DISPLAY" && export DISPLAY=":1"

# Set up dbus for remote SSH connections
if [ -n "$SSH_CLIENT" -a -n "$DISPLAY" -a -n "$(pgrep pidgin)" ]; then
    grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep pidgin -n -u $USER)/environ |tr '\0' '\n' > ~/.dbus/address-file && export $(cat ~/.dbus/address-file)
fi

# Allow any host to connect automatically
# I.e. disable remote host management and authentication for Xorg
(xhost +; xset -dpms; xset s off) > /dev/null 2> /dev/null

# Load up colors and smart completion
autoload colors
colors
autoload -U compinit
compinit
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Custom PS1
PS1="%(?.%{$fg[blue]%}.%{$fg[red]%})$HOST%{$reset_color%} "
#export LANG="sk_SK.UTF-8"
#export LC_COLLATE="C"
export SDL_AUDIODRIVER=pulse
# Some basic aliases...
alias ls="ls --color"
alias ll="ls -l"
alias vim="vim -p"

function vol {
	local V=$2
	test -z "$V" && V=3
	case "$1" in
	up)
		local M="+"
		;;
	down)
		local M="-"
		;;
	*)
		echo "Usage: vol up/down [VAL]"
		return 1
		;;
	esac
	amixer -D pulse sset Master "$V%$M"
}
alias volup="vol up"
alias voldown="vol down"

function wakeup {
	echo "Welcome to CUSTOM function 'wakeup'"
	case "$1" in
	a*) # archie
		wol '40:8d:5c:5a:2c:07'
		;;
	r*) # remote)
		wol -p 1309 -i remote '40:8d:5c:5a:2c:07'
		;;
	*)
		echo "Unknown device '$1'"
		echo "Available device: archie remote"
		return 1
		;;
	esac
}

function connect {
	echo "Welcome to CUSTOM function 'connect'"
	case "$1" in
	a*) # archie
		ssh borix@archie
		;;
	r*) # remote)
		ssh -p 1322 borix@remote
		;;
	*)
		echo "Unknown device '$1'"
		echo "Available devices: archie remote"
		return 1
		;;
	esac
}

function disconnect {
	echo "Welcome to CUSTOM function 'disconnect'"
	case "$1" in
	a*) # archie
		ssh borix@archie sudo systemctl suspend
		;;
	r*) # remote)
		ssh -p 1322 borix@remote sudo systemctl suspend
		;;
	*)
		echo "Unknown device '$1'"
		echo "Available devices: archie remote"
		return 1
		;;
	esac
}

function screen {
	case "$1" in
	on|off)
		xset dpms force "$1"
		;;
	unlock)
		xdotool type afx
		sleep 1
		xdotool key Return
		;;
	lock)
		gnome-screensaver-command -l
		;;
	*)
		echo "Usage: screen on/off/lock/unlock"
		return 1
		;;
	esac
}

function mpp() {
	pidof -s plugin-container > /dev/null && echo "/proc/$(pidof -s plugin-container)/fd"
}

function mpl {
	test -z "$(mpp)" && return 1
	local _found="n"
	for i in "$(mpp)"/*; do
		readlink -f "$i" | grep -q Flash && {
			echo -n '' $(echo "$i" | cut -d '/' -f 5)
			_found="y"
		}
	done
	test "$_found" = "n" && return 1
	echo " "
}

function mpf {
	mpl | grep -q " $1 " || {
		echo "No such flash file"
		return 1
	}
	mpv "$(mpp)/$1"
}

function mpc {
	mpl | grep -q " $1 " || {
		echo "No such flash file"
		return 1
	}
	cp "$(mpp)/$1" "$(readlink -f $(mpp)/$1 | awk '{print $1}' | cut -d '/' -f 3)"
}

function plast {
	test -z "$1" && return 2
	ITEMS="$2"
	test -z "$ITEMS" && ITEMS=10
	find "$1" -printf "%h/%f\n" |sort|tail -"${ITEMS}"|xargs -d '\n' mplayer
}

function kojidl {
	test -z "$1" && return 2
	_owner=$(koji taskinfo "$1" |grep Owner: | awk '{print $2}')
	wget -r --no-parent --no-directories --accept '*.rpm' --reject '*debuginfo*' "http://kojipkgs.fedoraproject.org/scratch/$_owner/task_$1/"
}

export EDITOR=vim
export PATH=$PATH:/home/branto/.local/bin

parsed$(uname -m)

#Bind Home/End buttons # always broken :-/
#bindkey '\eOH'    beginning-of-line  # gnome-terminal
#bindkey '\eOF'    end-of-line        # gnome-terminal
#bindkey "${terminfo[khome]}" beginning-of-line
#bindkey "${terminfo[kend]}" end-of-line

# vim: noexpandtab sw=8
