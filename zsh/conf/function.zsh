function getBattery {
	echo `acpi | awk '{ print $4 }' | cut -d "," -f 1`
}

function md() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }

function getIP {
	wget -q -O - http://checkip.dyndns.com/ | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
}

export PIP=`getIP`

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

function sshmount() {
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
