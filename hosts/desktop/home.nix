{ config, pkgs, ... }:

{
  imports = [
    ../../home
    ../../home/obs-studio
  ];

  home.file.".config/i3status/cpu_temp.sh" = {
    text = ''
      #!/usr/bin/env bash
      TEMP=$(sensors | awk '/k10temp-pci-00c3/,/^$/' | grep 'Tctl:' | awk '{print $2}')
      echo "$TEMP"
    '';
    executable = true;
  };

  home.file.".config/i3status/i3status-wrapper.sh" = {
    text = ''
      #!/usr/bin/env bash
      i3status | while :
      do
        read line
        custom_output=$(${config.home.homeDirectory}/.config/i3status/cpu_temp.sh)
        line=''${line//custom_tmp/$custom_output}
        echo "$line"
      done
    '';
    executable = true;
  };

  # xsession.windowManager.i3.config.bars.statusCommand = "${config.home.homeDirectory}/.config/i3status/i3status-wrapper.sh";        

  services.i3.startupCommands = [
    {
      command = "xrandr --output HDMI-0 --rotate inverted &&" +
                "xrandr --output DP-0 --rotate inverted &&" +
                "xrandr --output DP-0 --left-of HDMI-0";
    }
  ];
}