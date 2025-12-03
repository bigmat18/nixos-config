{ pkgs, lib, username, ... }:

{
  users.users = {
    ${username} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
      
      packages = with pkgs; [ 
        # === General applications ===
        via
        obsidian
        smartgit
        vscode
        scrcpy
        android-tools
        prismlauncher
        discord
        google-chrome
        meshlab
        nvtopPackages.nvidia
        distrobox
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
