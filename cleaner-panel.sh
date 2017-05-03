#!/usr/bin/env bash
# Dependencies: coreutils, file

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
readonly ICON="${DIR}/icons/cleaner/broom.png"

# Script to clean memory
readonly CLEAN="${DIR}/clean.sh"

# Panel
if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
  INFO="<img>${ICON}</img>"
  if [[ $(file -b "${CLEAN}") =~ sh ]]; then
    INFO+="<click>${CLEAN}</click>"
  fi
  INFO+="<txt>"
else
  INFO="<txt>"
  INFO+="Icon is missing!"
fi
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="Clean Memory"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
