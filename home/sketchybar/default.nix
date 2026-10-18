{
  config,
  pkgs,
  lib,
  vars,
  ...
}:

let
  toArgb = hex: "0xff" + (lib.removePrefix "#" hex);

  c = {
    bg = toArgb vars.colorscheme.base00;
    fg = toArgb vars.colorscheme.base04;
    urgent = toArgb (vars.colorscheme.base08 or "fb4934");
    border = toArgb vars.colorscheme.base04;
  };
in
{
  home.packages = with pkgs; [
    osx-cpu-temp
  ];

  home.file = {
    ".config/sketchybar/sketchybarrc" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh

        sketchybar --bar --remove "/.*/"

        sketchybar --bar \
          height=32 \
          position=top \
          color="${c.bg}" \
          border_color="${c.border}" \
          border_width=1 \
          corner_radius=0 \
          margin=0 \
          y_offset=0 \
          padding_left=0 \
          padding_right=0

        sketchybar --default \
          label.font="DejaVu Sans Mono:Regular:13.0" \
          icon.font="DejaVu Sans Mono:Bold:13.0" \
          label.color="${c.fg}" \
          icon.color="${c.fg}" \
          background.corner_radius=0 \
          background.height=32

        for i in 1 2 3 4 5 6 7 8 9; do
          sketchybar --add space space.$i left \
            --set space.$i \
              associated_space=$i \
              icon="$i" \
              icon.padding_left=14 \
              icon.padding_right=14 \
              label.drawing=off \
              background.color=0x00000000 \
              script="~/.config/sketchybar/plugins/space.sh" \
            --subscribe space.$i space_change
        done

        sep() {
          sketchybar --add item "sep_$1" right \
            --set "sep_$1" \
              label="|" \
              label.color="${c.fg}" \
              label.padding_left=2 \
              label.padding_right=2 \
              background.drawing=off
        }

        sketchybar --add item clock right \
          --set clock \
            update_freq=1 \
            icon.drawing=off \
            label.padding_left=12 \
            label.padding_right=12 \
            script='sketchybar --set "$NAME" label="$(date "+%A %d/%m/%Y %H:%M:%S")"'
        sep "1"

        sketchybar --add item volume right \
          --set volume \
            update_freq=1 \
            icon.drawing=off \
            label.padding_left=12 \
            label.padding_right=12 \
            script="~/.config/sketchybar/plugins/volume.sh" \
          --subscribe volume volume_change
        sep "2"

        sketchybar --add item network right \
          --set network \
            update_freq=5 \
            icon.drawing=off \
            label.padding_left=12 \
            label.padding_right=12 \
            script="~/.config/sketchybar/plugins/network.sh"
        sep "3"

        sketchybar --add item cpu right \
          --set cpu \
            update_freq=5 \
            icon.drawing=off \
            label.padding_left=12 \
            label.padding_right=12 \
            script="~/.config/sketchybar/plugins/cpu.sh"
        sep "4"

        sketchybar --add item temp right \
          --set temp \
            update_freq=5 \
            icon.drawing=off \
            label.padding_left=12 \
            label.padding_right=12 \
            script="~/.config/sketchybar/plugins/temp.sh"
        sep "5"

        sketchybar --add item battery right \
          --set battery \
            update_freq=30 \
            icon.drawing=off \
            label.padding_left=12 \
            label.padding_right=12 \
            script="~/.config/sketchybar/plugins/battery.sh" \
          --subscribe battery power_source_change system_woke

        sketchybar --update
      '';
    };

    ".config/sketchybar/plugins/space.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        if [ "$SELECTED" = "true" ]; then
          sketchybar --set "$NAME" \
            background.color="${c.fg}" \
            icon.color="${c.bg}"
        else
          sketchybar --set "$NAME" \
            background.color=0x00000000 \
            icon.color="${c.fg}"
        fi
      '';
    };

    ".config/sketchybar/plugins/volume.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        MUTED=$(osascript -e "output muted of (get volume settings)")
        if [ "$MUTED" = "true" ]; then
          sketchybar --set "$NAME" label="VOL muted"
        else
          VOL=$(osascript -e "output volume of (get volume settings)")
          sketchybar --set "$NAME" label="VOL ''${VOL}%"
        fi
      '';
    };

    ".config/sketchybar/plugins/network.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        SSID=$(networksetup -getairportnetwork en0 2>/dev/null | awk -F': ' '{print $2}')
        if [ -n "$SSID" ] && [ "$SSID" != "You are not associated with an AirPort network." ]; then
          sketchybar --set "$NAME" label="$SSID"
        else
          ETH_IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)
          if [ -n "$ETH_IP" ]; then
            sketchybar --set "$NAME" label="ETH $ETH_IP"
          else
            sketchybar --set "$NAME" label="W: down"
          fi
        fi
      '';
    };

    ".config/sketchybar/plugins/cpu.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        CPU_USAGE=$(top -l 1 -n 0 | awk '/CPU usage/ {print $3}' | tr -d '%')
        sketchybar --set "$NAME" label="Body Fat: ''${CPU_USAGE}%"
      '';
    };

    ".config/sketchybar/plugins/temp.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        if command -v osx-cpu-temp >/dev/null 2>&1; then
          TEMP=$(osx-cpu-temp | tr -d '°C ')
        else
          TEMP="45"
        fi
        sketchybar --set "$NAME" label="Your Mom Temp: ''${TEMP}°C"
      '';
    };

    ".config/sketchybar/plugins/battery.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        PERCENT=$(pmset -g batt | grep -Eo "\d+%" | tr -d '%')
        CHARGING=$(pmset -g batt | grep 'AC Power')

        if [ -n "$CHARGING" ]; then
          sketchybar --set "$NAME" label="CHR ''${PERCENT}%"
        else
          sketchybar --set "$NAME" label="BAT ''${PERCENT}%"
        fi
      '';
    };
  };
}
