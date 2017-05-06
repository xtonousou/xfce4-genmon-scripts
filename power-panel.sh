#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, xfce4-session

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
readonly ICON="${DIR}/icons/power/power.png"
# Uncomment the below and comment out the above if you prefer the apple logo instead
#readonly ICON="${DIR}/icons/power/apple.png"

# Panel
if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
  INFO="<img>${ICON}</img>"
  INFO+="<click>xfce4-session-logout</click>"
else
  INFO+="<click>xfce4-session-logout</click>"
fi

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="Power Management"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
