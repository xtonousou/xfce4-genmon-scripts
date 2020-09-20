#!/usr/bin/env bash
# Dependencies: adb, bash>=3.2, coreutils, gawk and a smartwatch :)

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icons to display before the text
# Insert the absolute path of the icons
# Recommended size is 24x24 px
declare -ra ICON_ARRAY=(
  "${DIR}/icons/battery/battery-unknown.png"      # unknown state
  "${DIR}/icons/battery/battery-0.png"            # less than 10%
  "${DIR}/icons/battery/battery-10.png"           # 10%
  "${DIR}/icons/battery/battery-20.png"           # 20%
  "${DIR}/icons/battery/battery-30.png"           # 30%
  "${DIR}/icons/battery/battery-40.png"           # 40%
  "${DIR}/icons/battery/battery-50.png"           # 50%
  "${DIR}/icons/battery/battery-60.png"           # 60%
  "${DIR}/icons/battery/battery-70.png"           # 70%
  "${DIR}/icons/battery/battery-80.png"           # 80%
  "${DIR}/icons/battery/battery-90.png"           # 90%
  "${DIR}/icons/battery/battery-100.png"          # 100%
  "${DIR}/icons/battery/battery-charging-20.png"  # battery charging, 20%
  "${DIR}/icons/battery/battery-charging-30.png"  # battery charging, 30%
  "${DIR}/icons/battery/battery-charging-40.png"  # battery charging, 40%
  "${DIR}/icons/battery/battery-charging-60.png"  # battery charging, 60%
  "${DIR}/icons/battery/battery-charging-80.png"  # battery charging, 80%
  "${DIR}/icons/battery/battery-charging-90.png"  # battery charging, 90%
  "${DIR}/icons/battery/battery-charging-100.png" # battery charging, 100%
)

readonly STATS_FILE="${DIR}/.stats_adb_info_battery_ticwatch"  # replace the word tickwatch with the 3rd argument of the crontab
readonly ADB=$(cat "${STATS_FILE}")
readonly BATTERY=$(awk -F': ' '/level/{print $2}' <<< "${ADB}")

# Panel
# Proper icon handling
INFO=
if ! grep -i powered <<< "${ADB}" | grep -i true &> /dev/null; then # if AC adapter is offline
  if [ "${BATTERY}" -lt 10 ]; then # if battery is less than 10%
    if [[ $(file -b "${ICON_ARRAY[1]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[1]}</img>"
    fi
  elif [ "${BATTERY}" -ge 10 ] && [ "${BATTERY}" -lt 20 ]; then # if battery is >= 10% and < 20%
    if [[ $(file -b "${ICON_ARRAY[2]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[2]}</img>"
    fi
  elif [ "${BATTERY}" -ge 20 ] && [ "${BATTERY}" -lt 30 ]; then # if battery is >= 20% and < 30%
    if [[ $(file -b "${ICON_ARRAY[3]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[3]}</img>"
    fi
  elif [ "${BATTERY}" -ge 30 ] && [ "${BATTERY}" -lt 40 ]; then # if battery is >= 30% and < 40%
    if [[ $(file -b "${ICON_ARRAY[4]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[4]}</img>"
    fi
  elif [ "${BATTERY}" -ge 40 ] && [ "${BATTERY}" -lt 50 ]; then # if battery is >= 40% and < 50%
    if [[ $(file -b "${ICON_ARRAY[5]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[5]}</img>"
    fi
  elif [ "${BATTERY}" -ge 50 ] && [ "${BATTERY}" -lt 60 ]; then # if battery is >= 50% and < 60%
    if [[ $(file -b "${ICON_ARRAY[6]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[6]}</img>"
    fi
  elif [ "${BATTERY}" -ge 60 ] && [ "${BATTERY}" -lt 70 ]; then # if battery is >= 60% and < 70%
    if [[ $(file -b "${ICON_ARRAY[7]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[7]}</img>"
    fi
  elif [ "${BATTERY}" -ge 70 ] && [ "${BATTERY}" -lt 80 ]; then # if battery is >= 70% and < 80%
    if [[ $(file -b "${ICON_ARRAY[8]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[8]}</img>"
    fi
  elif [ "${BATTERY}" -ge 80 ] && [ "${BATTERY}" -lt 90 ]; then # if battery is >= 80% and < 90%
    if [[ $(file -b "${ICON_ARRAY[9]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[9]}</img>"
    fi
  elif [ "${BATTERY}" -ge 90 ] && [ "${BATTERY}" -lt 100 ]; then # if battery is >= 90% and < 100%
    if [[ $(file -b "${ICON_ARRAY[10]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[10]}</img>"
    fi
  elif [ "${BATTERY}" -eq 100 ]; then # if battery is fully charged
    if [[ $(file -b "${ICON_ARRAY[11]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[11]}</img>"
    fi
  fi
else
  if [ "${BATTERY}" -lt 15 ]; then # if battery is less than 15%
    if [[ $(file -b "${ICON_ARRAY[12]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[12]}</img>"
    fi
  elif [ "${BATTERY}" -ge 15 ] && [ "${BATTERY}" -lt 30 ]; then # if battery is >= 15% and < 30%
    if [[ $(file -b "${ICON_ARRAY[13]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[13]}</img>"
    fi
  elif [ "${BATTERY}" -ge 30 ] && [ "${BATTERY}" -lt 55 ]; then # if battery is >= 30% and < 55%
    if [[ $(file -b "${ICON_ARRAY[14]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[14]}</img>"
    fi
  elif [ "${BATTERY}" -ge 55 ] && [ "${BATTERY}" -lt 70 ]; then # if battery is >= 55% and < 70%
    if [[ $(file -b "${ICON_ARRAY[15]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[15]}</img>"
    fi
  elif [ "${BATTERY}" -ge 70 ] && [ "${BATTERY}" -lt 85 ]; then # if battery is >= 60% and < 85%
    if [[ $(file -b "${ICON_ARRAY[16]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[16]}</img>"
    fi
  elif [ "${BATTERY}" -ge 85 ] && [ "${BATTERY}" -lt 100 ]; then # if battery is >= 85% and < 100%
    if [[ $(file -b "${ICON_ARRAY[17]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[17]}</img>"
    fi
  elif [ "${BATTERY}" -eq 100 ]; then # if battery is fully charged
    if [[ $(file -b "${ICON_ARRAY[18]}") =~ PNG|SVG ]]; then # check if the icon exists and it is a .png or .svg image
      INFO="<img>${ICON_ARRAY[18]}</img>"
    fi
  fi
fi

INFO+="<txt>"
if ! grep -i powered <<< "${ADB}" | grep -i true &> /dev/null; then # if AC adapter is offline
  if [ "${BATTERY}" -lt 10 ]; then # if battery is less than 10%
    INFO+="<span weight='Bold' fgcolor='White' bgcolor='Red'>" # make the text bold red
  else
    INFO+="<span weight='Regular' fgcolor='White'>" # make the text white
  fi
else # if AC adapter is online
  INFO+="<span weight='Bold' fgcolor='Light Green'>" # make the text bold light green
fi
INFO+="${BATTERY}%"
INFO+="</span>"
INFO+="</txt>"

# Panel Print
echo -e "${INFO}"
