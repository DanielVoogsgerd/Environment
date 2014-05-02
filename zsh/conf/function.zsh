function getBattery {
	echo `acpi | awk '{ print $4 }' | cut -d "," -f 1`
}

function md() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }

function getIP {
	wget -q -O - http://checkip.dyndns.com/ | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
}
function sunrise {
	l=12765843;curl -s http://weather.yahooapis.com/forecastrss?w=$l|grep astronomy | awk -F\" '{print $2;}'
}

function sunset {

}

function killuser {
	skill -KILL -u "$1"
}

function fancyLocate {
	locate "$1" | xargs ls -lsh
}

function compress {
	if [ -f $1 ] || [ -d $1 ];then
		if [ -f $2 ];then
			print "The file already exists"
		else
			HandBrakeCLI -i $1 -o $2 -e x264 -q 20.0 -a 1,1 -E faac,copy:ac3 -B 160,160 -6 stereo -R Auto,Auto -D 0.0,0.0 -f mkv -4 --loose-anamorphic -m -x b-adapt=2:rc-lookahead=50
		fi
	else
		print "Source doesn't exist"
	fi
}

function sshmount {
	if [[ -n "$1" && -n "$2" ]]; then
		server=$(echo "$1"| tr '[:upper:]' '[:lower:]')
		mkdir -p ~/Servers/"$server"
		sshfs "$1":"$2" ~/Servers/"$server" -C
	else
		echo "Unknown arguments.\nUsage: sshmount [FQDN] [REMOTE DIR]"
	fi
}

function amihome {
	if [[ "`pwd`" == $HOME || "`pwd`" == $HOME/* ]]; then
		echo "Inside home"
		return 0
	else
		echo "Outside home"
		return 1
	fi
}

function sambamount {
	if [[ "$1" == "" || "$2" == "" || "$3" == "" || "$(id -u)" != "0" ]]; then
	   echo "Usage: cifsmount <source> <username> <location>"
	   echo "(Root privileges required)"
	   return 1
	fi

	if [[ "$(which mount.cifs)" == "" ]]; then
	   echo "mount.cifs not fount, exiting..."
	   return 1
	fi

	src=${1//\\/\/}

	domain=${2%\\*}
	username=${2#*\\}

	[[ "$SUDO_UID" == "" ]] && uid="$(id -u)" || uid="$SUDO_UID"
	[[ "$SUDO_GID" == "" ]] && gid="$(id -g)" || gid="$SUDO_GID"

	if [[ "$domain" == "$username" ]]; then
	   mount.cifs "$src" -o username=$username,uid=$uid,gid=$gid "$3"
	else
	   mount.cifs "$src" -o domain=$domain,username=$username,uid=$uid,gid=$gid "$3"
	fi
}

function exist {
	if hash "$1" 2>/dev/null; then
			return 0
	else
			return 1
	fi
}

function pacver {
	if exist "pacaur"; then
		pacaur -Si $1 | grep --color=never 'Name\|Version\|Build Date'
	elif exist "packer"; then
		packer -Si $1 | grep --color=never 'Name\|Version\|Build Date'
	elif exist "pacman"; then
		pacman -Si $1 | grep --color=never 'Name\|Version\|Build Date'
	else
		echo "No supported package manager found"
	fi
}

function enablevga {
	DISP="VGA1"
	xrandr --output "$DISP" --auto --$1 LVDS1
}
