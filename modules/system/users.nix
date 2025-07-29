{ pkgs, lib, ... }:

{
  users.users = {
    bigmat18 = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" "audio" "jackaudio" "docker"];

      packages = with pkgs; [ 
        # === Sistema e utilità ===
        light
        brightnessctl
        dconf

        killall
        wget
        unzip
        unrar
        linuxKernel.packages.linux_zen.perf
        xclip
        wl-clipboard

        # === Produttività e sviluppo ===
        via
        obsidian
        smartgit
        vscode
        meshlab-unstable
        rclone
        nvtopPackages.nvidia

        # === Multimedia e comunicazione ===
        mpv
        discord-canary

        # ==== lstopo command with graphics ==== 
        cairo
        (hwloc.overrideAttrs (old: {
          configureFlags = old.configureFlags or [] ++ [
            "--enable-cairo"
            "--enable-x11"
          ];
          buildInputs = (old.buildInputs or []) ++ [ cairo xorg.libX11 pkg-config ];
        }))
        # ==== lstopo command with graphics ====
      ];
    };
  };
}
