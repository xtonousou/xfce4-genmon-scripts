#!/usr/bin/env bash

readonly TITLE="Clean Memory"
readonly TITLE_="Confirmation Message"
readonly DESCRIPTION="If you have to clear the disk cache, the first option is the safest in enterprise and production.\nIt is not recommended to use the third option in production unless you know what you are doing, as it will clear everything."
readonly DESCRIPTION_="Are you sure?"
readonly OPTION_ONE="PageCache"
readonly OPTION_TWO="Dentries and inodes"
readonly OPTION_THREE="PageCache, dentries and inodes"
readonly OPTION_FOUR="Swap"

CHOICE=$(zenity --height 256 --title "${TITLE}" --text "${DESCRIPTION}" --list --radiolist \
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
      zenity --width 192 --question --title "${TITLE_}" --text "${DESCRIPTION_}"
      if [[ "${?}" -eq 0 ]]; then
        gksu "sysctl vm.drop_caches=3"
      fi
    ;;
    "${OPTION_FOUR}")
      zenity --width 192 --question --title "${TITLE_}" --text "${DESCRIPTION_}"
      if [[ "${?}" -eq 0 ]]; then
        gksu "swapoff --all && swapon --all"
      fi
    ;;
esac
