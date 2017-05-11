#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, gawk, ship>=2.6 (see https://github.com/xtonousou/shIP)

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
readonly ICON="${DIR}/icons/network/web.png"

# Declaring interfaces
declare -r ACTIVE_INTERFACES_ARRAY=($(ship -i))
# can be replaced manually (recommended) e.g. INTERFACE="eth0"
readonly INTERFACE=$(ship -i | awk '{print $1}') # <-------------------

# Handle missing, unknown network interfaces
test -d "/sys/class/net/${INTERFACE:-qwerty}" || \
  echo "<txt>No ${INTERFACE}</txt>" || \
    echo "<tool>No statistics for ${INTERFACE}</tool>" || \
      exit

PRX=$(awk '{print $0}' /sys/class/net/${INTERFACE}/statistics/rx_bytes)
PTX=$(awk '{print $0}' /sys/class/net/${INTERFACE}/statistics/tx_bytes)
sleep 1
CRX=$(awk '{print $0}' /sys/class/net/${INTERFACE}/statistics/rx_bytes)
CTX=$(awk '{print $0}' /sys/class/net/${INTERFACE}/statistics/tx_bytes)

BRX=$(( CRX - PRX ))
BTX=$(( CTX - PTX ))

function to_human_readable_output () {
  
  local BANDWIDTH="${1}"
	local P=0
  
	while [ "${BANDWIDTH}" -gt 1024 -a "${P}" -le 3 ]; do
		BANDWIDTH=$(( BANDWIDTH / 1024 ))
		P=$(( P + 1 ))
	done
  
	case "${P}" in
		0) BANDWIDTH="${BANDWIDTH} B/s" ;;
		1) BANDWIDTH="${BANDWIDTH} KB/s" ;;
		#2) BANDWIDTH="${BANDWIDTH} MB/s" ;; # ghosting (because of the BASH maths)
		#3) BANDWIDTH="${BANDWIDTH} GB/s" ;; # ghosting (because of the BASH maths)
	esac
  
	echo "${BANDWIDTH}"
}

RX=$(to_human_readable_output ${BRX})
TX=$(to_human_readable_output ${BTX})

# Panel
if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
  INFO="<img>${ICON}</img>"
  INFO+="<txt>"
else
  INFO="<txt>"
fi
INFO+="↑ ${RX} ↓ ${TX}"
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="${INTERFACE}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
