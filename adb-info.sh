#!/usr/bin/env bash

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "${2}" in
	battery)
		adb -s "${1}" shell dumpsys battery 2>&1 >| "${DIR}/.stats_adb_info_battery_${3}"
		;;
esac

