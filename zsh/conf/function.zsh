function getBattery {
	echo `acpi | awk '{ print $4 }' | cut -d "," -f 1`
}

function md() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }

function getIP {
	wget -q -O - http://checkip.dyndns.com/ | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
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
