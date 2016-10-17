function md() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }

function getIP {
    wget -q -O - http://checkip.dyndns.com/ | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
}

function fuck {
    if [[ "$1" == "you" ]]; then
        shift
        pkill -9 "$@"
    elif [[ "$1" == "of" ]]; then
        shift
        pkill -9 "$@"
    else
        echo "Fuck who??"
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
	if [ -w "$FILE" ] || [ -w "$(dirname $FILE)" ]; then
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
		sleep 0.5
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
	printf "\n";
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


# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function codepoint() {
	perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi;
}

function json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript;
	else # pipe
		python -mjson.tool | pygmentize -l javascript;
	fi;
}

function gz() {
	if [ -z "$1" ]; then
		echo "No file specified"
		echo "Usage: $0 [file]"
		return 1
	fi
	if [ ! -f "$1" ]; then
		echo "File '$1' not found"
		echo "Usage: $0 [file]"
		return 1
	fi

	local origsize=$(wc -c < "$1");
	local gzipsize=$(gzip -c "$1" | wc -c);
	local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
	echo "Filesize comparison"
	printf "Original:          %d bytes\n" "$origsize";
	printf "Compressed (gzip): %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

function gitio() {
	if [ -z $1 ]; then
		echo "Usage: $0 [github url]";
		return 1;
	fi;
	curl -i http://git.io/ -F "url=$1" 2>&1 > /dev/null | grep ^Location | awk '{ print $2 }' | cb
}

function tailgrep {
	if [ -z $1 ] || [ -z $2 ]; then
		echo "Usage: $0 [pattern] [file]"
		return 1
	fi

	tail -f $2 | grep --line-buffered $1
}

function env-update {
	pushd ~/Environment > /dev/null
	git pull
	popd > /dev/null
	pushd ~/Environment/userspecific > /dev/null
	git pull
	popd > /dev/null

	vim +PluginInstall +qall
}

function httptrace {
	curl -vsL "$1" -o /dev/null 2>&1 | grep -v "^\*" | grep "Host\|HTTP\|Location" | cut -d " " -f 2-
}

function vcs_super_info_wrapper {
	if [[ "$(stat -f -c %T .)" != 'cifs' ]]; then
		vcs_super_info
	fi
}

function shell_icon {
	if [[ "$(stat -f -c %T .)" == 'cifs' ]]; then
		echo "☁"
	else
		echo "$"
	fi
}

function offload {
	if [[ -e $1 ]]; then
		sudo mv $1 "/media/data/offload/$1"
		ln -s "/media/data/offload/$1"
	fi
}

function genssl {
	if [ -z $1 ]; then
		echo "No certname specified"
		exit 1
	fi

	if [ -z $2 ]; then
		local hash="sha512"
	else
		local hash="$2"
	fi

	openssl req -new -newkey rsa:4096 -"$hash" -nodes -keyout $1.key -out $1.csr
}

# Finds a matching file structure and tries to build for it
function build {
	if ls src/*.ino 1> /dev/null 2>&1; then
		echo "Matched Arduino pattern"
		ino clean
		ino build
	fi
}

# Function works better than alias to fool autocomplete
function diff {
	git diff --no-index -- $@
}

function certinfo {
	local ext=$(echo $1 | sed 's/.*\.//')
	local format="pem"
	if [ $ext = "cer" ]; then
		local format="der"
	fi
	openssl x509 -in $1 -inform $format -noout -text
}
