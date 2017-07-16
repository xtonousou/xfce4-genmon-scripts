#!/usr/bin/env bash
# Dependencies: bash>=3.2, bc, coreutils, file, gawk, ship>=2.6 (see https://github.com/xtonousou/shIP)

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
readonly ICON="${DIR}/icons/network/web.png"

# Displays all active network interfaces with their IPv4 addresses (local)
readonly TOOLTIP=$(ship --ipv4)

# You can pass the desired network interface on the command
# On the generic monitor properties
# e.g. /path/to/network-panel.sh eth0
if [ ! -z "${1}" ]; then
  if ship --all-interfaces | grep -w "${1}" &> /dev/null; then
    readonly INTERFACE="${1}"
  else
    # Fallback option - Argument is invalid
    # Handle 'no active interfaces at all' case
    if [[ $(ship --interfaces | awk '{print $1}') = "" ]]; then
      # Fallback option - No argument - No active network interface
      # Assign the second available network interface (first is loopback)
      readonly INTERFACE=$(ship --all-interfaces | awk '{print $2}')
    else
      # Fallback option - No argument
      # Default value is the first available active network interface
      readonly INTERFACE=$(ship --interfaces | awk '{print $1}')
    fi
  fi
else
  # Handle 'no active interfaces at all' case
  if [[ $(ship --interfaces | awk '{print $1}') = "" ]]; then
    # Fallback option - No argument - No active network interface
    # Assign the second available network interface (first is loopback)
    readonly INTERFACE=$(ship --all-interfaces | awk '{print $2}')
  else
    # Fallback option - No argument
    # Default value is the first available active network interface
    readonly INTERFACE=$(ship --interfaces | awk '{print $1}')
  fi
fi

# Handle offline user's state
ip route | grep ^default &>/dev/null || \
  echo -ne "<txt>Disconnected</txt>" || \
    echo -ne "<tool>Disconnected</tool>" || \
      exit

# Handle missing, unknown network interfaces
test -d "/sys/class/net/${INTERFACE:-qwerty}" || \
  echo -ne "<txt>Invalid ${INTERFACE}</txt>" || \
    echo -ne "<tool>No statistics for ${INTERFACE}</tool>" || \
      exit

PRX=$(awk '{print $0}' "/sys/class/net/${INTERFACE}/statistics/rx_bytes")
PTX=$(awk '{print $0}' "/sys/class/net/${INTERFACE}/statistics/tx_bytes")
sleep 1
CRX=$(awk '{print $0}' "/sys/class/net/${INTERFACE}/statistics/rx_bytes")
CTX=$(awk '{print $0}' "/sys/class/net/${INTERFACE}/statistics/tx_bytes")

BRX=$(( CRX - PRX ))
BTX=$(( CTX - PTX ))

function to_human_readable_output () {
  
  local BANDWIDTH="${1}"
  local P=0
  
  while [[ $(echo "${BANDWIDTH}" '>' 1024 | bc -l) -eq 1 ]]; do
    BANDWIDTH=$(awk '{$1 = $1 / 1024; printf "%.2f", $1}' <<< "${BANDWIDTH}")
    P=$(( P + 1 ))
  done
  
  case "${P}" in
    0) BANDWIDTH="${BANDWIDTH} B/s" ;;
    1) BANDWIDTH="${BANDWIDTH} KB/s" ;;
    2) BANDWIDTH="${BANDWIDTH} MB/s" ;;
    3) BANDWIDTH="${BANDWIDTH} GB/s" ;;
  esac
  
  echo -e "${BANDWIDTH}"
  
  return 0
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
INFO+="↓<span weight='Bold' fgcolor='Red'> ${RX}</span>"
INFO+=" "
INFO+="↑<span weight='Bold' fgcolor='Green'> ${TX}</span>"
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="${TOOLTIP}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
