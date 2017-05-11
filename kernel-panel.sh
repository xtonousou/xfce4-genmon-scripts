#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
readonly ICON="${DIR}/icons/kernel/linux.png"

# Kernel values
readonly KERNEL=$(uname -r)
readonly UNAME=$(uname -a)

# Panel
if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
  INFO="<img>${ICON}</img>"
  INFO+="<txt>${KERNEL}</txt>"
else 
  INFO="<txt>${KERNEL}</txt>"
fi

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="${UNAME}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
