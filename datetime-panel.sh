#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, gawk, procps-ng

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
if [ "$(date +%d%m)" -eq 2604 ]; then # birthday, 2604 stands for April 26
  readonly ICON="${DIR}/icons/datetime/cake-variant.png"
elif [ "$(date +%H%M)" -eq 0420 ] || [ "$(date +%H%M)" -eq 1620 ]; then # heyy that's pretty good
  readonly ICON="${DIR}/icons/datetime/weed.png"
else
  readonly ICON="${DIR}/icons/datetime/clock.png"
fi

readonly TIME=$(date +%T)
readonly DATE=$(date)

# Panel
if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
  INFO="<img>${ICON}</img>"
  INFO+="<txt>"
else
  INFO="<txt>"
fi
INFO+="${TIME}"
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="${DATE}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
