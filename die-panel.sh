#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
declare -r ICON_ARRAY=(
  "${DIR}/icons/others/dice-1.png"
  "${DIR}/icons/others/dice-2.png"
  "${DIR}/icons/others/dice-3.png"
  "${DIR}/icons/others/dice-4.png"
  "${DIR}/icons/others/dice-5.png"
  "${DIR}/icons/others/dice-6.png"
)

# Compute random die
DIE=$(( RANDOM % 6 ))

# Panel
if [[ $(file -b "${ICON_ARRAY[DIE]}") =~ PNG|SVG ]]; then
  INFO="<img>${ICON_ARRAY[DIE]}</img>"
fi

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="$(( DIE + 1 ))"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
