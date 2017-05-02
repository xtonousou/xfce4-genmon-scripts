#!/usr/bin/env bash

# Makes the script more portable
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
ICON="${DIR}/icons/memory.png"

# Optional script to run on icon click
# Insert the absolute path of the script
# Must set the icon first
ONCLICK="${DIR}/zenity/clean-memory.sh"

# RAM Values
TOTAL=$(free -m | awk '/[Mm]em/{print $2}' | awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GB"}')
USED=$(free -m | awk '/[Mm]em/{print $3}' | awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GB"}')
FREE=$(free -m | awk '/[Mm]em/{print $4}' | awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GB"}')
SHARED=$(free -m | awk '/[Mm]em/{print $5}' | awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GB"}')
CACHE=$(free -m | awk '/[Mm]em/{print $6}' | awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GB"}')

# Swap Values
SWP_TOTAL=$(free -m | awk '/[Ss]wap/{print $2}' | awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GB"}')
SWP_USED=$(free -m | awk '/[Ss]wap/{print $3}' | awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GB"}')
SWP_FREE=$(free -m | awk '/[Ss]wap/{print $4}' | awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GB"}')

# Panel
if [ -f "${ICON}" ]; then
  INFO="<img>${ICON}</img>"
  if [ -f "${ONCLICK}" ]; then
    INFO+="<click>${ONCLICK}</click>"
  fi
  INFO+="<txt>"
else
  INFO="<txt>"
fi
INFO+="${USED}"
INFO+=" "
INFO+="${TOTAL}"
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="┌ RAM\n"
MORE_INFO+="├─ Used\t\t${USED}\n"
MORE_INFO+="├─ Free\t\t${FREE}\n"
MORE_INFO+="├─ Shared\t${SHARED}\n"
MORE_INFO+="├─ Cache\t${CACHE}\n"
MORE_INFO+="└─ Total\t\t${TOTAL}\n"
MORE_INFO+="\n"
MORE_INFO+="┌ SWAP\n"
MORE_INFO+="├─ Used\t\t${SWP_USED}\n"
MORE_INFO+="├─ Free\t\t${SWP_FREE}\n"
MORE_INFO+="└─ Total\t\t${SWP_TOTAL}\n"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
