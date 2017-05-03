#!/usr/bin/env bash
# Dependencies: coreutils, gksu, util-linux, procps-ng, zenity

readonly TITLE="Clean Memory"
readonly TITLE_="Confirmation Message"
readonly DESCRIPTION="If you have to clear the disk cache, the first option is the safest in enterprise and production.\nIt is not recommended to use the third option in production unless you know what you are doing, as it will clear everything."
readonly DESCRIPTION_="Are you sure?"
readonly OPTION_ONE="PageCache"
readonly OPTION_TWO="Dentries and inodes"
readonly OPTION_THREE="PageCache, dentries and inodes"
readonly OPTION_FOUR="Swap"

# zenity GUI
readonly CHOICE=$(zenity --height 256 --title "${TITLE}" --text "${DESCRIPTION}" --list --radiolist \
  --column "Option" --column "Clear" \
  1 "${OPTION_ONE}" 2 "${OPTION_TWO}" 3 "${OPTION_THREE}" 4 "${OPTION_FOUR}")

case "${CHOICE}" in
  "${OPTION_ONE}")
    gksu "sysctl vm.drop_caches=1"
  ;;
  "${OPTION_TWO}")
    gksu "sysctl vm.drop_caches=2"
  ;;
  "${OPTION_THREE}")
    if zenity --width 192 --question --title "${TITLE_}" --text "${DESCRIPTION_}"; then
      gksu "sysctl vm.drop_caches=3"
    fi
  ;;
  "${OPTION_FOUR}")
    if zenity --width 192 --question --title "${TITLE_}" --text "${DESCRIPTION_}"; then
      gksu "swapoff --all && swapon --all"
    fi
  ;;
esac
