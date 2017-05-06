#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, grep, iputils, pacman, yaourt

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
readonly ICON="${DIR}/icons/others/pacman.png"

# Check if network connection exists and then calculate the updates
readonly AUR=$(yaourt -Qua | grep "^aur/" | tee /tmp/aurupdates | wc -l)
readonly OFFICIAL=$(checkupdates | tee /tmp/pacmanupdates | wc -l)
readonly ALL=$(( AUR + OFFICIAL ))

# Panel
if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
  INFO="<img>${ICON}</img>"
  INFO+="<txt>"
else
  INFO="<txt>"
fi
INFO+="${ALL}"
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="┌ Outdated packages\n"
MORE_INFO+="├─ From official repositories: ${OFFICIAL}\n"
MORE_INFO+="└─ From unofficial repositories: ${AUR}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
