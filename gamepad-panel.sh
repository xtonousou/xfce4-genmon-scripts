#!/usr/bin/env bash
# Dependencies: coreutils, gawk

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
readonly ICON="${DIR}/icons/gamepad/gamepad.png"

# Optionally specify the address of the gamepad that you want to display on panel
# If the variable is not specified, the first gamepad found will be displayed instead
# If there are more than one devices, these ones will be displayed on tooltip
NAME=  # specify here optionally: e.g. 38:c0:96:44:cd:db

# Panel
if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
    INFO="<img>${ICON}</img>"
    INFO+="<txt>"
else
    INFO="<txt>"
    INFO+="Icon is missing!"
fi

# Tooltip
MORE_INFO="<tool>"

for GAMEPAD in $(find /sys/class/power_supply/*_controller_battery_* 2>/dev/null); do
    if [[ -n "${NAME}" ]]; then
        if grep -q "${NAME}" <<< "${GAMEPAD}" &>/dev/null; then
            INFO+="$(awk -F'=' '/POWER_SUPPLY_CAPACITY/{print $2}' "${GAMEPAD}/uevent")% "
        fi
        unset NAME
    else
        INFO+="$(awk -F'=' '/POWER_SUPPLY_CAPACITY/{print $2}' "${GAMEPAD}/uevent")% "
    fi

    MORE_INFO+="Gamepad: $(awk -F'=' '/POWER_SUPPLY_NAME/{print $2}' "${GAMEPAD}/uevent")\n"
    MORE_INFO+="Battery: $(awk -F'=' '/POWER_SUPPLY_CAPACITY/{print $2}' "${GAMEPAD}/uevent")%\n"
done

INFO="${INFO## }"  # remove trailing spaces
INFO+="</txt>"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
