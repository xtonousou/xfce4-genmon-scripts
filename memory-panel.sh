#!/usr/bin/env bash

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
readonly ICON="${DIR}/icons/memory/memory.png"

# Optional script to run on icon click
# Insert the absolute path of the script
# Must set the icon first
readonly ONCLICK="${DIR}/zenity/clean-memory.sh"

# RAM Values
readonly TOTAL=$(free -m | awk '/[Mm]em/{print $2}' | awk '{$1 = $1 / 1024; printf "%.2f", $1}')
readonly USED=$(free -m | awk '/[Mm]em/{print $3}' | awk '{$1 = $1 / 1024; printf "%.2f", $1}')
readonly FREE=$(free -m | awk '/[Mm]em/{print $4}' | awk '{$1 = $1 / 1024; printf "%.2f", $1}')
readonly SHARED=$(free -m | awk '/[Mm]em/{print $5}' | awk '{$1 = $1 / 1024; printf "%.2f", $1}')
readonly CACHE=$(free -m | awk '/[Mm]em/{print $6}' | awk '{$1 = $1 / 1024; printf "%.2f", $1}')

# Swap Values
readonly SWP_TOTAL=$(free -m | awk '/[Ss]wap/{print $2}' | awk '{$1 = $1 / 1024; printf "%.2f", $1}')
readonly SWP_USED=$(free -m | awk '/[Ss]wap/{print $3}' | awk '{$1 = $1 / 1024; printf "%.2f", $1}')
readonly SWP_FREE=$(free -m | awk '/[Ss]wap/{print $4}' | awk '{$1 = $1 / 1024; printf "%.2f", $1}')

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
INFO+="／"
INFO+="${TOTAL} GB"
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="┌ RAM\n"
MORE_INFO+="├─ Used\t\t${USED} GB\n"
MORE_INFO+="├─ Free\t\t${FREE} GB\n"
MORE_INFO+="├─ Shared\t${SHARED} GB\n"
MORE_INFO+="├─ Cache\t${CACHE} GB\n"
MORE_INFO+="└─ Total\t\t${TOTAL} GB"
MORE_INFO+="\n\n"
MORE_INFO+="┌ SWAP\n"
MORE_INFO+="├─ Used\t\t${SWP_USED} GB\n"
MORE_INFO+="├─ Free\t\t${SWP_FREE} GB\n"
MORE_INFO+="└─ Total\t\t${SWP_TOTAL} GB"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
