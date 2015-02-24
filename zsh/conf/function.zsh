function md() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }

function getIP {
    wget -q -O - http://checkip.dyndns.com/ | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
}

function fuck {
    if [[ "$1" == "you" ]]; then
        shift
        pkill -9 "$@"
    else
        echo "Fuck who??"
    fi
}

function sudo {
    if [[ "$1" == "vim" ]]; then
        echo "Please stop doing that! Use sudoedit instead"
    else
        /usr/bin/sudo "$@"
    fi
}
function die() {
   echo $1
   return 1
}

function killuser {
    skill -KILL -u "$1"
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
    if hash "pacaur" 2>/dev/null; then
        pacaur -Si $1 | grep --color=never 'Name\|Version\|Build Date'
    elif hash "packer" 2>/dev/null; then
        packer -Si $1 | grep --color=never 'Name\|Version\|Build Date'
    elif hash "pacman" 2>/dev/null; then
        pacman -Si $1 | grep --color=never 'Name\|Version\|Build Date'
    else
        echo "No supported package manager found"
    fi
}

function vga {
    case "$1" in
        "enable")
            xrandr --output "VGA1" --$2 LVDS1 --auto
            ;;
        "disable")
            xrandr --output "VGA1" --off
        ;;

        *)
            echo "What do you want to do?"
    esac
}

function editbin {
    $EDITOR `which $1`
}

function server {
    if [ -n "$1" ]; then
        PORT="$1"
    else
        PORT="8000"
    fi

    xdg-open "http://localhost:$PORT/"
    php -S localhost:$PORT
}

function bak {
    mv "$1" "$1.bak"
}

function edit {
	FILE=$1
	if [ -w "$FILE" ]; then
		echo "Write permission is granted on $FILE"
		if hash "$VISUAL" 2>/dev/null; then
			$VISUAL "$FILE"
		elif hash "$EDITOR" 2>/dev/null; then
			$EDITOR "$FILE"
		else
			echo "The specified editors couldn't be found"
			return 1
		fi

	else
		echo "Write permission is NOT granted on $FILE"
		echo "Opening using sudoedit"
		notify-send "No write permission. Opening using sudo"
		sudoedit $FILE
    fi
}

function calc() {
	local result="";
	result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";

	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		printf "$result" |
		sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
		    -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
		    -e 's/0*$//;s/\.$//';  # remove trailing zeros
	else
		printf "$result";
	fi;
	printf "
";
}

function digga {
	if [ -z "$1" ]; then
		echo "usage: $0 [domain]"
		echo "       $0 [domain] [type]"
		return 1
	else
		local domain="$1"
	fi
	
	if [ -z "$2" ]; then
		local type="any"
	else
		local type="$2"
	fi
	
	dig +nocmd "$domain" "$type" +multiline +noall +answer;
}