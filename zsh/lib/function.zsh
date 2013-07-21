function open() {
	if [ -d "$1" ]; then
		# Control will enter here if $DIRECTORY exists.
		spacefm $1
	fi
}

function getBattery {
	echo `acpi | awk '{ print $4 }' | cut -d "," -f 1`
}

function mcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }

function getIP {
	wget -q -O - http://checkip.dyndns.com/ | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
}

export PIP=`getIP`
