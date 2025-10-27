{ pkgs, lib, ... }:

{
  users.users = {
    bigmat18 = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ 
        "wheel" "networkmanager" "audio" "jackaudio" 
        "docker" "libvirtd" "kvm" "qemu-libvirtd" "podman"
      ];

      # subUidRanges = [ { startUid = 1000; count = 65536; } ];
      # subGidRanges = [ { startGid = 1000; count = 65536; } ];
      
      packages = with pkgs; [ 
        # === Sistema e utilità ===
        xdotool
        dconf

        killall
        wget
        unzip
        unrar
        perf
        xclip
        wl-clipboard

        # === Produttività e sviluppo ===
        via
        obsidian
        smartgit
        vscode
        scrcpy
        android-tools
        deskreen
        prismlauncher

        meshlab
        nvtopPackages.nvidia
        btop
        htop

        # === Multimedia e comunicazione ===
        mpv

        # === Wine setup ===
        wineWowPackages.stable
        dxvk
        vkd3d

        # ==== lstopo command with graphics ==== 
        cairo
        (hwloc.overrideAttrs (old: {
          configureFlags = old.configureFlags or [] ++ [
            "--enable-cairo"
            "--enable-x11"
          ];
          buildInputs = (old.buildInputs or []) ++ [ cairo xorg.libX11 pkg-config ];
        }))
      ];
    };
  };
}
