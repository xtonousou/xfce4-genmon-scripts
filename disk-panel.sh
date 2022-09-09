#!/usr/bin/env bash
# Dependencies: bash>=3.2, bleachbit(optional), coreutils, file, gawk, hddtemp, bc

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
readonly ICON="${DIR}/icons/disk/database.png"

# Command to grab current HDD's temperature
# Change --unit to F if you don't want Celsius as default
# Virtual Machines will report 0 ℃
GET_TEMP=$(sudo hddtemp --unit=C --wake-up --quiet --numeric /dev/sda)

# To determine if colors are applied
OVERHEAT=0

# Panel
INFO=""
if hash bleachbit &> /dev/null; then
  INFO+="<click>bleachbit &> /dev/null</click>"
elif hash gparted &> /dev/null; then
  INFO+="<click>gparted &> /dev/null</click>"
fi

if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
  INFO+="<img>${ICON}</img>"
fi

USED_SPACE=$(awk '{$1 = $1 / 1048576; printf "%.2f", $1}' <<< $(df / | awk '/\/dev/{print $3}'))
TOTAL_SPACE=$(awk '{$1 = $1 / 1048576; printf "%.2f", $1}' <<< $(df / | awk '/\/dev/{print $2}'))
PERCENTAGE=$(echo $(echo "${USED_SPACE} * 100" | bc -l) / "${TOTAL_SPACE}" | bc -l)

# Percentage bar
BAR="<bar>${PERCENTAGE}</bar>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="Usage:\\t\\t${USED_SPACE} / ${TOTAL_SPACE} GB\\n"
############# !!!!!!!!!!!!!!!!!!! IMPORTANT !!!!!!!!!!!!!!! ####################
# Append the following line to /etc/sudoers (Recommended: edit with visudo)
# %wheel ALL=(ALL) NOPASSWD: /usr/bin/hddtemp
# If you don't do the above, xfce4-panel will freeze and
# eventually will freeze X too and maybe PAM as well. So, be careful!
MORE_INFO+="Temperature:\\t${GET_TEMP} ℃"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Bar print
echo -e "${BAR}"

# Tooltip Print
echo -e "${MORE_INFO}"
