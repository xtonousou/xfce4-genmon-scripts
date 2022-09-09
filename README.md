### xfce4-genmon-scripts

![preview-panel]

> Beautify your XFCE panel by addding these awesome scripts in xfce4-genmon-plugin wrappers.

#### Preview

| Filename                         | Preview      | Tooltip Preview    | On Click Action               |
|:--------------------------------:|:------------:|:------------------:|:-----------------------------:|
| [smart-watch-battery-panel.sh]   | ![swbattery] |                    |                               |
| [battery-panel.sh]               | ![battery]   | [battery-tooltip]  | [battery-gui]                 |
| [cleaner-panel.sh]               | ![cleaner]   |                    | [cleaner-gui] [cleaner-gui-2] |
| [cpu-panel.sh]                   | ![cpu]       | [cpu-tooltip]      | [cpu-gui]                     |
| [datetime-panel.sh]              | ![datetime]  | [datetime-tooltip] |                               |
| [die-panel.sh]                   | ![die]       |                    |                               |
| [disk-panel.sh]                  | ![disk]      | [disk-tooltip]     |                               |
| [eject-panel.sh]                 | ![eject]     |                    | [eject-gui]                   |
| [kernel-panel.sh]                | ![kernel]    | [kernel-tooltip]   |                               |
| [memory-panel.sh]                | ![memory]    | [memory-tooltip]   | [memory-gui]                  |
| [network-panel.sh]               | ![network]   | [network-tooltip]  |                               |
| [pacman-panel.sh]                | ![pacman]    | [pacman-tooltip]   |                               |
| [power-panel.sh]                 | ![power]     |                    | [power-gui]                   |
| [spotify-panel.sh]               | ![spotify]   | [spotify-tooltip]  | Gain focus on spotify window  |

##### Recommended Properties

To get started, you need a horizontal xfce4-panel with **28p** row size and **100%** length (recommended, suits better).

| Command                                | Font                      | Period (s) |
|---------------------------------------:|:-------------------------:|:----------:|
| /path/to/smart-watch-battery-panel.sh  | **xos4 Terminus Bold 18** |  **30**    |
| /path/to/battery-panel.sh              | **xos4 Terminus Bold 18** |  **1.75**  |
| /path/to/cleaner-panel.sh              | **xos4 Terminus Bold 18** |  **3600**  |
| /path/to/cpu-panel.sh                  | **xos4 Terminus Bold 18** |  **1.50**  |
| /path/to/datetime-panel.sh             | **xos4 Terminus Bold 18** |  **1.00**  |
| /path/to/die-panel.sh                  | **xos4 Terminus Bold 18** |  **2.75**  |
| /path/to/disk-panel.sh                 | **xos4 Terminus Bold 18** |  **5.00**  |
| /path/to/eject-panel.sh                | **xos4 Terminus Bold 18** |  **3600**  |
| /path/to/kernel-panel.sh               | **xos4 Terminus Bold 18** |  **3600**  |
| /path/to/memory-panel.sh               | **xos4 Terminus Bold 18** |  **1.00**  |
| /path/to/network-panel.sh              | **xos4 Terminus Bold 18** |  **2.25**  |
| /path/to/pacman-panel.sh               | **xos4 Terminus Bold 18** |  **3600**  |
| /path/to/power-panel.sh                | **xos4 Terminus Bold 18** |  **3600**  |
| /path/to/spotify-panel.sh              | **xos4 Terminus Bold 18** |  **1.00**  |

#### Requirements

You just need `xfce4-panel` and `xfce4-genmon-plugin`. Additional requirements are mentioned inside the scripts.

#### Installation

Clone the project `git clone --depth 1 https://github.com/xtonousou/xfce4-genmon-scripts.git`.

Add one **Generic Monitor** for each widget and place it wherever you want.

Finally, edit its properties and add `bash /full/path/to/widget-panel.sh`. For suggested period(s) and fonts, refer to "Recommended Properties"

*TIP: Monitor the CPU and Memory usage of its widget (Generic Monitor) and adjust its properties (increase period)*

#### Icons

The icons that are packaged with this software are part of the [MaterialDesign](https://github.com/templarian/MaterialDesign) project.
These icons are provided **as-is** without any change.

Please refer [here](https://github.com/Templarian/MaterialDesign/blob/master/LICENSE) for the respective license.

#### Workarounds

##### Smart Watch Battery Panel

In order to use `smart-watch-battery-panel.sh` you need to use a crontab or a systemd timer to generate the required information.

```bash
crontab -e
* * * * * /usr/bin/env bash /path/to/xfce4-genmon-scripts/adb-info.sh $(arp -e -n | awk "/98:28:a6:dd:00:8c/{print \$1}") battery ticwatch
```

1. Replace the MAC address with the correct one. Hint: Use `arp -n -a` to get the MAC address.
2. Replace the 3rd argument **ticwatch**, with a unique name that describes your device.

#### License

This project is licensed under GPL(v3) or later.

<!--- Script Paths -->
[smart-watch-battery-panel.sh]: smart-watch-battery-panel.sh
[battery-panel.sh]: battery-panel.sh
[cleaner-panel.sh]: cleaner-panel.sh
[cpu-panel.sh]: cpu-panel.sh
[datetime-panel.sh]: datetime-panel.sh
[die-panel.sh]: die-panel.sh
[disk-panel.sh]: disk-panel.sh
[eject-panel.sh]: eject-panel.sh
[kernel-panel.sh]: kernel-panel.sh
[memory-panel.sh]: memory-panel.sh
[network-panel.sh]: network-panel.sh
[pacman-panel.sh]: pacman-panel.sh
[power-panel.sh]: power-panel.sh
[spotify-panel.sh]: spotify-panel.sh

<!--- Pics -->
[preview-panel]: previews/preview-panel.png "xfce4-panel"
[swbattery]: previews/smart-watch-battery-panel/swbattery.png "smart watch battery"
[battery]: previews/battery-panel/battery.gif "battery"
[battery-tooltip]: previews/battery-panel/battery-tooltip.gif "battery-tooltip"
[battery-gui]: previews/battery-panel/battery-gui.png "battery-gui"
[cleaner]: previews/cleaner-panel/cleaner.png "cleaner"
[cleaner-gui]: previews/cleaner-panel/cleaner-gui.png "cleaner-gui"
[cleaner-gui-2]: previews/cleaner-panel/cleaner-gui-2.png "cleaner-gui-2"
[cpu]: previews/cpu-panel/cpu.gif "cpu"
[cpu-tooltip]: previews/cpu-panel/cpu-tooltip.gif "cpu-tooltip"
[cpu-gui]: previews/cpu-panel/cpu-gui.png "cpu-gui"
[datetime]: previews/datetime-panel/datetime.gif "datetime"
[datetime-tooltip]: previews/datetime-panel/datetime-tooltip.png "datetime-tooltip"
[die]: previews/die-panel/die.gif "die"
[disk]: previews/disk-panel/disk.png "disk"
[disk-tooltip]: previews/disk-panel/disk-tooltip.png "disk-tooltip"
[eject]: previews/eject-panel/eject.png "eject"
[eject-gui]: previews/eject-panel/eject-gui.png "eject-gui"
[kernel]: previews/kernel-panel/kernel.png "kernel"
[kernel-tooltip]: previews/kernel-panel/kernel-tooltip.png "kernel-tooltip"
[memory]: previews/memory-panel/memory.gif "memory"
[memory-tooltip]: previews/memory-panel/memory-tooltip.gif "memory-tooltip"
[memory-gui]: previews/memory-panel/memory-gui.png "memory-gui"
[network]: previews/network-panel/network.gif "network"
[network-tooltip]: previews/network-panel/network-tooltip.png "network-tooltip"
[pacman]: previews/pacman-panel/pacman.png "pacman"
[pacman-tooltip]: previews/pacman-panel/pacman-tooltip.png "pacman-tooltip"
[power]: previews/power-panel/power.png "power"
[power-gui]: previews/power-panel/power-gui.png "power-gui"
[spotify]: previews/spotify-panel/spotify.gif "spotify"
[spotify-tooltip]: previews/spotify-panel/spotify-tooltip.png "spotify-tooltip"
