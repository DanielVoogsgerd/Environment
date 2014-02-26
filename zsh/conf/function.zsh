function open() {
	if [ -d "$1" ]; then
		# Control will enter here if $DIRECTORY exists.
		spacefm $1
	fi
}

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

sshmount() {
	if [ -n "$1" ]; then
		string=$(echo "$1"| tr '[:upper:]' '[:lower:]') 
		mkdir -p ~/Servers/"$string"
		sshfs "$1":/ ~/Servers/"$string" -C
	else
		echo "Unknown arguments.\nUsage: sshmount [FQDN]"
	fi
}
