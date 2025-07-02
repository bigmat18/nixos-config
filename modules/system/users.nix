{ pkgs, lib, ... }:

{
  users.users = {
    bigmat18 = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [];

      packages = with pkgs; [ 
        # === Sistema e utilità ===
        light
        brightnessctl
        dconf
        killall
        wget
        unzip
        unrar
        htop
        bear
        fastfetch
        linuxKernel.packages.linux_zen.perf
        xclip
        wl-clipboard
        via

        # === Produttività e sviluppo ===
        obsidian
        smartgit
        vscode
        meshlab-unstable
        rclone

        # === Multimedia e comunicazione ===
        mpv
        firefox
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
