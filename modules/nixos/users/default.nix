{ pkgs, vars, ... }:

{
  users.users = {
    ${vars.username} = {
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
        wineWow64Packages.stable
        dxvk
        vkd3d

        # ==== lstopo command with graphics ==== 
        cairo
        (hwloc.overrideAttrs (old: {
          configureFlags = old.configureFlags or [] ++ [
            "--enable-cairo"
          ];
          buildInputs = (old.buildInputs or []) ++ [ cairo pkg-config ];
        }))
      ];
    };
  };
}
