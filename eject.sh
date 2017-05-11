#!/usr/bin/env bash
# Dependencies: coreutils, gawk, gksu, util-linux, zenity

declare DRIVES_ARRAY=($(df --sync --output=source | awk '/^\/dev\//{print $1}' | sort -V))
declare FSTYPE_ARRAY=($(df --sync --output=source,fstype | sort -V | awk '/^\/dev\//{print $2}'))
declare MNTPOINT_ARRAY=($(df --sync --output=source,target | sort -V | awk '/^\/dev\//{print $2}'))
declare TO_BE_MOUNTED_ARRAY

# zenity GUI
CHOICES=$(zenity --list --width 512 --height 256 \
  --checklist --column "Unmount" --column "Source" --column "Filesystem" \
  --column "Mountpoint" \
  $(for ITEM in "${!DRIVES_ARRAY[@]}"; do \
      echo 0 "${DRIVES_ARRAY[ITEM]}" "${FSTYPE_ARRAY[ITEM]}" "${MNTPOINT_ARRAY[ITEM]}"; \
    done
  )
)

# Pass selected sources to be mounted on an array
IFS='|' read -r -a TO_BE_MOUNTED_ARRAY <<< "${CHOICES}"

for SOURCE in "${TO_BE_MOUNTED_ARRAY[@]}"; do
  if ! hash udisks &> /dev/null; then
    udisksctl unmount -b "${SOURCE}" &> /dev/null
    udisksctl power-off -b "${SOURCE//[0-9]/}" &> /dev/null
  else
    udisks --unmount "${SOURCE}" &> /dev/null
    udisks --detach "${SOURCE//[0-9]/}" &> /dev/null
  fi
done
